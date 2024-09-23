package com.recoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.AlarmDAO;
import com.recoa.model.vo.Alarm;
import com.recoa.model.vo.NotePaging;

@Service
public class AlarmService {

	@Autowired
	private AlarmDAO dao;
	
	public int registerAlarm(Alarm alarm) {
		return dao.registerAlarm(alarm);
	}
	public List<Alarm> viewAllAlarm(NotePaging notePaging){
		return dao.viewAllAlarm(notePaging);
	}
	public int countAllAlarm(int userCode) {
		return dao.countAllAlarm(userCode);
	}
}
