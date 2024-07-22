package com.recoa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.recoa.service.ReserveGuestService;

@Controller
public class ReserveGuestController {

	@Autowired
	private ReserveGuestService service;
	
	
}
