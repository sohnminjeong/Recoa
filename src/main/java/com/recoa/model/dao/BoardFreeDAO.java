package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreeImg;
import com.recoa.model.vo.BoardFreePaging;

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
	
	// 게시물 전체 보기(페이징+검색)
	public List<BoardFree> listBoardFree(BoardFreePaging paging) {
		return session.selectList("boardFreeMapper.listBoardFree", paging);
	}
	// 페이징 관련 total 수 
	public int total() {
		return session.selectOne("boardFreeMapper.countBoardFree");
	}
	
	// 게시물 한개 보기
	public BoardFree oneBoardFree(int freeCode) {
		return session.selectOne("boardFreeMapper.oneBoardFree", freeCode);
	}
	// 게시물 한개 보기 > 이미지
	public List<BoardFreeImg> oneBoardFreeImg(int freeCode) {
		return session.selectList("boardFreeImgMapper.oneBoardFreeImg", freeCode);
	}
	
	// 게시물 삭제 
	public int deleteBoardFree(int freeCode) {
		return session.delete("boardFreeMapper.deleteBoardFree", freeCode);
	}
	// 게시물 삭제 > 이미지
	public int deleteBoardFreeImg(int freeCode) {
		return session.delete("boardFreeImgMapper.deleteBoardFreeImg", freeCode);
	}
}
