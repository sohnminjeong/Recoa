package com.recoa.controller;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.recoa.model.vo.ReserveLibrary;
import com.recoa.model.vo.ReservePaging;
import com.recoa.model.vo.User;
import com.recoa.model.vo.Utillbill;
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
	
	// 관리자가 유저 ID로 사용 내역 (고지서) 조회
	@GetMapping("/viewUserBill")
	public String viewBill() {
		return "utillBill/viewBill";
	}
	
	@PostMapping("/viewUserBill")
	@ResponseBody
	public Map<String, Object> viewUserBill(@RequestParam(value = "id", defaultValue = "") String id) {
	    ReservePaging paging = new ReservePaging();
	    paging.setId(id);
	    List<Utillbill> bills = service.viewUserBills(id);

	    User user = service.viewUserDesc(id);

	    	BigDecimal totalPrice = service.calculateTotalPrice(bills);
		    BigDecimal libraryPrice = service.calculateLibPrice(bills);
		    BigDecimal guestPrice = service.calculateGuestPrice(bills);
		    BigDecimal guestOnePrice = service.calculateOneRoomGuestPrice(bills);
		    BigDecimal guestTwoPrice = service.calculateTwoRoomGuestPrice(bills);
		    
		    Map<String, Object> result = new HashMap<>();
		    
		    // 검색 결과가 없을 경우
		    if (bills == null || bills.isEmpty()) {
		        result.put("message", "검색 결과가 없습니다."); 
		        return result;  
		    }
		    
		    result.put("bills", bills);
		    result.put("totalPrice", totalPrice);
		    result.put("libraryPrice", libraryPrice);
		    result.put("guestOnePrice", guestOnePrice);
		    result.put("guestTwoPrice", guestTwoPrice);
		    result.put("guestPrice", guestPrice);
		    result.put("user", user);
		    
		    return result;
	}
}
