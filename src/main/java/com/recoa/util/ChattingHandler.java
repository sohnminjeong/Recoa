package com.recoa.util;


import java.io.File;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.recoa.model.vo.Chat;
import com.recoa.model.vo.ChatFile;
import com.recoa.model.vo.ChatRoom;
import com.recoa.model.vo.User;
import com.recoa.service.ChatService;
import com.recoa.service.UserService;


public class ChattingHandler extends TextWebSocketHandler {

	// 파일 저장
	private String path = "C:\\recoaImg\\chat\\";
	
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
		sessions.add(session);
	}

	// 서버로 메세지 전송 시, 해당 메서드 호출
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		if(message.getPayload().contains("chatFile:")) {
			String[] arr = message.getPayload().split(":");
			String url = arr[1];
			String userNickname = arr[2];
			int chatCode = Integer.parseInt(arr[3]);
			Chat fileContainsChat = chatService.viewChattingByChatCode(chatCode);
			String text = fileContainsChat.getChatMessage();
			int hour = fileContainsChat.getChatTime().getHours();
			int minutes = fileContainsChat.getChatTime().getMinutes();
			
			for ( WebSocketSession s : sessions ) {
				int nowChatRoomCode = (Integer) s.getAttributes().get("chatRoomCode");
				ChatRoom chatRoom = chatService.chatRoomFindByRoomCode(nowChatRoomCode);
				int userNumber1 = chatRoom.getUserNumber1();
				int userNumber2 = chatRoom.getUserNumber2();
				User user1 = userService.findUserByCode(userNumber1);
				User user2 = userService.findUserByCode(userNumber2);
				if(user1.getUserNickname().equals(userNickname)) {
					if ( nowChatRoomCode == fileContainsChat.getChatRoomCode() ) {
						s.sendMessage( new TextMessage( userNickname+":"+text+":"+url+":"+hour+":"+minutes+":"+user2.getUserNickname()));
					}
				} else {
					if ( nowChatRoomCode == fileContainsChat.getChatRoomCode() ) {
						s.sendMessage( new TextMessage( userNickname+":"+text+":"+url+":"+hour+":"+minutes+":"+user1.getUserNickname()));
					}
				}
				
			}
			
		}else {
			
			// 작성자가 쓴 내용 : message.getPayload()
			String userId = session.getPrincipal().getName();
			User user = userService.selectUser(userId);
			
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(message.getPayload());
			int userCode = jsonNode.get("userCode").asInt();
			int chatRoomCode = jsonNode.get("chatRoomCode").asInt();
			String chatMessage = jsonNode.get("chatMessage").asText();
			
			
			if(chatMessage.equals("chatRoomOut")) {
				// 채팅룸 나가기 O
				List<Chat> chatList = chatService.viewAllChatting(chatRoomCode);
				for(int i=0; i<chatList.size(); i++) {
					int chatCode = chatList.get(i).getChatCode();
					List<ChatFile> files = chatService.viewChatFileByChatCode(chatCode);
					if(files!=null) {
						for(ChatFile f : files) {
							File file = new File(path+f.getChatFileUrl());
							file.delete();
						}
						chatService.deleteChatFile(chatCode);
					}
				}
				chatService.deleteChatRoom(chatRoomCode);
			}else {
				Chat chat = new Chat();
				chat.setChatMessage(chatMessage);
				chat.setChatRoomCode(chatRoomCode);
				chat.setUserNumber(userCode);

				//채팅 메시지 DB 삽입
				int result = chatService.insertChatting(chat);
				Chat newChat = chatService.viewChattingByChatCode(chat.getChatCode());
				int hour = newChat.getChatTime().getHours();
				int minutes = newChat.getChatTime().getMinutes();
				
				if(result>0) {
					for ( WebSocketSession s : sessions ) {
						// WebSocketSession == HttpSession (로그인정보,채팅방정보) 을 가로챈것..
						int nowChatRoomCode = (Integer) s.getAttributes().get("chatRoomCode");
						// WebSocketSession에 담겨있는 채팅방 번호와 chat에 담겨있는 채팅방 번호가 같은 경우  === 같은방 클라이언트
						
						ChatRoom chatRoom = chatService.chatRoomFindByRoomCode(nowChatRoomCode);
						int userNumber1 = chatRoom.getUserNumber1();
						int userNumber2 = chatRoom.getUserNumber2();
						User user1 = userService.findUserByCode(userNumber1);
						User user2 = userService.findUserByCode(userNumber2);
						
						if(user.getUserNickname().equals(user1.getUserNickname())) {
							if ( nowChatRoomCode == chat.getChatRoomCode() ) {
								//같은방 클라이언트에게 JSON 형식의 메시지를 보냄 
								s.sendMessage( new TextMessage( user.getUserNickname()+":"+chatMessage+":"+0+":"+hour+":"+minutes+":"+user2.getUserNickname()));
							}
						}else {
							if ( nowChatRoomCode == chat.getChatRoomCode() ) {
								//같은방 클라이언트에게 JSON 형식의 메시지를 보냄 
								s.sendMessage( new TextMessage( user.getUserNickname()+":"+chatMessage+":"+0+":"+hour+":"+minutes+":"+user1.getUserNickname()));
							}
						}
						
					}	
				}						
			}
		}
		
	}


	// 클라이언트와 연결 끊어진 후 (채팅방 나간 경우) remove로 해당 세션 제거
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
		
	}
}
