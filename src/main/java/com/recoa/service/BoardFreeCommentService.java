package com.recoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.BoardFreeCommentDAO;
import com.recoa.model.vo.BoardFreeComment;
import com.recoa.model.vo.BoardFreePaging;

@Service
public class BoardFreeCommentService {

	@Autowired
	private BoardFreeCommentDAO dao;
	
	// 댓글 작성
	public int registerBoardFreeComment(BoardFreeComment vo) {
		return dao.registerBoardFreeComment(vo);
	}	
	// 게시물 별 댓글 전체 보기 + 페이징
	public List<BoardFreeComment> viewAllBoardFreeComment(BoardFreePaging paging) {
		paging.setOffset(paging.getCommentLimit()*(paging.getPage()-1));
		return dao.viewAllBoardFreeComment(paging);
	}
	// 페이징 관련 total 수
	public int commentTotal(int freeCode) {
		return dao.commentTotal(freeCode);
	}
}
