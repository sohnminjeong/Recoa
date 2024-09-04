package com.recoa.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.recoa.model.vo.Chat;
import com.recoa.model.vo.ChatRoom;
import com.recoa.model.vo.User;
import com.recoa.service.ChatService;
import com.recoa.service.UserService;

import lombok.extern.java.Log;

@Controller
@Log
public class ChatController {

	@Autowired
	private ChatService service;
	@Autowired
	private UserService userService;
	
	// 채팅방 입장
	@GetMapping("/chat")
	public String chat(Model model, int chatRoomCode) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Chat> chatList = service.viewAllChatting(chatRoomCode);
		
		model.addAttribute("userId", user.getUsername());
		model.addAttribute("chatList", chatList);
		model.addAttribute("chatRoomCode", chatRoomCode);
		
		return "chat/chat";
	}
	
	// 채팅방 생성
	@PostMapping("/insertChatRoom")
	@ResponseBody
	public int insertChatRoom(@RequestParam Map<String, String> map) {
		
		int userNumber1 = Integer.parseInt(map.get("userNumber1"));
		int userNumber2 = Integer.parseInt(map.get("userNumber2"));
		
		ChatRoom vo = new ChatRoom();
		vo.setUserNumber1(userNumber1);
		vo.setUserNumber2(userNumber2);
		
		
		// int는 null값 못 받기 때문에 String으로 변경 
		ChatRoom hasChatRoom = service.checkChatRoom(vo);
		if(hasChatRoom == null) {
			// 톡방이 없는 경우
			service.insertChatRoom(vo);
			System.out.println("새로운 방 코드 :"+vo.getChatRoomCode());
			return vo.getChatRoomCode();
		} else {
			// 기존 방이 있는 경우 
			System.out.println("기존 방 코드 : "+hasChatRoom.getChatRoomCode());
			return hasChatRoom.getChatRoomCode();
		}
	}
	
	// 채팅 생성
	@PostMapping("/insertChatting")
	@ResponseBody
	public boolean insertChatting(@RequestParam Map<String, String> map) {
		int chatRoomCode = Integer.parseInt(map.get("chatRoomCode"));
		String chatMessage = map.get("chatMessage");
		// map_userNumber : 작성자 닉네임
		int userNumber = Integer.parseInt(map.get("userNumber"));
		System.out.println("userNumber : "+userNumber);
		Chat vo = new Chat();
		vo.setChatRoomCode(chatRoomCode);
		vo.setChatMessage(chatMessage);
		vo.setUserNumber(userNumber);
		System.out.println("vo : "+vo);
		int success = service.insertChatting(vo);
		if(success!=0) {
			return true;
		}
		return false;
	}

	
	
}
