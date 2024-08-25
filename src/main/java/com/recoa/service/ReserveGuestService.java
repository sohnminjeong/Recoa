package com.recoa.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.ReserveGuestDAO;
import com.recoa.model.vo.ReserveGuest;
import com.recoa.model.vo.ReservePaging;
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
	public List<ReserveGuest> myGuest(ReservePaging paging){
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;

		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));

		paging.setId(userDetails.getUsername());
		return dao.myGuest(paging);
	}
	
	// 예약 내역 total
	public int Guesttotal() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		return dao.Guesttotal(userDetails.getUsername());
	}
	
	// 예약 취소 내역 조회
	public List<ReserveGuest> myGuestCancel(ReservePaging paging){
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;

		paging.setOffset(paging.getLimit() * (paging.getPage() - 1));

		paging.setId(userDetails.getUsername());
		
		return dao.myGuestCancel(paging);
	}
	
	// 취소 내역 total
	public int CancelGuesttotal() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		System.out.println("취소내역.. 조회는 되고있어 ");
		return dao.CancelGuesttotal(userDetails.getUsername());
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
