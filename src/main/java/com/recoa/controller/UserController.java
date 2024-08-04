package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.User;
import com.recoa.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService service;
	
	@Autowired
	private BCryptPasswordEncoder bcpe;
	
	
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
	// 관리자 페이지 이동
	@GetMapping("/adminPage")
	public String adminPage() {
		return "user/adminPage";
	}
	
	// 로그인 페이지 이동
	@GetMapping("/loginUser")
	public String loginUser() {
		return "user/loginUser";
	}

	/*------------------------ 회원가입 관련 ---------------------------*/
	// 회원가입 페이지 이동
	@GetMapping("/registerUser")
	public String registerUser() {
		return "user/registerUser";
	}
	
	// 회원가입 로직
	@PostMapping("/registerUser")
	public String registerUser(User user) throws IllegalStateException, IOException {		
		service.registerUser(user);
		return "user/loginUser";
	}
	
	// 회원가입_아이디 중복 확인
	@ResponseBody
	@PostMapping("/idCheck")
	public boolean idCheck(String userId) {
		User user = service.idCheck(userId);
		if(user==null) {
			return false;
		}
		return true;
	}
	// 회원가입_핸드폰번호 중복 확인
	@ResponseBody
	@PostMapping("/phoneCheck")
	public boolean phoneCheck(String userPhone) {
		User user = service.phoneCheck(userPhone);
		if(user==null) {
			return false;
		}
		return true;
	}
	// 회원가입_이메일 중복 확인
	@ResponseBody
	@PostMapping("/emailCheck")
	public boolean emailCheck(String userEmail) {
		User user = service.emailCheck(userEmail);
		if(user==null) {
			return false;
		}
		return true;
	}
	// 회원가입_닉네임 중복 확인
	@ResponseBody
	@PostMapping("/nickNameCheck")
	public boolean nickNameCheck(String userNickname) {
		User user = service.nickNameCheck(userNickname);
		if(user==null) {
			return false;
		}
		return true;
	}
	
	
	// 회원 마이 페이지
	@GetMapping("/selectUser")
	public String selectUser(Model model, String id) {
		User user = service.selectUser(id);
		model.addAttribute("user", user);
		return "user/myPageUser";
	}
	
	/*-------------------------회원 정보 수정-----------------------------*/
	// 비밀번호 변경 페이지 이동
	@GetMapping("/updateUserPwd")
	public String updateUserPwd(Model model, String id) {
		User user = service.selectUser(id);
		model.addAttribute("user", user);
		return "user/updateUserPwd";
	}
	
	// 비밀번호 변경 시_현재 비밀번호 일치여부 확인
	@ResponseBody
	@PostMapping("/selectUserPwd")
	public boolean selectUserPwd(@RequestParam Map<String, Object> map) {
		
		String userId = (String) map.get("userId");
		String userPwd = (String)map.get("userPwd");

		User userCheck = service.selectUser(userId);
	
		if(bcpe.matches(userPwd, userCheck.getPassword())) {
			return false;
		}
		return true;
	}
	
	// 비밀번호 변경
	@PostMapping("/updateUserPwd")
	public String updateUserPwd(User user) {
		System.out.println("user : "+user);
		service.updateUserPwd(user);
		return "user/myPageUser";
	}
	
	// 내정보 설정 페이지 이동
	@GetMapping("/updateUser")
	public String updateUser(Model model, String id) {
		User user = service.selectUser(id);
		model.addAttribute("user", user);
		return "user/updateUser";
	}
	
	// 수리중
	@ResponseBody
	@PostMapping("/updateUser")
	public String updateUser(User user) throws IllegalStateException, IOException {
		String url = fileUpload(user.getFile());
		user.setUserImgUrl(url);
		service.updateUser(user);
		return "user/myPageUser";
	}
}
