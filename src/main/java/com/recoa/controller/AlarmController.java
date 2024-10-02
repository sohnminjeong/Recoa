package com.recoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.recoa.model.vo.Alarm;
import com.recoa.model.vo.BoardFree;
import com.recoa.model.vo.Note;
import com.recoa.model.vo.NotePaging;
import com.recoa.model.vo.User;
import com.recoa.service.AlarmService;
import com.recoa.service.NoteService;
import com.recoa.service.UserService;

@Controller
public class AlarmController {

	@Autowired
	private AlarmService service;
	@Autowired
	private UserService userService;
	@Autowired
	private NoteService noteService;
	
	@GetMapping("/viewAllAlarm")
	public String viewAllAlarm(int userCode, Model model, @RequestParam(value="page", defaultValue="1")int page, @RequestParam(value="sort", required = false)String sort) {
		int total = service.countAllAlarm(userCode);
		NotePaging paging = new NotePaging(page, total, userCode, sort);
		List<Alarm> list = service.viewAllAlarm(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "alarm/viewAllAlarm";
	}
	
	@GetMapping("deleteAlarm")
	public String deleteAlarm(int alarmCode) {
		service.deleteAlarm(alarmCode);
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String userId = userDetails.getUsername();
		User user = userService.selectUser(userId);
		
		return "redirect:/viewAllAlarm?userCode="+user.getUserCode();
	}
	
	// 게시물 존재 여부 확인
	@PostMapping("alarmCheck")
	@ResponseBody
	public Boolean alarmCheck(int code, int alarmCode) {
		System.out.println("code : "+code);
		System.out.println("alarmCode : "+alarmCode);
		BoardFree vo = service.alarmCheck(code);
		System.out.println("vo : "+vo);
		if(vo==null) {
		// 이미 삭제된 게시물일 경우
			service.updateAlarmCheck(alarmCode);
			return false;
		} else {
		// 존재하는 게시물일 경우
			return true;
		}
	}
	
	// 쪽지 존재 여부 확인
	@PostMapping("alarmNoteCheck")
	@ResponseBody
	public Boolean alarmNoteCheck(int code, int alarmCode) {
		Note vo = noteService.oneViewNote(code);
		if(vo==null){
			service.updateAlarmCheck(alarmCode);
			return false;
		} else {
			return true;
		}
	}

}
