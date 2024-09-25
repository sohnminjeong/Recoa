package com.recoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.recoa.model.vo.Alarm;
import com.recoa.model.vo.NotePaging;
import com.recoa.model.vo.User;
import com.recoa.service.AlarmService;
import com.recoa.service.UserService;

@Controller
public class AlarmController {

	@Autowired
	private AlarmService service;
	@Autowired
	private UserService userService;
	
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
}
