package com.recoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.NoteDAO;
import com.recoa.model.vo.Note;
import com.recoa.model.vo.NoteFile;

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
}
