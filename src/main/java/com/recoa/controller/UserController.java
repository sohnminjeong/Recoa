package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.User;
import com.recoa.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService service;
	
	
	private String path = "C:\\recoaImg\\user\\";
	
	// 파일 업로드 기능
	public String fileUpload(MultipartFile file) throws IllegalStateException, IOException {
		//중복 방지 UUID 적용
		UUID uuid = UUID.randomUUID();
		String filename = uuid.toString() + "_" + file.getOriginalFilename();
	
		File copyFile = new File(path+filename);
		file.transferTo(copyFile);
		return filename;
	}
	
	/* ---------------------------------------- */
	// 전체 페이지 이동
	@GetMapping("/allUser")
	public void all() {}
	
	// 회원 페이지 이동
	@GetMapping("/myPageUser")
	public String myPageUser() {
		return "user/myPageUser";
	}
	
	// 관리자 페이지 이동
	@GetMapping("/adminUser")
	public void admin() {}
	
	// 로그인 페이지 이동
	@GetMapping("/loginUser")
	public String loginUser() {
		return "user/loginUser";
	}

	// 회원가입 페이지 이동
	@GetMapping("/registerUser")
	public String registerUser() {
		return "user/registerUser";
	}
	
	// 회원가입 로직
	@PostMapping("/registerUser")
	public String registerUser(User user) throws IllegalStateException, IOException {
//		if(!user.getFile().isEmpty()) {
//			String url = fileUpload(user.getFile());
//			user.setUserImgUrl(url);
//		}
		System.out.println("sdffsidjfisd");
		System.out.println(user.getFile());
		
//		String url = fileUpload(user.getFile());
//		System.out.println("url : " + url);
//		user.setUserImgUrl(url);
		service.registerUser(user);
		return "user/loginUser";
	}
	
}
