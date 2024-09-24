package com.recoa.model.vo;

import java.sql.Timestamp;
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
	private Timestamp noticeWritedate;
	private int noticeView;
	private boolean important;
	
	private int bookmarkCount;
	private List<MultipartFile> files;
	private User user;
}
