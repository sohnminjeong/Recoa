package com.recoa.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.User;

@Repository
public class UserDAO {
	
	@Autowired(required=false)
	private SqlSessionTemplate session;
	
	// 회원가입
	public int registerUser(User user) {
		return session.insert("userMapper.registerUser", user);
	}
	// 회원가입_아이디 중복 확인
	public User idCheck(String userId) {
		return session.selectOne("userMapper.idCheck", userId);
	}
	// 회원가입_핸드폰번호 중복 확인
	public User phoneCheck(String userPhone) {
		return session.selectOne("userMapper.phoneCheck", userPhone);
	}
	// 회원가입_이메일 중복 확인
	public User emailCheck(String userEmail) {
		return session.selectOne("userMapper.emailCheck", userEmail);
	}
	// 회원가입_닉네임 중복 확인
	public User nickNameCheck(String userNickname) {
		return session.selectOne("userMapper.nickNameCheck", userNickname);
	}
	
	// 로그인
	public User loginById(String id) {
		return session.selectOne("userMapper.loginById", id);
	}
	
	// 회원 개인 정보 확인
	public User selectUser(String id) {
		return session.selectOne("userMapper.selectUser", id);
	}
	
	// 비밀번호 변경 
	public int updateUserPwd(User user) {
		return session.update("userMapper.updateUserPwd", user);
	}

	// 프로필 설정
	public int updateProfile(User user) {
		return session.update("userMapper.updateProfile", user);
	}
	
	// 회원 정보 수정
	public int updateUser(User user) {
		return session.update("userMapper.updateUser", user);
	}
	
	// 회원 탈퇴
	public int deleteUser(String userId) {
		return session.delete("userMapper.deleteUser", userId);
	}
}
