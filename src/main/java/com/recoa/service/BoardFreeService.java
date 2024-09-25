package com.recoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.BoardFreeDAO;
import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreeImg;
import com.recoa.model.vo.BoardFreePaging;
import com.recoa.model.vo.FreeLike;
import com.recoa.model.vo.LikedPaging;

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
	
	// 게시물 전체 보기(페이징+검색)
	public List<BoardFree> listBoardFree(BoardFreePaging paging) {
		paging.setOffset(paging.getLimit()*(paging.getPage()-1));
		return dao.listBoardFree(paging);
	}
	// 페이징 관련 total 수 
	public int total() {
		return dao.total();
	}
	
	// 게시물 한개 보기
	public BoardFree oneBoardFree(int freeCode) {
		return dao.oneBoardFree(freeCode);
	}
	// 게시물 한개 보기 > 이미지
	public List<BoardFreeImg> oneBoardFreeImg(int freeCode) {
		return dao.oneBoardFreeImg(freeCode);
	}
	// 게시물 조회수 증가
	public int updateFreeView(int freeCode) {
		return dao.updateFreeView(freeCode);
	}
	// 좋아요 추가
	public int insertFreeLike(FreeLike vo) {
		return dao.insertFreeLike(vo);
	}
	// 좋아요 삭제 
	public int deleteFreeLike(FreeLike vo) {
		return dao.deleteFreeLike(vo);
	}
	// 게시물 별 좋아요 갯수
	public int countFreeLike(int freeCode) {
		return dao.countFreeLike(freeCode);
	}
	// 유저1명 좋아요1개 확인 여부
	public int checkUserFreeLike(FreeLike vo) {
		return dao.checkUserFreeLike(vo);
	}
	
	
	// 게시물 삭제 
	public int deleteBoardFree(int freeCode) {
		return dao.deleteBoardFree(freeCode);
	}
	// 게시물 삭제 > 이미지
	public int deleteBoardFreeImg(int freeCode) {
		return dao.deleteBoardFreeImg(freeCode);
	}
	
	// 게시물 수정
	public int updateBordFree(BoardFree vo) {
		return dao.updateBordFree(vo);
	}
	// 게시물 수정 > 이미지
	public int updateBoardFreeImg(BoardFreeImg img) {
		return dao.updateBoardFreeImg(img);
	}
	
	// 좋아요 누른 게시물 보기 
	public List<BoardFree> viewListLiked(LikedPaging paging){
		paging.setOffset(paging.getLimit()*(paging.getPage()-1));
		return dao.viewListLiked(paging);
	}
	public int countViewListLiked(int userCode) {
		return dao.countViewListLiked(userCode);
	}
}
