package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.BoardNotice;
import com.recoa.model.vo.BoardNoticeImg;
import com.recoa.model.vo.BoardNoticePaging;
import com.recoa.model.vo.NoticeBookmark;
import com.recoa.model.vo.User;
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
		
		int total = service.noticeListTotal();
		BoardNoticePaging paging = new BoardNoticePaging(page, total);
		paging.setSelect(select);
		paging.setKeyword(keyword);
		
		int offset = (page - 1) * paging.getLimit();
		paging.setOffset(offset); 
		
		List<BoardNotice> list = service.viewNoticeList(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		System.out.println("list : " + list);
		// 북마크 개수 
		Map<Integer, Integer> bookmarkCount = new HashMap<>();
	    
	    for (BoardNotice notice : list) {
	        int count = service.countBookmark(notice.getNoticeCode());
	        bookmarkCount.put(notice.getNoticeCode(), count);
	    }
	    
	    model.addAttribute("bookmarkCount", bookmarkCount);
	    
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
	public String viewNotice(int noticeCode, Model model, HttpSession session, Principal principal) {
		
		String sessionKey = "viewedNotice_" + noticeCode;
		
	    // 새로고침 시 조회수가 계속 올라가는 현상 막기 (한 번 조회한 사람은 조회수 증가에 영향x)
	    if (session.getAttribute(sessionKey) == null) {
	        service.addViewCount(noticeCode);  				// 조회수 증가
	        session.setAttribute(sessionKey, true);
	    }
	    
	    int isBookmarked = 0;
	    
	    // 북마크 여부 확인
	    // 로그인 된 회원의 경우
	    if(principal != null) {
	    	String userId = principal.getName(); 
	        int userCode = service.findUserCode(userId);
	        
	        NoticeBookmark vo = new NoticeBookmark();
	        vo.setUserCode(userCode);
	        vo.setNoticeCode(noticeCode);
	        
	        isBookmarked = service.checkBookmark(vo);
	        model.addAttribute("isBookmarked", isBookmarked);
	    }
	    
	    // 북마크 갯수 확인
	    int count = service.countBookmark(noticeCode);
		
		BoardNotice notice = service.viewNotice(noticeCode);
		notice.setBookmarkCount(count);
		
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
	
	/*----- 북마크 -----*/
	
	// 북마크 생성, 삭제
	@PostMapping("/updateBookmark")
	@ResponseBody
	public String updateBookmark(@RequestParam("noticeCode") int noticeCode, Principal principal) {
	    String userId = principal.getName();
	       
	    int userCode = service.findUserCode(userId);
	        
	    NoticeBookmark vo = new NoticeBookmark();
	    vo.setUserCode(userCode);
	    vo.setNoticeCode(noticeCode);
	        
	    int isBookmarked = service.checkBookmark(vo);

	    if (isBookmarked == 1) {
	        service.delBookmark(vo);
	        return "deleted";
	    } else {
	        service.addBookmark(vo);
	        return "added";
	    }
	}
	
	// 북마크한 글만 보기
	@GetMapping("/bookmarked")
	public String bookmarked(@RequestParam(value = "page", defaultValue = "1") int page,
										Model model, String select, String keyword, Principal principal) {
		
		String userId = principal.getName(); 
	    int userCode = service.findUserCode(userId);
			
	    NoticeBookmark vo = new NoticeBookmark();
	    vo.setUserCode(userCode);
	    System.out.println(userCode);
	       
		int total = service.bookmarkedTotal(userCode);
		System.out.println(total);
			
		BoardNoticePaging paging = new BoardNoticePaging(page, total);
		paging.setUserCode(userCode);
		paging.setSelect(select);
		paging.setKeyword(keyword);
			
		int offset = (page - 1) * paging.getLimit();
		paging.setOffset(offset); 
			
		List<BoardNotice> list = service.bookmarked(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		Map<Integer, Integer> bookmarkCount = new HashMap<>();
	    
	    for (BoardNotice notice : list) {
	        int count = service.countBookmark(notice.getNoticeCode());
	        bookmarkCount.put(notice.getNoticeCode(), count);
	    }
	    
	    model.addAttribute("bookmarkCount", bookmarkCount);
		
		return "boardNotice/myBookmark";
	}

}
