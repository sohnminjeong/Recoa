package com.recoa.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Chat {

	private int chatCode;
	private String chatMessage;
	private Date chatTime;
	private int chatRoomCode;
	private int userNumber;
}
