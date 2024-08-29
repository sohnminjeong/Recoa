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
	// 회원가입_아이디 중복 확인
	public User idCheck(String userId) {
		return dao.idCheck(userId);
	}
	// 회원가입_핸드폰번호 중복 확인
	public User phoneCheck(String userPhone) {
		return dao.phoneCheck(userPhone);
	}
	// 회원가입_이메일 중복 확인
	public User emailCheck(String userEmail) {
		return dao.emailCheck(userEmail);
	}
	// 회원가입_닉네임 중복 확인
	public User nickNameCheck(String userNickname) {
		return dao.nickNameCheck(userNickname);
	}
		
	// 회원 개인 정보 확인
	public User selectUser(String id) {
		return dao.selectUser(id);
	}
	
	// 비밀번호 변경 
	public int updateUserPwd(User user) {
		String encodePw = bcpe.encode(user.getUserPwd());
		user.setUserPwd(encodePw);
		return dao.updateUserPwd(user);
	}
	
	// 프로필 설정
	public int updateProfile(User user) {
		return dao.updateProfile(user);
	}
	
	// 회원 정보 수정
	public int updateUser(User user) {
		return dao.updateUser(user);
	}
	
	// 회원 탈퇴
	public int deleteUser(String userId) {
		return dao.deleteUser(userId);
	}
	
	// 아이디 찾기
	public User findId(User user) {
		return dao.findId(user);
	}
	
	// 비밀번호 찾기
	public User findPwd(User user) {
		return dao.findPwd(user);
	}
	
	// 쪽지 작성용 : 닉네임으로 회원 코드 찾기
	public int findUserCode(String userNickname) {
		return dao.findUserCode(userNickname);
	}
}
