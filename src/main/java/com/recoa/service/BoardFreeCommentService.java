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
	// 댓글 삭제 
	public int deleteBoardFreeComment(int freeCommentCode) {
		return dao.deleteBoardFreeComment(freeCommentCode);
	}
	// 댓글 수정
	public int updateBoardFreeComment(BoardFreeComment vo) {
		return dao.updateBoardFreeComment(vo);
	}
	// 댓글 code로 게시물 code 찾기
	public int findFreeCodeByCommentCode(int freeCommentCode) {
		return dao.findFreeCodeByCommentCode(freeCommentCode);
	}
	// 대댓글 작성 
	public int registerReplyComment(BoardFreeComment vo) {
		return dao.registerReplyComment(vo);
	}
	// 대댓글 전체 보기 
	public List<BoardFreeComment> viewAllReplyComment(int commentParentCode){
		return dao.viewAllReplyComment(commentParentCode);
	}
	// 대댓글 삭제 
	public int deleteReplyComment(int freeCommentCode) {
		return dao.deleteReplyComment(freeCommentCode);
	}
}
