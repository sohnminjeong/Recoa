package com.recoa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.recoa.model.vo.Chat;
import com.recoa.model.vo.ChatRoom;
import com.recoa.model.vo.User;
import com.recoa.service.ChatService;

import lombok.extern.java.Log;

@Controller
@Log
public class ChatController {

	@Autowired
	private ChatService service;
	
	@GetMapping("/chat")
	public String chat(Model model) {
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		log.info("==========================");
		log.info("@ChatController, Get Chat/Username : "+user.getUsername());
		model.addAttribute("userId", user.getUsername());
		return "chat/chat";
	}
	
	@PostMapping("/insertChatRoom")
	public String insertChatRoom(ChatRoom vo) {
		service.insertChatRoom(vo);
		return "";
	}
	
	@PostMapping("/insertChatting")
	public String insertChatting(Chat vo) {
		service.insertChatting(vo);
		return "";
	}

	
	
}
