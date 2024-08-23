package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.BoardFreeComment;
import com.recoa.model.vo.BoardFreePaging;

@Repository
public class BoardFreeCommentDAO {
	
	@Autowired
	private SqlSessionTemplate session;
	
	// 댓글 작성
	public int registerBoardFreeComment(BoardFreeComment vo) {
		return session.insert("boardFreeCommentMapper.registerBoardFreeComment", vo);
	}
	// 게시물 별 댓글 전체 보기 + 페이징
	public List<BoardFreeComment> viewAllBoardFreeComment(BoardFreePaging paging) {
		return session.selectList("boardFreeCommentMapper.viewAllBoardFreeComment", paging);
	}
	// 페이징 관련 total 수
	public int commentTotal(int freeCode) {
		return session.selectOne("boardFreeCommentMapper.countBoardFreeComment", freeCode);
	}
	
}
