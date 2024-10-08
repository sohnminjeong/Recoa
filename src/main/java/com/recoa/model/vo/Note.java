package com.recoa.model.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class Note {
	
	private int noteCode;
	private int noteSender;
	private int noteReceiver;
	private String noteTitle;
	private String noteContent;
	private Date noteWritedate;
	private boolean senderDelete;
	private boolean receiverDelete;
	
	private List<MultipartFile> noteFile;
	private boolean hasNote;
	private User user;
	private String senderNick;
	private String receiverNick;
	

}
