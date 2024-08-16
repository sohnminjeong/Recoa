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
	
	public List<Map<String, Object>> getAvailableRooms(Map<String, Object> params) {
        System.out.println("service : " + params);
        return dao.checkRoom(params);
    }
	
	public int registeGuest(ReserveGuest reserveguest) {
		return dao.registerGuest(reserveguest);
	}
	
	// 고지서 조회
	public Utillbill checkBill(int userCode) {
		Utillbill vo = dao.checkBill(userCode);
		if(vo == null) {
			return null;
		} else {
			return vo;
		}
	}
	
	public int registBill(Utillbill vo) {
		return dao.regiBill(vo);
	}
}
