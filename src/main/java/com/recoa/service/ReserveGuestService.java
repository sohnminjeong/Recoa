package com.recoa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.ReserveGuestDAO;
import com.recoa.model.vo.ReserveGuest;

@Service
public class ReserveGuestService {

	@Autowired
	private ReserveGuestDAO dao;
	
	
	
	public int registeGuest(ReserveGuest reserveguest) {
		return dao.registerGuest(reserveguest);
	}
}
