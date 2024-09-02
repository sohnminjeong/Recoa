package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.Note;
import com.recoa.model.vo.NoteFile;
import com.recoa.model.vo.NotePaging;
import com.recoa.model.vo.User;
import com.recoa.service.NoteService;
import com.recoa.service.UserService;

@Controller
public class NoteController {

	
	@Autowired
	private NoteService service;
	
	@Autowired
	private UserService userService;
	
	// 파일 저장
	private String path = "C:\\recoaImg\\note\\";
	
	// 파일 업로드 기능
	public String fileUpload(MultipartFile file) throws IllegalStateException, IOException {
		UUID uuid= UUID.randomUUID();
		String filename = uuid.toString()+"_"+file.getOriginalFilename();
		File copyFile = new File(path+filename);
		file.transferTo(copyFile);
		return filename;
	}
	
	/* ---------------------------------------------------- */	
	// 쪽지 보내기 페이지 이동
	@GetMapping("/registerNote")
	public String registerNote() {
		return "note/registerNote";
	}
	
	// 쪽지 보내기 
	@PostMapping("/registerNote")
	public String registerNote(Note vo) throws IllegalStateException, IOException {
		int senderCode = userService.findUserCode(vo.getSenderNick());
		vo.setNoteSender(senderCode);
		int receiverCode = userService.findUserCode(vo.getReceiverNick());
		vo.setNoteReceiver(receiverCode);
		service.registerNote(vo);
		NoteFile files = new NoteFile();
		if(vo.getNoteFile()!=null&&vo.getNoteFile().get(0).getOriginalFilename()!="") {
			for(int i=0; i<vo.getNoteFile().size(); i++) {
				String url = fileUpload(vo.getNoteFile().get(i));
				files.setNoteFileUrl(url);
				files.setNoteCode(vo.getNoteCode());
				service.registerNoteFile(files);
			}
		}
		
		return "redirect:/viewAllNote?userCode="+vo.getNoteSender();
	}
	
	// 쪽지 전체보기
	@GetMapping("/viewAllNote")
	public String viewAllNote(int userCode, Model model, @RequestParam(value="page", defaultValue="1") int page) {
		
		int total = service.total(userCode);
		NotePaging paging = new NotePaging(page, total, userCode);
		List<Note> list = service.viewAllNote(paging);
		for(int i=0; i<list.size();i++) {
			
			String senderNick=userService.findUserNickname(list.get(i).getNoteSender());
			list.get(i).setSenderNick(senderNick);
			String receiverNick=userService.findUserNickname(list.get(i).getNoteReceiver());
			list.get(i).setReceiverNick(receiverNick);
			
			List<NoteFile> listFile = service.viewAllNoteFile(list.get(i).getNoteCode());
			if(listFile.size()!=0) {
				list.get(i).setHasNote(true);
			}
		}
		
		model.addAttribute("list", list);
		model.addAttribute("paging",paging);
		
		return "note/viewAllNote";
	}
	
	// 보낸 쪽지함 전체 보기
	@GetMapping("/viewSenderNote")
	public String viewSederNote(int userCode, Model model, @RequestParam(value="page", defaultValue="1") int page) {
		int total = service.countSenderNote(userCode);
		NotePaging paging = new NotePaging(page, total, userCode);
		List<Note> list = service.viewAllBySender(paging);
		
		for(int i=0; i<list.size();i++) {
			String receiverNick=userService.findUserNickname(list.get(i).getNoteReceiver());
			list.get(i).setReceiverNick(receiverNick);
			List<NoteFile> listFile = service.viewAllNoteFile(list.get(i).getNoteCode());
			if(listFile.size()!=0) {
				list.get(i).setHasNote(true);
			}
		}
		
		model.addAttribute("list", list);
		model.addAttribute("paging",paging);
		return "note/viewSenderNote";
		
	}
	
	// 받은 쪽지함 전체 보기
	@GetMapping("/viewReceiverNote")
	public String viewReceiverNote(int userCode, Model model, @RequestParam(value="page", defaultValue="1") int page) {
		int total = service.countReceiverNote(userCode);
		NotePaging paging = new NotePaging(page, total, userCode);
		List<Note> list = service.viewAllByReceiver(paging);
		
		for(int i=0; i<list.size();i++) {
			String senderNick=userService.findUserNickname(list.get(i).getNoteSender());
			list.get(i).setSenderNick(senderNick);
			List<NoteFile> listFile = service.viewAllNoteFile(list.get(i).getNoteCode());
			if(listFile.size()!=0) {
				list.get(i).setHasNote(true);
			}
		}
		
		model.addAttribute("list", list);
		model.addAttribute("paging",paging);
		return "note/viewReceiverNote";
	}
	
	// 쪽지 한개 보기
	@GetMapping("/viewOneNote")
	public String viewOneNote(int noteCode, Model model) {
		Note vo = service.oneViewNote(noteCode);
		vo.setSenderNick(userService.findUserNickname(vo.getNoteSender()));
		vo.setReceiverNick(userService.findUserNickname(vo.getNoteReceiver()));
		List<NoteFile> files = service.viewAllNoteFile(noteCode);
		
		if(files.size()!=0) {
			model.addAttribute("files", files);
		}
		model.addAttribute("vo", vo);
		
		return "note/viewOneNote";
	}
	
	// 쪽지 삭제하기 
	@GetMapping("/deleteNote")
	public String deleteNote(int noteCode) {
		List<NoteFile> files = service.viewAllNoteFile(noteCode);
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String userId = userDetails.getUsername();
		User user = userService.selectUser(userId);
		Note vo = service.oneViewNote(noteCode);
		
		if(user.getUserCode()==vo.getNoteSender()) {
			service.deleteUpdateSender(noteCode);
		}else if(user.getUserCode()==vo.getNoteReceiver()) {
			service.deleteUpdateReceiver(noteCode);
		}
		
		int deleteSuccess = service.deleteNote(noteCode);
		
		if(deleteSuccess==1) {
			if(files!=null) {
				for(NoteFile noteFile : files) {
					File file = new File(path+noteFile.getNoteFileUrl());
					file.delete();
				}
			}
			service.deleteNoteFile(noteCode);
		}
		return "redirect:/viewAllNote?userCode="+user.getUserCode();
	}
}
