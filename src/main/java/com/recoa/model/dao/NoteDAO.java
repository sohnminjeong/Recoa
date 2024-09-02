package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.Note;
import com.recoa.model.vo.NoteFile;
import com.recoa.model.vo.NotePaging;

@Repository
public class NoteDAO {

	@Autowired
	private SqlSessionTemplate session;
	
	// 쪽지 작성 
	public int registerNote(Note vo) {
		return session.insert("noteMapper.registerNote", vo);
	}
	// 쪽지 파일 첨부
	public int registerNoteFile(NoteFile vo) {
		return session.insert("noteFileMapper.registerNoteFile", vo);
	}
	
	// 쪽지 한 개 보기
	public Note oneViewNote(int noteCode) {
		return session.selectOne("noteMapper.oneViewNote", noteCode);
	}
	// 쪽지 파일 전체 보기 
	public List<NoteFile> viewAllNoteFile(int noteCode){
		return session.selectList("noteFileMapper.viewAllNoteFile", noteCode);
	}
		
	
	// 쪽지 전체 보기
	public List<Note> viewAllNote(NotePaging paging) {
		return session.selectList("noteMapper.viewAllNote", paging);
	}
	// 페이징 관련 total 수 
	public int total(int userCode) {
		return session.selectOne("noteMapper.countNote", userCode);
	}
	
	// 보낸 쪽지함 전체 보기
	public List<Note> viewAllBySender(NotePaging paging){
		return session.selectList("noteMapper.viewAllBySender", paging);
	}
	public int countSenderNote(int userCode) {
		return session.selectOne("noteMapper.countSenderNote", userCode);
	}
	
	// 받은 쪽지함 전체 보기
	public List<Note> viewAllByReceiver(NotePaging paging){
		return session.selectList("noteMapper.viewAllByReceiver", paging);
	}
	public int countReceiverNote(int userCode) {
		return session.selectOne("noteMapper.countReceiverNote", userCode);
	}
	
	
}
