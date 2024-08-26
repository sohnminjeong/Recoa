package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

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

import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.BoardFreeComment;
import com.recoa.model.vo.BoardFreeImg;
import com.recoa.model.vo.BoardFreePaging;
import com.recoa.model.vo.FreeLike;
import com.recoa.model.vo.User;
import com.recoa.service.BoardFreeCommentService;
import com.recoa.service.BoardFreeService;
import com.recoa.service.UserService;

@Controller
public class BoardFreeController {

	 @Autowired
	 private BoardFreeService service;
	 @Autowired
	 private BoardFreeCommentService commentService;
	 @Autowired
	 private UserService userService;
	
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
	public String viewOneBoardFree(int freeCode, Model model, @RequestParam(value="page", defaultValue="1")int page) {
		service.updateFreeView(freeCode);
		BoardFree vo = service.oneBoardFree(freeCode);
		List<BoardFreeImg> imgList = service.oneBoardFreeImg(freeCode);
		model.addAttribute("vo", vo);
		model.addAttribute("imgList", imgList);
		model.addAttribute("countLike", service.countFreeLike(freeCode));
		
		// 이미 좋아요 누른 user일 경우
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal!="anonymousUser") {
			// 비회원일 경우에만 진행
			UserDetails userDetails = (UserDetails) principal;
			String userId = userDetails.getUsername();
			User user = userService.selectUser(userId);
			FreeLike like = new FreeLike();
			like.setFreeCode(freeCode);
			like.setUserCode(user.getUserCode());
			if(service.checkUserFreeLike(like)==1) {
				// 이미 좋아요 한 경우
				model.addAttribute("like", true);
			}else{
				// 좋아요 안 한 경우
				model.addAttribute("like",false);
			};	
		}
		
		
		// 댓글 전체 보기
		int commentTotal = commentService.commentTotal(freeCode);
		BoardFreePaging commentPaging = new BoardFreePaging(page, commentTotal, freeCode);
		List<BoardFreeComment> commentList = commentService.viewAllBoardFreeComment(commentPaging);
		model.addAttribute("commentList", commentList);	
		model.addAttribute("commentPaging", commentPaging);
		return "boardFree/viewOneBoardFree";
	}
	
	// 게시물 좋아요 
	@ResponseBody
	@PostMapping("/updateFreeLike")
	public Integer updateFreeLike(@RequestParam Map<Object, String> map) {

		FreeLike vo = new FreeLike();
		
		int freeCode = Integer.parseInt(map.get("freeCode"));
		int userCode = Integer.parseInt(map.get("userCode"));
		int likeCheck = Integer.parseInt(map.get("likeCheck"));
	
		vo.setFreeCode(freeCode);	
		vo.setUserCode(userCode);
		
		if(likeCheck==1) {
			// 좋아요 누른 경우
			service.insertFreeLike(vo);
		} else {
			// 좋아요 취소한 경우
			service.deleteFreeLike(vo);
		}
		return service.countFreeLike(freeCode);
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
		
		// 이미지 
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
			if(listImg.size()!=0&&vo.getFile().size()==0&&vo.isDelImgBtn()==true) {
			// 기존 이미지 있음, 삭제 원하는 경우
				for(BoardFreeImg photo : listImg) {
					File file = new File(path+photo.getFreeImgUrl());
					file.delete();
				} 
				service.deleteBoardFreeImg(vo.getFreeCode());
			} else if(vo.getFile().size()!=0&&vo.isDelImgBtn()==true) {
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
			}
		}
		return "redirect:/viewOneBoardFree?freeCode="+vo.getFreeCode();
	}
	
	/*---------------------- 댓글 ----------------------------*/
	// 댓글 작성
	@PostMapping("/registerBoardFreeComment")
	public String registerBoardFreeComment(BoardFreeComment vo) {
		commentService.registerBoardFreeComment(vo);
		return "redirect:/viewOneBoardFree?freeCode="+vo.getFreeCode();
	}
	
	// 댓글 전체 보기 -> 게시물 보기에 작성 
	
	// 댓글 삭제 
	@GetMapping("/deleteBoardFreeComment")
	public String deleteBoardFreeComment(int freeCommentCode, int freeCode) {
		commentService.deleteBoardFreeComment(freeCommentCode);
		return "redirect:/viewOneBoardFree?freeCode="+freeCode;
	}
	
	// 댓글 수정
	@PostMapping("/updateBoardFreeComment")
	public String updateBoardFreeComment(BoardFreeComment vo) {
		commentService.updateBoardFreeComment(vo);
		int freeCode = commentService.findFreeCodeByCommentCode(vo.getFreeCommentCode());
		return "redirect:/viewOneBoardFree?freeCode="+freeCode;
	}
	
	/*---------------------- 대댓글 ----------------------------*/
	// 대댓글 작성
	@PostMapping("/registerReplyComment")
	public String registerReplyComment(BoardFreeComment vo) {
		System.out.println("vo  : "+vo);
		commentService.registerReplyComment(vo);
		return "redirect:/viewOneBoardFree?freeCode="+vo.getFreeCode();
	}
}
