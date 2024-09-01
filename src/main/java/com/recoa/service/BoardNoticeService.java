package com.recoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.BoardNoticeDAO;
import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreePaging;
import com.recoa.model.vo.BoardNotice;
import com.recoa.model.vo.BoardNoticeImg;
import com.recoa.model.vo.BoardNoticePaging;

@Service
public class BoardNoticeService {

	@Autowired
	private BoardNoticeDAO dao;
	
	// 공지 작성
	public int registerNotice(BoardNotice notice) {
		
		return dao.registerNotice(notice);
	}
	
	// 이미지 등록
	public int registerBoardNoticeImg(BoardNoticeImg img) {
		
		return dao.registerNoticeImg(img);
	}
	
	// 공지 리스트
	public List<BoardNotice> viewNoticeList(BoardNoticePaging paging){
		return dao.viewNoticeList(paging);
	}
	
	// 공지 리스트 total
	public int noticeListTotal() {
		return dao.viewNoticeListTotal();
	}
	
	// 공지 하나 보기
	public BoardNotice viewNotice(int noticeCode) {
		return dao.viewNotice(noticeCode);
	}
	
	// 조회수 증가
	public int addViewCount(int noticeCode) {
		return dao.addViewCount(noticeCode);
	}
	
	// 공지 하나 이미지
	public List<BoardNoticeImg> noticeImg(int noticeCode){
		return dao.noticeImg(noticeCode);
	}
	
	// 공지 삭제하기
	public int deleteNotice(int noticeCode) {
		return dao.deleteNotice(noticeCode);
	}
	
	// 공지 이미지 삭제하기
	public int deleteImg(int noticeCode) {
		return dao.deleteImg(noticeCode);
	}
}
