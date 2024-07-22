package com.recoa.model.vo;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class ReserveGuest {
	private int reserveGuestCode;
	private int userCode;
	private int roomType;
	private int roomCode;
	private Date startTime;
	private Date endTime;
	private LocalDateTime regiDate;
	private boolean status;
}
