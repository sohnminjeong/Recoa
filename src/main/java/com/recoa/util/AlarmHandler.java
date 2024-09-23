package com.recoa.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.recoa.model.vo.Alarm;
import com.recoa.model.vo.User;
import com.recoa.service.AlarmService;
import com.recoa.service.UserService;

public class AlarmHandler extends TextWebSocketHandler {

	@Autowired
	private AlarmService alarmService;
	@Autowired
	private UserService userService;
	
	// 로그인한 인원 전체 
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		sessions.add(session);
		String userId = session.getPrincipal().getName();
		userSessionsMap.put(userId, session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String userId = session.getPrincipal().getName();
		String msg = message.getPayload();
		
		if(StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			if(strs!=null) {
				String cmd = strs[0]; // 댓글, 스크랩 등의 기능 구분
				String replyWriter = strs[1]; // 댓글작성자 닉네임
				String boardWriter = strs[2]; //글작성자 닉네임
				String title = strs[3]; //게시글 제목
				String code = strs[4]; //게시글 번호
				
				int replyWriterCode = userService.findUserCode(replyWriter);
				int boardWriterCode = userService.findUserCode(boardWriter);
				User replyUser = userService.findUserByCode(replyWriterCode);
				User boardUser = userService.findUserByCode(boardWriterCode);
				
				WebSocketSession replyWriterSession = userSessionsMap.get(replyUser.getUserId());
				WebSocketSession boardWriterSession = userSessionsMap.get(boardUser.getUserId());
				
				// db 삽입
				Alarm alarm = new Alarm();
				alarm.setUserCode(boardWriterCode); // 알람 받을 유저 코드
				if("reply".equals(cmd)) {
					alarm.setAlarmTable("자유게시판");
					alarm.setAlarmContent(replyWriter+"님이 "+title+"에 댓글을 달았습니다.");
					alarm.setAlarmUrl("/viewOneBoardFree?freeCode="+code);
				} else if("note".equals(cmd)) {
					alarm.setAlarmTable("쪽지");
					alarm.setAlarmContent(replyWriter+"님이 쪽지를 보냈습니다.");
					alarm.setAlarmUrl("/viewOneNote?noteCode="+code);
				} else if("chat".equals(cmd)) {
					alarm.setAlarmTable("채팅");
					alarm.setAlarmContent(replyWriter+"님이 채팅을 보냈습니다.");
					alarm.setAlarmUrl("/viewListChat?userCode="+boardWriterCode);
				}
				alarmService.registerAlarm(alarm);				
				
				// 댓글
				if("reply".equals(cmd)) {
					TextMessage tmpMsg = new TextMessage("[자유게시판] "+replyWriter+"님이 "+"<a href='/viewOneBoardFree?freeCode="+code+"'>"+title+"</a>"+"에 댓글을 달았습니다.");
					boardWriterSession.sendMessage(tmpMsg);
				} 
				if("note".equals(cmd)) {
					TextMessage tmpMsg = new TextMessage("[쪽지] "+ replyWriter+"님이 "+"<a href='/viewOneNote?noteCode="+code+"'>"+"쪽지"+"</a>"+"를 보냈습니다.");
					boardWriterSession.sendMessage(tmpMsg);
				}
				if("chat".equals(cmd)) {
					TextMessage tmpMsg = new TextMessage("[채팅] "+replyWriter+"님이 "+"<a href='/viewListChat?userCode="+boardWriterCode+"'>"+"채팅"+"</a>"+"을 보냈습니다.");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		sessions.remove(session);
		String userId = session.getPrincipal().getName();
		userSessionsMap.remove(userId, session);
		
	}

	
}
