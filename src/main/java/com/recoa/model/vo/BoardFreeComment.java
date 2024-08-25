package com.recoa.model.vo;

import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class BoardFreeComment {
	
	private int freeCommentCode;
	private int freeCode;
	private int userCode;
	private String freeCommentContent;
	private Timestamp freeCommentWritedate;
	private Integer commentParentCode;
	
	private User user;
}
