package com.recoa.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class BoardFreeComment {
	
	private int freecommentCode;
	private int freeCode;
	private int userCode;
	private String freeCommentContent;
	private Date freeCommentWritedate;
	private int commentParentCode;
	
}
