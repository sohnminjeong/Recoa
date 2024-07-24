package com.recoa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.recoa.service.ReserveGuestService;

@Controller
public class ReserveGuestController {

	@Autowired
	private ReserveGuestService service;
	
	// 예약하기 페이지 불러오기
	@GetMapping("/reserveGuest")
	public String reserveGuest() {
		return "guest/reserveGuest";
	}
	
}
