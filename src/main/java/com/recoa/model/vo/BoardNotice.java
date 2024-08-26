package com.recoa.model.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class BoardNotice {
	private int noticeCode;
	private int userCode;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeWritedate;
	private int noticeView;
	
	//private int bookmark;
	private List<MultipartFile> files;
	
}
