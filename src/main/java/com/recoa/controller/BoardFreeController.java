package com.recoa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardFreeController {

	
	
	
	// 게시판 전체보기 페이지 이동
	@GetMapping("/boardFreeViewAll")
	public String boardFreeViewAll() {
		return "boardFree/boardFreeViewAll";
	}
	
	
}
