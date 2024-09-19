package com.recoa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.AlarmDAO;
import com.recoa.model.vo.Alarm;

@Service
public class AlarmService {

	@Autowired
	private AlarmDAO dao;
	
	public int registerAlarm(Alarm alarm) {
		System.out.println("alarmServce of alarm : "+alarm);
		return dao.registerAlarm(alarm);
	}
	public List<Alarm> viewAllAlarm(int userCode){
		return dao.viewAllAlarm(userCode);
	}
}
