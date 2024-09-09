package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.Chat;
import com.recoa.model.vo.ChatFile;
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

	// 파일 첨부 
	public int insertChatFile(ChatFile vo) {
		return session.insert("chatMapper.insertChatFile", vo);
	}
	
	
	// 삭제 안된 채팅방 + 이미 회원 두명이 일치하는 경우 중복 확인
	public ChatRoom checkChatRoom(ChatRoom vo) {
		return session.selectOne("chatMapper.checkChatRoom", vo);
	}
	
	// userCode로 chatRoom 찾기
	public List<Chat> chatRoomList(int userCode){
		return session.selectList("chatMapper.chatRoomList", userCode);
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
	
	// chatCode로 파일 리스트 찾기 
	public List<ChatFile> viewChatFileByChatCode(int chatCode){
		return session.selectList("chatMapper.viewChatFileByChatCode", chatCode);
	}
	
	
	// 채팅 삭제 
	public int deleteChatting(int chatRoomCode) {
		return session.delete("chatMapper.deleteChatting", chatRoomCode);
	}
	
	//  채팅 파일 삭제 
	public int deleteChatFile(int chatCode) {
		return session.delete("chatMapper.deleteChatFile", chatCode);
	}
	
	// 채팅룸 삭제
	public int deleteChatRoom(int chatRoomCode) {
		return session.delete("chatMapper.deleteChatRoom", chatRoomCode);
	}
	
}
