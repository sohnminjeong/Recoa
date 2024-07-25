package com.recoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.UserDAO;
import com.recoa.model.vo.User;

// Spring Security에서 제공하는 UserDetailsService 인터페이스 상속
@Service
public class UserService implements UserDetailsService{

	// 비밀번호 암호화 위해
	@Autowired
	private BCryptPasswordEncoder bcpe;
	
	// dao 연결
	@Autowired(required=false)
	private UserDAO dao;
	
	
	// 로그인시 자동으로 여기로 연결
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = dao.loginById(username);
		return user;
	}
	
	
	// 회원가입
	public int registerUser(User user) {
		// 비밀번호 암호화 처리 후 멤버 정보 다시 담아서 dao에게 전달 
		// 암호화 처리
		String encodePw = bcpe.encode(user.getUserPwd());
		// 암호화 처리 된 비밀번호로 다시 세팅
		user.setUserPwd(encodePw);
		return dao.registerUser(user);
	}

	
	
	
}
