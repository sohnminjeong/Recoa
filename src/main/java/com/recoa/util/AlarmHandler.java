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
		System.out.println("alarm연결");
		sessions.add(session);
		String userId = session.getPrincipal().getName();
		userSessionsMap.put(userId, session);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String userId = session.getPrincipal().getName();
		System.out.println("sessions"+userId);
		String msg = message.getPayload();
		System.out.println("msg = "+msg);
		
		if(StringUtils.isNotEmpty(msg)) {
			System.out.println("if문 들어옴?");
			String[] strs = msg.split(",");
			if(strs!=null) {
				System.out.println("strs : "+strs);
				String cmd = strs[0];
				String replyWriter = strs[1];
				String boardWriter = strs[2];
				String bno = strs[3];
				String title = strs[4];
				String bgno = strs[5];
				System.out.println("length 성공 ? :"+cmd);
				
				WebSocketSession replyWriterSession = userSessionsMap.get(replyWriter);
				WebSocketSession boardWriterSession = userSessionsMap.get(boardWriter);
				System.out.println("boardWriterSEssio : "+userSessionsMap.get(boardWriter));
				System.out.println("boardWriterSession : "+boardWriterSession);
				
				// 댓글
				if("reply".equals(cmd)&&boardWriterSession!=null) {
					System.out.println("?!?!");
					TextMessage tmpMsg = new TextMessage(replyWriter+"님이 "+"<a href='/board/readView?bno="+bno+"&bgno="+bgno+title+" 에 댓글을 달았습니디ㅏ</a>");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("socket 끊음");
		sessions.remove(session);
		String userId = session.getPrincipal().getName();
		userSessionsMap.remove(userId, session);
		
	}

	
}
