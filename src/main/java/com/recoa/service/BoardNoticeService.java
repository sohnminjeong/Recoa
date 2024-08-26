package com.recoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.BoardNoticeDAO;
import com.recoa.model.vo.BoardNotice;
import com.recoa.model.vo.BoardNoticeImg;

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
}
