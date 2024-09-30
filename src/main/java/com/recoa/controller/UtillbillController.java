package com.recoa.controller;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.recoa.model.vo.ReserveLibrary;
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
        BigDecimal guestOnePrice = service.calculateOneRoomGuestPrice(bills);
        BigDecimal guestTwoPrice = service.calculateTwoRoomGuestPrice(bills);
        
        ReserveLibrary lib = service.paymentStatus();
		if(lib.isPaid()) {
			model.addAttribute("paid", true);
		} else {
			model.addAttribute("paid", false);
		}
        
		model.addAttribute("bills", bills);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("libraryPrice", libraryPrice);
		model.addAttribute("guestOnePrice", guestOnePrice);
		model.addAttribute("guestTwoPrice", guestTwoPrice);
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
	
	@PostMapping("/updatebills")
	public String updateBills(Principal principal, @RequestParam(value="page", defaultValue="1") int page) {
		
		System.out.println("업데이트할건뎅");
		
		int total = service.libBillTotal() + service.guestBillTotal();
		ReservePaging paging = new ReservePaging(page, total);
		paging.setId(principal.getName());
		
        List<Utillbill> list = service.viewMyBills(paging);
        
		for(int i=0; i<list.size(); i++) {
			service.updateGuest(list.get(i).getReserveGuestCode());
			service.updateLibrary(list.get(i).getReserveLibraryCode());
		}
		return "utillBill/viewMyBill";
	}
}
