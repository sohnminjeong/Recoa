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
import com.recoa.model.vo.NoticeBookmark;
import com.recoa.model.vo.User;

@Service
public class BoardNoticeService {

	@Autowired
	private BoardNoticeDAO dao;
	
	// userId로 userCode 조회
	public int findUserCode(String userId) {
		return dao.findUserCode(userId);
	}
	
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
	
	// 공지 수정하기
	public int updateNotice(BoardNotice notice) {
		return dao.updateNotice(notice);
	}
	
	// 공지 이미지 수정하기
	public int updateNoticeImg(BoardNoticeImg img) {
		return dao.updateNoticeImg(img);
	}
	
	/* ----- 북마크 ----- */
	// 1. 북마크 생성
	public int addBookmark(NoticeBookmark bookmark) {
		return dao.addBookmark(bookmark);
	}
	
	// 2. 북마크 취소
	public int delBookmark(NoticeBookmark bookmark) {
		return dao.delBookmark(bookmark);
	}
	
	// 3. 북마크 수 카운트
	public int countBookmark(int noticeCode) {
		return dao.countBookmark(noticeCode);
	}
	
	// 4. 북마크 여부 확인
	public int checkBookmark(NoticeBookmark bookmark) {
		return dao.checkBookmark(bookmark);
	}
	
	// 5. 북마크한 글 리스트 조회
	public List<BoardNotice> bookmarked(BoardNoticePaging paging){
		return dao.bookmarked(paging);
	}
	
	// 6. 북마크한 글 total
	public int bookmarkedTotal(int userCode) {
		return dao.bookmarkedTotal(userCode);
	}
	
	// 내가 작성한 공지글 조회
	public List<BoardNotice> mynoticeList(BoardNoticePaging paging){
		return dao.mynoticeList(paging);
	}
	
	public int mynoticeListTotal(int userCode) {
		return dao.mynoticeListTotal(userCode);
	}
}
