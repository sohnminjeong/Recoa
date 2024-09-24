package com.recoa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.Alarm;
import com.recoa.model.vo.NotePaging;

@Repository
public class AlarmDAO {

	@Autowired
	private SqlSessionTemplate session;
	
	public int registerAlarm(Alarm alarm) {
		return session.insert("alarmMapper.registerAlarm", alarm);
	}
	
	public List<Alarm> viewAllAlarm(NotePaging paging){
		return session.selectList("alarmMapper.viewAllAlarm", paging);
	}
	public int countAllAlarm(int userCode) {
		return session.selectOne("alarmMapper.countAllAlarm", userCode);
	}
	
	public int updateAlarmCheck(int alarmCode) {
		return session.update("alarmMapper.updateAlarmCheck", alarmCode);
	}

	public int deleteAlarm(int alarmCode) {
		return session.delete("alarmMapper.deleteAlarm", alarmCode);
	}
	
}
