package com.recoa.model.vo;

import java.util.Date;

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
}
