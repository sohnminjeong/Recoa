package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreeImg;
import com.recoa.model.vo.BoardFreePaging;
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
	@GetMapping("/viewAllBoardFree")
	public String viewAllBoardFree(Model model, @RequestParam(value="page", defaultValue="1")int page, String select, String keyword) {
		int total = service.total();
		BoardFreePaging paging = new BoardFreePaging(page, total);
		paging.setKeyword(keyword);
		paging.setSelect(select);
			
		List<BoardFree> list = service.listBoardFree(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		return "boardFree/viewAllBoardFree";
	}
	
	// 게시물 작성 페이지 이동
	@GetMapping("/registerBoardFree")
	public String registerBoardFree() {
		return "boardFree/registerBoardFree";
	}
	
	// 게시물 작성
	@PostMapping("/registerBoardFree")
	public String registerBoardFree(BoardFree vo) throws IllegalStateException, IOException {
		service.registerBoardFree(vo);
		BoardFreeImg img=new BoardFreeImg();
		if(vo.getFile()!=null&&vo.getFile().get(0).getOriginalFilename()!="") {
			for(int i=0; i<vo.getFile().size();i++) {
				String url = fileUpload(vo.getFile().get(i));
				img.setFreeImgUrl(url);
				img.setFreeCode(vo.getFreeCode());
				service.registerBoarddFreeImg(img);
			}
		}
		
		return "redirect:/viewAllBoardFree";
	}
	
	// 게시물 하나 보기 페이지 이동
	@GetMapping("/viewOneBoardFree")
	public String viewOneBoardFree(int freeCode, Model model, HttpServletRequest request) {
		// 조회수 중복 방지 수정 필요 
		System.out.println("request.adddr : "+request.getLocalAddr());
		System.out.println("request.getCookies :"+request.getCookies());
		service.updateFreeView(freeCode);
		BoardFree vo = service.oneBoardFree(freeCode);
		List<BoardFreeImg> imgList = service.oneBoardFreeImg(freeCode);
		model.addAttribute("vo", vo);
		model.addAttribute("imgList", imgList);
		return "boardFree/viewOneBoardFree";
	}
	
	// 게시물 삭제 
	@GetMapping("/deleteBoardFree")
	public String deleteBoardFree(int freeCode) {
		List<BoardFreeImg> listImg = service.oneBoardFreeImg(freeCode);
		if(listImg!=null) {
			
			for(BoardFreeImg img : listImg) {
				File file = new File(path+img.getFreeImgUrl());
				file.delete();
			}
		}
		service.deleteBoardFree(freeCode);
		service.deleteBoardFreeImg(freeCode);
		return "redirect:/viewAllBoardFree";
	}
	
	// 게시물 수정 페이지 이동
	@GetMapping("/updateBoardFree")
	public String updateBoardFree(int freeCode, Model model) {
		BoardFree vo = service.oneBoardFree(freeCode);
		List<BoardFreeImg> imgList = service.oneBoardFreeImg(freeCode);
		
		if(imgList.size()!=0) {
			model.addAttribute("imgList", imgList);
		}
		model.addAttribute("vo", vo);
		
		return "boardFree/updateBoardFree";
	}
	
	// 게시물 수정
	@PostMapping("/updateBoardFree")
	public String updateBoardFree(BoardFree vo) throws IllegalStateException, IOException {

		// 게시글 수정 
		service.updateBordFree(vo);
		
		List<BoardFreeImg> listImg = service.oneBoardFreeImg(vo.getFreeCode());
		BoardFreeImg img=new BoardFreeImg();
		
		// 이미지 추가, 수정, 삭제 
		if(vo.getFile().get(0).getOriginalFilename()!=""&&vo.isDelImgBtn()==false) {
		// 새로운 이미지 있는 경우
			if(listImg.size()!=0) {
				// 기존 이미지 있는 경우 -> 기존 이미지 파일 삭제+db update
				for(BoardFreeImg photo : listImg) {
					File file = new File(path+photo.getFreeImgUrl());
					file.delete();
				} 
				service.deleteBoardFreeImg(vo.getFreeCode());
				for(int i=0; i<vo.getFile().size();i++) {
					String url = fileUpload(vo.getFile().get(i));
					img.setFreeImgUrl(url);
					img.setFreeCode(vo.getFreeCode());
					service.registerBoarddFreeImg(img);
				}
			} else {
				// 기존 이미지 없는 경우 -> db register
				for(int i=0; i<vo.getFile().size();i++) {
					String url = fileUpload(vo.getFile().get(i));
					img.setFreeImgUrl(url);
					img.setFreeCode(vo.getFreeCode());
					service.registerBoarddFreeImg(img);
				}
			}
		} else {
		// 새로운 이미지 없는 경우 
			if(listImg.size()!=0&&vo.isDelImgBtn()==true) {
			// 기존 이미지 있음, 삭제 원하는 경우
				for(BoardFreeImg photo : listImg) {
					File file = new File(path+photo.getFreeImgUrl());
					file.delete();
				} 
				service.deleteBoardFreeImg(vo.getFreeCode());
			}
		}
		return "redirect:/viewOneBoardFree?freeCode="+vo.getFreeCode();
	}
}
