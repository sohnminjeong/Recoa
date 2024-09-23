package com.recoa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.recoa.model.vo.Alarm;
import com.recoa.service.AlarmService;

@Controller
public class AlarmController {

	@Autowired
	private AlarmService service;
	
	@GetMapping("/viewAllAlarm")
	public String viewAllAlarm(int userCode, Model model) {
		System.out.println("userCode : "+userCode);
		List<Alarm> list = service.viewAllAlarm(userCode);
		model.addAttribute("list", list);
		return "alarm/viewAllAlarm";
	}
}
