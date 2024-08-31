package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.BoardNotice;
import com.recoa.model.vo.BoardNoticeImg;
import com.recoa.model.vo.BoardNoticePaging;

@Repository
public class BoardNoticeDAO {
	
	@Autowired
	private SqlSessionTemplate session;
	
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
		System.out.println("noticeCode : " + noticeCode);
		return session.selectOne("BoardNotice.noticeOne", noticeCode);
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
}
