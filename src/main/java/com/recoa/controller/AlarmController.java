package com.recoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.recoa.model.vo.Alarm;
import com.recoa.model.vo.NotePaging;
import com.recoa.service.AlarmService;

@Controller
public class AlarmController {

	@Autowired
	private AlarmService service;
	
	@GetMapping("/viewAllAlarm")
	public String viewAllAlarm(int userCode, Model model, @RequestParam(value="page", defaultValue="1")int page) {
		int total = service.countAllAlarm(userCode);
		NotePaging paging = new NotePaging(page, total, userCode);
		List<Alarm> list = service.viewAllAlarm(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "alarm/viewAllAlarm";
	}
	
}
