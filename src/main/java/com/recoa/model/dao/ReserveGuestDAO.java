package com.recoa.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.ReserveGuest;
import com.recoa.model.vo.ReserveLibrary;
import com.recoa.model.vo.ReservePaging;
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
	public List<ReserveGuest> myGuest(ReservePaging paging){
		return session.selectList("ReserveGuest.myGuest", paging);
	}
	
	public int Guesttotal(String userId) {
		return session.selectOne("ReserveGuest.guestTotal", userId);
	}
	
	// 예약 취소 내역 조회
	public List<ReserveGuest> myGuestCancel(ReservePaging paging){
		return session.selectList("ReserveGuest.myGuestCancel", paging);
	}
	
	public int CancelGuesttotal(String userId) {
		return session.selectOne("ReserveGuest.CancelGuesttotal", userId);
	}
	
	// 게스트룸 예약 취소
	public int cancelGuest(Integer reserveGuestCode) {
		return session.update("ReserveGuest.cancelGuest", reserveGuestCode);
	}
	
	// 독서실 예약 내역
	public List<ReserveGuest> allGuest(ReservePaging paging){
		return session.selectList("ReserveGuest.AllGuest", paging);
	}
	
	public int allGuestTotal() {
		return session.selectOne("ReserveGuest.allGuestTotal");
	}
}
