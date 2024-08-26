package com.recoa.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.recoa.model.vo.Note;
import com.recoa.model.vo.NoteFile;
import com.recoa.service.NoteService;

@Controller
public class NoteController {

	
	@Autowired
	private NoteService service;
	
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
		service.registerNote(vo);
		NoteFile files = new NoteFile();
		if(vo.getFile()!=null&&vo.getFile().get(0).getOriginalFilename()!="") {
			for(int i=0; i<vo.getFile().size(); i++) {
				String url = fileUpload(vo.getFile().get(i));
				files.setNoteFileUrl(url);
				files.setNoteCode(vo.getNoteCode());
				service.registerNoteFile(files);
			}
		}
		return "/";
	}
}
