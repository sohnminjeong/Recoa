package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.BoardNotice;
import com.recoa.model.vo.BoardNoticeImg;
import com.recoa.service.BoardNoticeService;


@Controller
public class BoardNoticeController {
	
	@Autowired
	private BoardNoticeService service;
	
	 // 이미지 저장 경로
	 private String path = "C:\\recoaImg\\boardNotice\\";
	 
	 // 파일 업로드
	 public String fileUpload(MultipartFile file) throws IllegalStateException, IOException {
		 
		 UUID uuid=  UUID.randomUUID();
		 String filename= uuid.toString()+"_"+file.getOriginalFilename();
		 File copyFile = new File(path + filename);
		 file.transferTo(copyFile);
		 return filename;
	 }
	
	 // 게시판으로 이동
	@GetMapping("/boardNoticeList")
	public String boardNoticeList() {
		
		// 리스트 출력.. (페이징 처리도)
		
		return "boardNotice/boardNoticeViewAll";
	}
	
	// 공지 등록 페이지로 이동
	@GetMapping("registerNotice")
	public String registerNotice() {
		return "boardNotice/registerBoardNotice";
	}
	
	// 공지 등록
	@PostMapping("/registerNotice")
	public String registerNotice(BoardNotice vo) throws IllegalStateException, IOException {

		// 이미지가 없을 때
		System.out.println(vo);
		service.registerNotice(vo);
		
		if(vo.getFiles() != null && vo.getFiles().get(0).getOriginalFilename() != "") {
			for(MultipartFile file : vo.getFiles()) {
				BoardNoticeImg img = new BoardNoticeImg();
				
				String fileName = fileUpload(file);
				img.setNoticeImgUrl(fileName);
				img.setNoticeCode(vo.getNoticeCode());
				
				service.registerBoardNoticeImg(img);
			}
		}
		
		return "redirect:/boardNoticeList";
	}
}
