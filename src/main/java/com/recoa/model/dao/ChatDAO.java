package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.Chat;
import com.recoa.model.vo.ChatRoom;

@Repository
public class ChatDAO {

	@Autowired
	private SqlSessionTemplate session;

	// 채팅방 생성
	public int insertChatRoom(ChatRoom vo) {
		return session.insert("chatMapper.insertChatRoom", vo);
	}
	
	// 채팅 생성 
	public int insertChatting(Chat vo) {
		return session.insert("chatMapper.insertChatting", vo);
	}

	// 삭제 안된 채팅방 + 이미 회원 두명이 일치하는 경우 중복 확인
	public ChatRoom checkChatRoom(ChatRoom vo) {
		return session.selectOne("chatMapper.checkChatRoom", vo);
	}
	
	// chat_room_code로 ChatRoom 찾기 
	public ChatRoom chatRoomFindByRoomCode(int chatRoomCode) {
		return session.selectOne("chatMapper.chatRoomFindByRoomCode", chatRoomCode);
	}
	
	// 대화 내용 전체 확인 
	public List<Chat> viewAllChatting(int chatRoomCode) {
		return session.selectList("chatMapper.viewAllChatting", chatRoomCode);
	}
	
	// chatCode로 Chat 찾기
	public Chat viewChattingByChatCode(int chatCode) {
		return session.selectOne("chatMapper.viewChattingByChatCode", chatCode);
	}
	
}
