package com.recoa.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.BoardNotice;
import com.recoa.model.vo.BoardNoticeImg;

@Repository
public class BoardNoticeDAO {
	
	@Autowired
	private SqlSessionTemplate session;
	
	// 공지 작성
	public int registerNotice(BoardNotice notice) {
		return session.insert("BoardNotice.registerNotice", notice);
	}
	
	// 이미지 추가
	public int registerNoticeImg(BoardNoticeImg img) {
		return session.insert("BoardNoticeImg.registerBoardNoticeImg", img);
	}
}
