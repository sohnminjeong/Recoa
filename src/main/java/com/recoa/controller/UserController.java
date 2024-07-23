package com.recoa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.recoa.model.vo.User;
import com.recoa.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService service;
	
	// 전체 페이지 이동
	@GetMapping("/allUser")
	public void all() {}
	
	// 회원 페이지 이동
	@GetMapping("/memberUser")
	public void member() {}
	
	// 관리자 페이지 이동
	@GetMapping("/adminUser")
	public void admin() {}
	
	// 로그인 페이지 이동
	@GetMapping("/loginUser")
	public void login() {}
	
	// 회원가입 페이지 이동
	@GetMapping("/registerUser")
	public void register() {}
	
	// 회원가입 로직
	@PostMapping("/registerUser")
	public String registerUser(User user) {
		service.registerUser(user);
		return "redirect:/loginUser";
	}
	
}
