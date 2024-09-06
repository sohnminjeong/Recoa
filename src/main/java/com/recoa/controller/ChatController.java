package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.Chat;
import com.recoa.model.vo.ChatRoom;
import com.recoa.model.vo.User;
import com.recoa.service.ChatService;
import com.recoa.service.UserService;

@Controller
public class ChatController {

	@Autowired
	private ChatService service;
	@Autowired
	private UserService userService;
	
	// 파일 저장
	private String path = "C:\\recoaImg\\chat\\";
	
	// 파일 업로드 기능
	public String fileUpload(MultipartFile file) throws IllegalStateException, IOException {
		UUID uuid =UUID.randomUUID();
		String filename = uuid.toString()+"_"+file.getOriginalFilename();
		File copyFile = new File(path+filename);
		file.transferTo(copyFile);
		return filename;
	}
	
	 /* ---------------------------------------------------- */	
	
	// 채팅방 입장
	@GetMapping("/chat")
	public String chat(Model model, int chatRoomCode, HttpServletRequest request) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Chat> chatList = service.viewAllChatting(chatRoomCode);
		
		HttpSession session = request.getSession();
		session.setAttribute("chatRoomCode", chatRoomCode);
		session.setAttribute("userCode", user.getUserCode());
		
		ChatRoom room = service.chatRoomFindByRoomCode(chatRoomCode);
		User sender = userService.findUserByCode(room.getUserNumber1());
		User receiver = userService.findUserByCode(room.getUserNumber2());
		
		if(sender.getUserCode()== user.getUserCode()) {
			model.addAttribute("interlocutor", receiver);
		} else if(receiver.getUserCode()==user.getUserCode()) {
			model.addAttribute("interlocutor", sender);
		}
		
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
			return vo.getChatRoomCode();
		} else {
			// 기존 방이 있는 경우 
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
