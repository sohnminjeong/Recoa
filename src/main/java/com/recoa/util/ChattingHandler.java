package com.recoa.util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.recoa.model.vo.Chat;
import com.recoa.model.vo.User;
import com.recoa.service.ChatService;
import com.recoa.service.UserService;

import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@Log
public class ChattingHandler extends TextWebSocketHandler {

	@Autowired
	private UserService userService;
	
	@Autowired
	private ChatService chatService;
	
	private List<WebSocketSession> sessionList = new ArrayList<>();

	// 채팅 위해 해당 페이지에 들어오면 클라이언트가 연결된 후 해당 클라이언트의 세션을 sessionList에 add
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("session :"+session);
		
		sessionList.add(session);
		System.out.println("sessionLisst : "+sessionList);
	}

	// 서버로 메세지 전송 시, 해당 메서드 호출
	// 현재 웹 소켓 서버에 접속한 session 모두에게 메세지를 전달해야 하므로 loop 돌며 메세지 전송
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		// 작성자 아이디 : session.getPrincipal().getName()
		// 작성자가 쓴 내용 : message.getPayload()
		// 받은 채팅방코드 : message.getPayload().split(":")[1]
		String userId = session.getPrincipal().getName();
		User user = userService.selectUser(userId);
//		String chatRoomCode = null;
//		String payload = message.getPayload();
//		if(payload.contains("chatRoomCode")) {
//			System.out.println("payload.charAt(0) : "+ payload.split(":")[1].split("}")[0]);
//			chatRoomCode =  payload.split(":")[1].split("}")[0];
//		}
		
		Chat vo = new Chat();
		vo.setChatMessage(message.getPayload());
		vo.setChatRoomCode(4);
		vo.setUserNumber(user.getUserCode());
		// chatService.insertChatting(vo);
		System.out.println("vo : "+vo);
	
		
		for(WebSocketSession s : sessionList) {
			// 닉네임으로 보여야하기 때문에 .getPrincipal.getNamge(=userId) 이용하여 nickname 넣기
			s.sendMessage(new TextMessage(user.getUserNickname()+":"+message.getPayload()));
		}
	}

	// 클라이언트와 연결 끊어진 후 (채팅방 나간 경우) remove로 해당 세션 제거
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("sessions ; "+session);
		System.out.println("status ; " +status);
		sessionList.remove(session);
		log.info(session.getPrincipal().getName()+"님이 퇴장하셨습니다.");
	}
	
	
	
}
