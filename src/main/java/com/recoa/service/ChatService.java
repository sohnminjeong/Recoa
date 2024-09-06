package com.recoa.service;

import java.util.List;

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
	
	// 삭제 안된 채팅방 + 이미 회원 두명이 일치하는 경우 중복 확인
	public ChatRoom checkChatRoom(ChatRoom vo) {
		return dao.checkChatRoom(vo);
	}
	
	// chat_room_code로 ChatRoom 찾기 
	public ChatRoom chatRoomFindByRoomCode(int chatRoomCode) {
		return dao.chatRoomFindByRoomCode(chatRoomCode);
	}
	
	// 대화 내용 전체 확인 
	public List<Chat> viewAllChatting(int chatRoomCode) {
		return dao.viewAllChatting(chatRoomCode);
	}
}
