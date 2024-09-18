package com.recoa.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class Alarm {

	private int alarmCode;
	private int userCode;
	private boolean alarmCheck;
	private Date alarmDate;
	private String alarmTable;
	private int alarmContent;
	private int alarmUrl;
		
}
