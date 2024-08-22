package com.recoa.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.ReserveGuestDAO;
import com.recoa.model.vo.ReserveGuest;
import com.recoa.model.vo.Utillbill;

@Service
public class ReserveGuestService {

	@Autowired
	private ReserveGuestDAO dao;
	
	// 사용 가능한 방 조회
	public List<Map<String, Object>> getAvailableRooms(Map<String, Object> params) {
        System.out.println("service : " + params);
        return dao.checkRoom(params);
    }
	
	// 방 예약
	public int registeGuest(ReserveGuest reserveguest) {
		return dao.registerGuest(reserveguest);
	}
	
	// 내 게스트룸 예약 내역 조회
	public List<ReserveGuest> myGuest(String userId){
		return dao.myGuest(userId);
	}
	
	// 게스트룸 예약 취소
	public int cancelGuest(Integer reserveGuestCode) {
		return dao.cancelGuest(reserveGuestCode);
	}
	
	// 고지서 조회
	public List<Utillbill> checkBill(Utillbill vo) {
		List<Utillbill> bill = dao.checkBill(vo);
		System.out.println("서비스 : " + bill.size());
		return dao.checkBill(vo);
	}
	
	public int registBill(Utillbill vo) {
		return dao.regiBill(vo);
	}
	
	public int updateBill(Utillbill vo) {
		return dao.updateBill(vo);
	}

}
