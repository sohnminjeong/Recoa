package com.recoa.model.vo;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class ReserveLibrary {
	private int reserveLibCode;
	private int userCode;
	private int libraryCode;
	private int seatCode;
	private Date startTime;
	private Date endTime;
	private LocalDateTime regiDate;
	private boolean status;
	private boolean paid;
}
