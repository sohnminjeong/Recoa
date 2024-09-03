package com.recoa.model.dao;

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

	
}
