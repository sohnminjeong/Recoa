package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.BoardNotice;
import com.recoa.model.vo.BoardNoticeImg;
import com.recoa.model.vo.BoardNoticePaging;
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
	public String boardNoticeList(@RequestParam(value = "page", defaultValue = "1") int page,
								Model model, String select, String keyword) {
		
		System.out.println("page : " + page);
		
		int total = service.noticeListTotal();
		BoardNoticePaging paging = new BoardNoticePaging(page, total);
		paging.setSelect(select);
		paging.setKeyword(keyword);
		
		int offset = (page - 1) * paging.getLimit();
		paging.setOffset(offset); 
		System.out.println("offset : " + paging.getOffset());
		
		List<BoardNotice> list = service.viewNoticeList(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
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
	
	// 공지 한 개 보기
	@GetMapping("/viewNotice")
	public String viewNotice(int noticeCode, Model model, HttpSession session) {
		
		String sessionKey = "viewedNotice_" + noticeCode;
		
	    // 새로고침 시 조회수가 계속 올라가는 현상 막기 (한 번 조회한 사람은 조회수 증가에 영향x)
	    if (session.getAttribute(sessionKey) == null) {
	        service.addViewCount(noticeCode);  				// 조회수 증가
	        session.setAttribute(sessionKey, true);
	    }
		
		BoardNotice notice = service.viewNotice(noticeCode);
		List<BoardNoticeImg> images = service.noticeImg(noticeCode);
		model.addAttribute("notice", notice);
		model.addAttribute("images", images);
		
		return "boardNotice/viewBoardNotice";
	}
	

	
	// 공지 삭제하기
	@GetMapping("/deleteNotice")
	public String deleteNotice(int noticeCode) {
		List<BoardNoticeImg> images = service.noticeImg(noticeCode);
		if(images != null) {
			for(BoardNoticeImg image : images) {
				File file = new File(path + image.getNoticeImgUrl());
				file.delete();
			}
		}
		service.deleteNotice(noticeCode);
		service.deleteImg(noticeCode);
		
		return "redirect:/boardNoticeList";
	}
}
