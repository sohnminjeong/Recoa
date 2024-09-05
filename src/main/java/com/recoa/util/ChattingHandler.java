package com.recoa.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.recoa.model.vo.Chat;
import com.recoa.model.vo.User;
import com.recoa.service.ChatService;
import com.recoa.service.UserService;


public class ChattingHandler extends TextWebSocketHandler {

	@Autowired
	private UserService userService;
	
	@Autowired
	private ChatService chatService;
	
	//private List<WebSocketSession> sessionList = new ArrayList<>();
	//private Map<String, WebSocketSession> userSessions = new HashMap<String, WebSocketSession>();
	
	private Set<WebSocketSession> sessions 
	= Collections.synchronizedSet(new HashSet<WebSocketSession>());
	
	// 채팅 위해 해당 페이지에 들어오면 클라이언트가 연결된 후 해당 클라이언트의 세션을 sessionList에 add
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//System.out.println("sesson.getID.last :"+session.getId().lastIndexOf("/"));
		//System.out.println("입장 session :"+session.getUri().getPath().substring(0));
		
		
		sessions.add(session);
		System.out.println("{}연결됨 :"+session.getAttributes().get("userCode"));
		System.out.println("방코드 ?:"+session.getAttributes().get("chatRoomCode"));
		
	}

	// 서버로 메세지 전송 시, 해당 메서드 호출
	// 현재 웹 소켓 서버에 접속한 session 모두에게 메세지를 전달해야 하므로 loop 돌며 메세지 전송
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		// 작성자 아이디 : session.getPrincipal().getName()
		// 작성자가 쓴 내용 : message.getPayload()
		String userId = session.getPrincipal().getName();
		User user = userService.selectUser(userId);
		
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode jsonNode = objectMapper.readTree(message.getPayload());
		//System.out.println("jsonNode : "+jsonNode);
		int userCode = jsonNode.get("userCode").asInt();
		int chatRoomCode = jsonNode.get("chatRoomCode").asInt();
		String chatMessage = jsonNode.get("chatMessage").asText();
		
		Chat chat = new Chat();
		chat.setChatMessage(chatMessage);
		chat.setChatRoomCode(chatRoomCode);
		chat.setUserNumber(userCode);
		
		//채팅 메시지 DB 삽입
		int result = chatService.insertChatting(chat);
		
		if(result>0) {
			
			for ( WebSocketSession s : sessions ) {
				// WebSocketSession == HttpSession (로그인정보,채팅방정보) 을 가로챈것..
				int nowChatRoomCode = (Integer) s.getAttributes().get("chatRoomCode");
				// WebSocketSession에 담겨있는 채팅방 번호와 chat에 담겨있는 채팅방 번호가 같은 경우  === 같은방 클라이언트
				if ( nowChatRoomCode == chat.getChatRoomCode() ) {
					//같은방 클라이언트에게 JSON 형식의 메시지를 보냄 
					s.sendMessage( new TextMessage( user.getUserNickname()+":"+chatMessage ));
				}
			}	
		}
	}

	// 클라이언트와 연결 끊어진 후 (채팅방 나간 경우) remove로 해당 세션 제거
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("퇴장 sessions ; "+session);
		System.out.println("status : " +status);
		//sessionList.remove(session);
		sessions.remove(session);	
	}
}
