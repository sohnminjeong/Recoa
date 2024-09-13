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
		
        List<Utillbill> bills = service.viewMyBills(userId);
        
        BigDecimal totalPrice = service.calculateTotalPrice(bills);
        BigDecimal libraryPrice = service.calculateLibPrice(bills);
        BigDecimal guestPrice = service.calculateGuestPrice(bills);
        
		model.addAttribute("bills", bills);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("libraryPrice", libraryPrice);
		model.addAttribute("guestPrice", guestPrice);
		
		return "utillBill/viewMyBill";
	}
	
	@GetMapping("/myBillLibDesc")
	public String viewMyLibDesc(Principal principal, Model model) {
		String userId = principal.getName();
		List<Utillbill> bills = service.viewMyLibDesc(userId);
		model.addAttribute("bills", bills);
		return "utillBill/myBillLibDesc";
	}
	
	@GetMapping("/myBillGuestDesc")
	public String viewMyGuestDesc(Principal principal, Model model) {
		String userId = principal.getName();
		List<Utillbill> bills = service.veiwMyGuestDesc(userId);
		model.addAttribute("bills", bills);
		return "utillBill/myBillGuestDesc";
	}
}
