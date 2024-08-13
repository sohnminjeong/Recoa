package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreeImg;
import com.recoa.service.BoardFreeService;

@Controller
public class BoardFreeController {

	 @Autowired
	 private BoardFreeService service;
	
	 // 이미지 저장
	 private String path = "C:\\recoaImg\\boardFree\\";
	 
	 // 파일 업로드 기능
	 public String fileUpload(MultipartFile file) throws IllegalStateException, IOException {
		 UUID uuid=  UUID.randomUUID();
		 String filename= uuid.toString()+"_"+file.getOriginalFilename();
		 File copyFile = new File(path+filename);
		 file.transferTo(copyFile);
		 return filename;
	 }
	
	 /* ---------------------------------------------------- */	
	 
	// 게시판 전체보기 페이지 이동
	@GetMapping("/boardFreeViewAll")
	public String boardFreeViewAll() {
		return "boardFree/boardFreeViewAll";
	}
	
	// 게시물 작성 페이지 이동
	@GetMapping("/registerBoardFree")
	public String registerBoardFree() {
		return "boardFree/registerBoardFree";
	}
	
	// 게시물 작성
	@PostMapping("/registerBoardFree")
	public String registerBoardFree(BoardFree vo) throws IllegalStateException, IOException {
		if(vo.getFile()!=null) {
			String url = fileUpload(vo.getFile().get(0));
			vo.setFreeMainImgUrl(url);
		}
		service.registerBoardFree(vo);

		BoardFreeImg img=new BoardFreeImg();
		
		if(vo.getFile()!=null) {
			for(int i=0; i<vo.getFile().size();i++) {

				String url = fileUpload(vo.getFile().get(i));
				img.setFreeImgUrl(url);
				img.setFreeCode(vo.getFreeCode());
				service.registerBoarddFreeImg(img);

			}
		}
		
		return "boardFree/boardFreeViewAll";
	}
	
}
