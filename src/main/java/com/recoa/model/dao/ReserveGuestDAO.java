package com.recoa.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.ReserveGuest;

@Repository
public class ReserveGuestDAO {

	@Autowired
	private SqlSessionTemplate session;
	
	
	// 게스트하우스 예약 등록
	public int registerGuest(ReserveGuest reserveguest) {
		return session.insert("ReserveGuest.registerGuestReserve", reserveguest);
	}
}
