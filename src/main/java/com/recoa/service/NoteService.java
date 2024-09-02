package com.recoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.NoteDAO;
import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreePaging;
import com.recoa.model.vo.Note;
import com.recoa.model.vo.NoteFile;
import com.recoa.model.vo.NotePaging;

@Service
public class NoteService {

	@Autowired
	private NoteDAO dao;
	
	// 쪽지 작성 
	public int registerNote(Note vo) {
		return dao.registerNote(vo);
	}
	// 쪽지 파일 첨부
	public int registerNoteFile(NoteFile vo) {
		return dao.registerNoteFile(vo);
	}
	
	// 쪽지 한 개 보기
	public Note oneViewNote(int noteCode) {
		return dao.oneViewNote(noteCode);
	}
	
	// 쪽지 전체 보기
	public List<Note> viewAllNote(NotePaging paging) {
		paging.setOffset(paging.getLimit()*(paging.getPage()-1));
		return dao.viewAllNote(paging);
	}
	// 페이징 관련 total 수 
	public int total(int userCode) {
		return dao.total(userCode);
	}

	// 쪽지 파일 전체 보기 
	public List<NoteFile> viewAllNoteFile(int noteCode){
		return dao.viewAllNoteFile(noteCode);
	}
}
