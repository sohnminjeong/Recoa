package com.recoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.BoardFreeCommentDAO;
import com.recoa.model.vo.BoardFreeComment;

@Service
public class BoardFreeCommentService {

	@Autowired
	private BoardFreeCommentDAO dao;
	
	// 댓글 작성
	public int registerBoardFreeComment(BoardFreeComment vo) {
		return dao.registerBoardFreeComment(vo);
	}
	// 게시물 별 댓글 전체 보기
	public List<BoardFreeComment> viewAllBoardFreeComment(int freeCode) {
		return dao.viewAllBoardFreeComment(freeCode);
	}
}
