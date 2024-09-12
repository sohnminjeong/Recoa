package com.recoa.controller;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.recoa.model.vo.Utillbill;
import com.recoa.service.UtillbillService;

@Controller
public class UtillbillController {

	@Autowired
	private UtillbillService service;
	
	
	@GetMapping("/myBill")
	public String viewMyBill(Principal principal, Model model) {
		
		String userId = principal.getName();
		System.out.println("userId : " + userId);
//		service.viewMyBills(userId);
		// bills 리스트와 총합을 가져옴
        List<Utillbill> bills = service.viewMyBills(userId);
        BigDecimal totalPrice = service.calculateTotalPrice(bills);
        
		model.addAttribute("bills", bills);
		model.addAttribute("totalPrice", totalPrice);
		
		return "utillBill/viewMyBill";
	}
	
}
