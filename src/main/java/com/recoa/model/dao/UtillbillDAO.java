package com.recoa.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UtillbillDAO {
	@Autowired
	private SqlSessionTemplate session;
	
	// 고지서 조회
	// 1-1. 내 게스트룸 예약 내역 조회
	public List<Map<String, Object>> guestBill(String userCode){
		return session.selectList("ReserveGuest.guestBill", userCode);
	}
	
	// 1-2. 내 독서실 예약 내역 조회
	public List<Map<String, Object>> libraryBill(String userCode){
		return session.selectList("ReserveLibrary.libraryBill", userCode);
	}
}
