package com.recoa.controller;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.recoa.model.vo.ReservePaging;
import com.recoa.model.vo.Utillbill;
import com.recoa.service.ReserveGuestService;
import com.recoa.service.ReserveLibraryService;
import com.recoa.service.UtillbillService;

@Controller
public class UtillbillController {

	@Autowired
	private UtillbillService service;
	
	@GetMapping("/myBill")
	public String viewMyBill(Principal principal, @RequestParam(value="page", defaultValue="1") int page, Model model) {
		
		// 페이징처리
		int total = service.libBillTotal() + service.guestBillTotal();
		ReservePaging paging = new ReservePaging(page, total);
		paging.setId(principal.getName());
		
        List<Utillbill> bills = service.viewMyBills(paging);
        
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
	public String viewMyLibDesc(Principal principal, @RequestParam(value="page", defaultValue="1") int page, Model model) {

		int total = service.libBillTotal();
		ReservePaging paging = new ReservePaging(page, total);
		paging.setId(principal.getName());
		
		List<Utillbill> bills = service.viewMyLibDesc(paging);
		model.addAttribute("bills", bills);
		model.addAttribute("paging", paging);
		
		return "utillBill/myBillLibDesc";
	}
	
	@GetMapping("/myBillGuestDesc")
	public String viewMyGuestDesc(Principal principal, @RequestParam(value="page", defaultValue="1") int page, Model model) {
		int total = service.guestBillTotal();
		
		ReservePaging paging = new ReservePaging(page, total);
		paging.setId(principal.getName());
		
		List<Utillbill> bills = service.veiwMyGuestDesc(paging);
		model.addAttribute("bills", bills);
		model.addAttribute("paging", paging);
		
		return "utillBill/myBillGuestDesc";
	}
}
