package com.recoa.model.vo;

import java.sql.Timestamp;
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
	private Timestamp freeWritedate;
	private int freeView;
	private int freeLikeCount;
	
	private int likeCheck; // 좋아요 여부 확인용 0:좋아요x, 1:좋아요O	
	private List<MultipartFile> file;
	private boolean delImgBtn;
	private User user;
}
