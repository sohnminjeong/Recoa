package com.recoa.model.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BoardFree {
	private int freeCode;
	private int userCode;
	private String freeTitle;
	private String freeContent;
	private Date freeWritedate;
	private int freeView;
	private int freeLike;
	
	private boolean likeCheck;
				
	private List<MultipartFile> file;
	private boolean delImgBtn;
	private User user;
}
