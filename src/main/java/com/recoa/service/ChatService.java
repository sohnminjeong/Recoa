package com.recoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.ChatDAO;
import com.recoa.model.vo.Chat;
import com.recoa.model.vo.ChatRoom;

@Service
public class ChatService {

	@Autowired
	private ChatDAO dao;
	
	// 채팅방 생성
	public int insertChatRoom(ChatRoom vo) {
		return dao.insertChatRoom(vo);
	}
	
	// 채팅 생성 
	public int insertChatting(Chat vo) {
		return dao.insertChatting(vo);
	}
}
