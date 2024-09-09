package com.recoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.ChatDAO;
import com.recoa.model.vo.Chat;
import com.recoa.model.vo.ChatFile;
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
	
	// 파일 첨부 
	public int insertChatFile(ChatFile vo) {
		return dao.insertChatFile(vo);
	}
	
	// 삭제 안된 채팅방 + 이미 회원 두명이 일치하는 경우 중복 확인
	public ChatRoom checkChatRoom(ChatRoom vo) {
		return dao.checkChatRoom(vo);
	}
	
	// userCode로 chatRoom 찾기
	public List<Chat> chatRoomList(int userCode){
		return dao.chatRoomList(userCode);
	}
	
	// chat_room_code로 ChatRoom 찾기 
	public ChatRoom chatRoomFindByRoomCode(int chatRoomCode) {
		return dao.chatRoomFindByRoomCode(chatRoomCode);
	}
	
	// 대화 내용 전체 확인 
	public List<Chat> viewAllChatting(int chatRoomCode) {
		return dao.viewAllChatting(chatRoomCode);
	}
	
	// chatCode로 Chat 찾기
	public Chat viewChattingByChatCode(int chatCode) {
		return dao.viewChattingByChatCode(chatCode);
	}
	
	// chatCode로 파일 리스트 찾기 
	public List<ChatFile> viewChatFileByChatCode(int chatCode){
		return dao.viewChatFileByChatCode(chatCode);
	}
	
	// 채팅 삭제 
	public int deleteChatting(int chatRoomCode) {
		return dao.deleteChatting(chatRoomCode);
	}
	
	//  채팅 파일 삭제 
	public int deleteChatFile(int chatCode) {
		return dao.deleteChatFile(chatCode);
	}
	// 채팅룸 삭제
	public int deleteChatRoom(int chatRoomCode) {
		return dao.deleteChatRoom(chatRoomCode);
	}
}
