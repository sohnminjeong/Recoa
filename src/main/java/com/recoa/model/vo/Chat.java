package com.recoa.model.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
	
	private List<MultipartFile> chatFile;
}
