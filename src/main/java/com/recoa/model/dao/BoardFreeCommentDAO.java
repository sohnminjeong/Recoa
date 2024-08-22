package com.recoa.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.BoardFreeComment;

@Repository
public class BoardFreeCommentDAO {
	
	@Autowired
	private SqlSessionTemplate session;
	
	// 댓글 작성
	public int registerBoardFreeComment(BoardFreeComment vo) {
		return session.insert("boardFreeCommentMapper.registerBoardFreeComment", vo);
	}
}
