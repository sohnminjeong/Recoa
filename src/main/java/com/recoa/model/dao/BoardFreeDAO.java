package com.recoa.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreeImg;

@Repository
public class BoardFreeDAO {

	@Autowired
	private SqlSessionTemplate session;
	
	// 게시물 작성
	public int registerBoardFree(BoardFree vo) {
		return session.insert("boardFreeMapper.registerBoardFree", vo);
	}
	
	// 게시물 작성 시 이미지 삽입
	public int registerBoardFreeImg(BoardFreeImg vo) {
		return session.insert("boardFreeImgMapper.registerBoardFreeImg", vo);
	}
}
