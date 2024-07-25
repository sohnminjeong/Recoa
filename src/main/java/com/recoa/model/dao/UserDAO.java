package com.recoa.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
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
	
	// 로그인
	public User loginById(String id) {
		return session.selectOne("userMapper.loginById", id);
	}
}
