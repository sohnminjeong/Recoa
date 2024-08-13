package com.recoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.BoardFreeDAO;
import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreeImg;

@Service
public class BoardFreeService {

	@Autowired
	private BoardFreeDAO dao;
	
	// 게시물 작성
	public int registerBoardFree(BoardFree vo) {
		return dao.registerBoardFree(vo);
	}
	
	// 게시물 작성 시 이미지 삽입
	public int registerBoarddFreeImg(BoardFreeImg vo) {
		return dao.registerBoardFreeImg(vo);
	}
}
