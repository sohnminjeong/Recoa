package com.recoa.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.ReserveGuest;
import com.recoa.model.vo.Utillbill;

@Repository
public class ReserveGuestDAO {

	@Autowired
	private SqlSessionTemplate session;
	
	// 기간에 따른 게스트하우스 예약 내역 조회
	public List<Map<String, Object>> checkRoom(Map<String, Object> params) {
	   return session.selectList("ReserveGuest.checkRoom", params);
	}
	
	// 게스트하우스 예약 등록
	public int registerGuest(ReserveGuest reserveguest) {
		return session.insert("ReserveGuest.registerGuestReserve", reserveguest);
	}
	
	// 내 게스트룸 예약 내역 조회
	public List<ReserveGuest> myGuest(String userId){
		return session.selectList("ReserveGuest.myGuest", userId);
	}
	
	// 게스트룸 예약 취소
	public int cancelGuest(Integer reserveGuestCode) {
		return session.update("ReserveGuest.cancelGuest", reserveGuestCode);
	}
	
	// 고지서 조회
	public List<Utillbill> checkBill(Utillbill vo) {
		return session.selectList("UtillBill.checkBill", vo);
	}
	
	// 고지서 등록
	public int regiBill(Utillbill vo) {
		return session.insert("UtillBill.Regibill", vo);
	}
	
	// 고지서 수정
	public int updateBill(Utillbill vo) {
		return session.update("UtillBill.updatebill", vo);
	}



	
}
