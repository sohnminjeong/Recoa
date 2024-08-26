package com.recoa.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.recoa.model.vo.BoardNotice;
import com.recoa.service.BoardNoticeService;


@Controller
public class BoardNoticeController {
	
	@Autowired
	private BoardNoticeService service;
	
	@GetMapping("/boardNoticeList")
	public String boardNoticeList() {
		return "boardNotice/boardNoticeViewAll";
	}
	
	@GetMapping("registerNotice")
	public String registerNotice() {
		return "boardNotice/registerBoardNotice";
	}
	
	@PostMapping("/registerNotice")
	public String registerNotice(@RequestParam("userCode") int userCode,
			@RequestParam("noticeTitle") String noticeTitle,
			@RequestParam("noticeContent") String noticeContent
			) {
		
		BoardNotice vo = new BoardNotice();
		vo.setUserCode(userCode);
		vo.setNoticeTitle(noticeTitle);
		vo.setNoticeContent(noticeContent);

		service.registerNotice(vo);
		return "boardNoticeList";
	}
}
