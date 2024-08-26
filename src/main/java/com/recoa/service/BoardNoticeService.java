package com.recoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.BoardNoticeDAO;
import com.recoa.model.vo.BoardNotice;

@Service
public class BoardNoticeService {

	@Autowired
	private BoardNoticeDAO dao;
	
	// 공지 작성
	public int registerNotice(BoardNotice notice) {
		return dao.registerNotice(notice);
	}
}
