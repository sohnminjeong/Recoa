package com.recoa.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.ReserveGuest;

@Repository
public class ReserveGuestDAO {

	@Autowired
	private SqlSessionTemplate session;
	
	// 기간에 따른 게스트하우스 예약 내역 조회
	public List<Map<String, Object>> checkRoom(Map<String, Object> params) {
	   System.out.println("DAO : " + params);
	   return session.selectList("ReserveGuest.checkRoom", params);
	}
	
	
	// 게스트하우스 예약 등록
	public int registerGuest(ReserveGuest reserveguest) {
		return session.insert("ReserveGuest.registerGuestReserve", reserveguest);
	}
}
