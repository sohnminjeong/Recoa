package com.recoa.model.vo;

import java.time.LocalDateTime;
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
	private LocalDateTime freeWritedate;
	private String freeMainImgUrl;
	private int freeView;
	private int freeLike;
				
	private List<MultipartFile> file;
}
