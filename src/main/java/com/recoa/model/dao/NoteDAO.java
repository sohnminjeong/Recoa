package com.recoa.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.Note;
import com.recoa.model.vo.NoteFile;

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
}
