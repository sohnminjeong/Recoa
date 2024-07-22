package com.recoa.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class Guest {
	private int roomType;
	private int roomCode;
	private boolean status;
}
