package com.recoa.util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.recoa.model.vo.User;
import com.recoa.service.UserService;

import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@Log
public class ChattingHandler extends TextWebSocketHandler {

	@Autowired
	private UserService service;
	
	private List<WebSocketSession> sessionList = new ArrayList<>();

	// 채팅 위해 해당 페이지에 들어오면 클라이언트가 연결된 후 해당 클라이언트의 세션을 sessionList에 add
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	
		log.info("#chattingHandler, afterConneetcion");
		sessionList.add(session);
		log.info(session.getPrincipal().getName()+"님이 입장");
	}

	// 서버로 메세지 전송 시, 해당 메서드 호출
	// 현재 웹 소켓 서버에 접속한 session 모두에게 메세지를 전달해야 하므로 loop 돌며 메세지 전송
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("#ChattingHandler, handleMessage");
		log.info(session.getId()+" : "+message);
		for(WebSocketSession s : sessionList) {
			String userId = session.getPrincipal().getName();
			User user = service.selectUser(userId);
			
			s.sendMessage(new TextMessage(user.getUserNickname()+":"+message.getPayload()));
		}
	}

	// 클라이언트와 연결 끊어진 후 (채팅방 나간 경우) remove로 해당 세션 제거
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("#ChattingHAndler, afterConnectionClosed");
		sessionList.remove(session);
		log.info(session.getPrincipal().getName()+"님이 퇴장하셨습니다.");
	}
	
	
	
}
