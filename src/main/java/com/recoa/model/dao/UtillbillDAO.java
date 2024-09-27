package com.recoa.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.ReservePaging;

@Repository
public class UtillbillDAO {
	@Autowired
	private SqlSessionTemplate session;
	
	// 고지서 조회
	// 1-1. 내 게스트룸 예약 내역 조회
	public List<Map<String, Object>> guestBill(ReservePaging paging){
		return session.selectList("ReserveGuest.guestBill", paging);
	}
	
	// 1-2. 게스트룸 total
	public int guestBillTotal(String userId) {
		return session.selectOne("ReserveGuest.guestBillTotal", userId);
	}
	
	// 1-3. 내 독서실 예약 내역 조회
	public List<Map<String, Object>> libraryBill(ReservePaging paging){
		return session.selectList("ReserveLibrary.libraryBill", paging);
	}
	
	// 1-4. 독서실 total
	public int libBillTotal(String userId) {
		return session.selectOne("ReserveLibrary.libBillTotal", userId);
	}
	
	// 결제 시 업데이트
	public int updateGuest(int reserveGuestCode) {
		System.out.println("int ::::::::;" + reserveGuestCode);
		return session.update("ReserveGuest.updateGuest", reserveGuestCode);
	}
	
	public int updateLibrary(int reserveLibraryCode) {
		return session.update("ReserveLibrary.updateLibrary", reserveLibraryCode);
	}
}
