package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.Alarm;

@Repository
public class AlarmDAO {

	@Autowired
	private SqlSessionTemplate session;
	
	public int registerAlarm(Alarm alarm) {
		return session.insert("alarmMapper.registerAlarm", alarm);
	}
	
	public List<Alarm> viewAllAlarm(int userCode){
		return session.selectList("alarmMapper.viewAllAlarm", userCode);
	}
}
