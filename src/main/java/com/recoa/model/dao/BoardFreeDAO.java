package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreeImg;
import com.recoa.model.vo.BoardFreePaging;
import com.recoa.model.vo.FreeLike;
import com.recoa.model.vo.LikedPaging;

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
	// 게시물 조회수 증가
	public int updateFreeView(int freeCode) {
		return session.update("boardFreeMapper.updateFreeView", freeCode);
	}
	
	// 좋아요 추가
	public int insertFreeLike(FreeLike vo) {
		return session.insert("freeLikeMapper.insertFreeLike", vo);
	}
	// 좋아요 삭제 
	public int deleteFreeLike(FreeLike vo) {
		return session.delete("freeLikeMapper.deleteFreeLike", vo);
	}
	// 게시물 별 좋아요 갯수
	public int countFreeLike(int freeCode) {
		return session.selectOne("freeLikeMapper.countFreeLike", freeCode);
	}
	// 유저1명 좋아요1개 확인 여부
	public int checkUserFreeLike(FreeLike vo) {
		return session.selectOne("freeLikeMapper.checkUserFreeLike", vo);
	}
	
	// 게시물 삭제 
	public int deleteBoardFree(int freeCode) {
		return session.delete("boardFreeMapper.deleteBoardFree", freeCode);
	}
	// 게시물 삭제 > 이미지
	public int deleteBoardFreeImg(int freeCode) {
		return session.delete("boardFreeImgMapper.deleteBoardFreeImg", freeCode);
	}
	
	// 게시물 수정
	public int updateBordFree(BoardFree vo) {
		return session.update("boardFreeMapper.updateBoardFree", vo);
	}
	// 게시물 수정 > 이미지
	public int updateBoardFreeImg(BoardFreeImg img) {
		return session.update("boardFreeImgMapper.updateBoardFreeImg", img);
	}
	
	// 좋아요 누른 게시물 보기 
	public List<BoardFree> viewListLiked(LikedPaging paging){
		return session.selectList("boardFreeMapper.viewListLiked", paging);
	}
	public int countViewListLiked(int userCode) {
		return session.selectOne("boardFreeMapper.countViewListLiked", userCode);
	}
	
	// 내가 쓴 게시물 리스트+페이징 
	public List<BoardFree> viewListWritedBoardFree(LikedPaging paging){
		return session.selectList("boardFreeMapper.viewListWritedBoardFree", paging);
	}
	public int countViewListWritedBoardFree(int userCode) {
		return session.selectOne("boardFreeMapper.countViewListWritedBoardFree", userCode);
	}
}
