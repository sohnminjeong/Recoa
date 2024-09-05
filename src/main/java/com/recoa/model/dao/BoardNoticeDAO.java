package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.BoardNotice;
import com.recoa.model.vo.BoardNoticeImg;
import com.recoa.model.vo.BoardNoticePaging;
import com.recoa.model.vo.NoticeBookmark;
import com.recoa.model.vo.User;

@Repository
public class BoardNoticeDAO {
	
	@Autowired
	private SqlSessionTemplate session;
	
	// userId로 userCode 조회
	public int findUserCode(String userId) {
		return session.selectOne("BoardNotice.findUserCode", userId);
	}
	
	// 공지 작성
	public int registerNotice(BoardNotice notice) {
		return session.insert("BoardNotice.registerNotice", notice);
	}
	
	// 이미지 추가
	public int registerNoticeImg(BoardNoticeImg img) {
		return session.insert("BoardNoticeImg.registerBoardNoticeImg", img);
	}
	
	// 공지 리스트 (+ 검색)
	public List<BoardNotice> viewNoticeList(BoardNoticePaging paging) {
		return session.selectList("BoardNotice.noticeList", paging);
	}
	
	// 리스트 total
	public int viewNoticeListTotal() {
		return session.selectOne("BoardNotice.noticeListTotal");
	}
	
	// 공지 하나 보기
	public BoardNotice viewNotice(int noticeCode) {
		return session.selectOne("BoardNotice.noticeOne", noticeCode);
	}
	
	// 공지 작성자 조회
	public User noticeWriter(int noticeCode) {
		return session.selectOne("BoardNotice.noticeWriter", noticeCode);
	}
	
	// 조회수 증가
	public int addViewCount(int noticeCode) {
		return session.update("BoardNotice.addViewCount", noticeCode);
	}
	
	// 공지 하나 이미지
	public List<BoardNoticeImg> noticeImg(int noticeCode){
		return session.selectList("BoardNoticeImg.noticeImg", noticeCode);
	}
	
	// 공지 삭제하기
	public int deleteNotice(int noticeCode) {
		return session.delete("BoardNotice.deleteNotice", noticeCode);
	}
	
	// 공지 이미지 삭제하기
	public int deleteImg(int noticeCode) {
		return session.delete("BoardNoticeImg.deleteImg", noticeCode);
	}
	
	// 공지 수정하기
	public int updateNotice(BoardNotice notice) {
		return session.update("BoardNotice.updateNotice", notice);
	}
	
	// 공지 이미지 수정하기
	public int updateNoticeImg(BoardNoticeImg img) {
		return session.update("BoardNoticeImg.updateNoticeImg", img);
	}
	
	/* ----- 북마크 ----- */
	// 1. 북마크 생성
	public int addBookmark(NoticeBookmark bookmark) {
		return session.insert("NoticeBookmark.addBookmark", bookmark);
	}
	
	// 2. 북마크 취소
	public int delBookmark(NoticeBookmark bookmark) {
		return session.delete("NoticeBookmark.delBookmark", bookmark);
	}
	
	// 3. 북마크 수 카운트
	public int countBookmark(int noticeCode) {
		return session.selectOne("NoticeBookmark.countBookmark", noticeCode);
	}
	
	// 4. 북마크 여부 확인
	public int checkBookmark(NoticeBookmark bookmark) {
		return session.selectOne("NoticeBookmark.checkBookmark", bookmark);
	}
	
	// 5. 북마크한 글 리스트 조회
	public List<BoardNotice> bookmarked(BoardNoticePaging paging){
		return session.selectList("BoardNotice.bookmarked", paging);
	}
	
	// 6. 북마크한 글 페이징 total
	public int bookmarkedTotal(int userCode) {
		return session.selectOne("BoardNotice.bookmarkedTotal", userCode);
	}
}
