package com.recoa.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.recoa.service.ReserveLibraryService;

@Controller
public class ReserveLibraryController {

	@Autowired
	private ReserveLibraryService service;
	
	@GetMapping("/reserveLibrary")
	public String reserveLibrary() {
		return "library/reserveLibrary";
	}
	
	// 좌석 예약 가능 여부 확인하기
	@GetMapping("/availableSeats")
	@ResponseBody
	public List<Map<String, Object>> getAvailableSeats(
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam(value="libraryCode", defaultValue = "1") int libraryCode){
		
		Map<String, Object> params = new HashMap<>();
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("libraryCode", libraryCode);
		
		return service.getAvailableSeats(params);
	}
	
	@PostMapping("/reserveLibrary")
	public String registLibrary(@RequestParam("startTime") String startTime, @RequestParam("endTime") String endTime,
			@RequestParam("userCode") int userCode, @RequestParam("libraryCode") int libraryCode,  @RequestParam("seatCode") String seatCode, Model model) throws ParseException {
			
		ReserveLibrary vo = new ReserveLibrary();
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = dateFormat.parse(startTime);
        Date endDate = dateFormat.parse(endTime);
		
		vo.setStartTime(startDate);
		vo.setEndTime(endDate);
		vo.setUserCode(userCode);
		vo.setLibraryCode(libraryCode);
		
		vo.setSeatCode(Integer.parseInt(seatCode));
		
		model.addAttribute("vo", vo);
		
		service.registerLibrary(vo);
		
		return "redirect:/myLibrary";
	}
	
	// 마이페이지 (내 독서실 예약 내역)
	@GetMapping("/myLibrary")
	public String myLibrary(Principal principal, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		// 페이징처리
		int total = service.libraryTotal();
					
		ReservePaging paging = new ReservePaging(page, total);
		List<ReserveLibrary> list = service.myLibrary(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
					
		return "library/myLibrary";
	} 
	
	@PostMapping("/cancelLibrary")
	public String cancelLibrary(Principal principal,  @RequestParam(value = "page", defaultValue = "1") int page, @RequestParam("reserveLibCode") Integer reserveLibCode, Model model) {
		int total = service.libraryTotal();
		
		ReservePaging paging = new ReservePaging(page, total);
		List<ReserveLibrary> list = service.mylibraryCancel(paging);
		
		service.cancelLibrary(reserveLibCode);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "redirect:/myLibrary";
	}
	
	// 마이페이지 (내 게스트룸 예약 취소 내역)
	@GetMapping("/myLibraryCancel")
	public String myLibraryCancel(Principal principal, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		int total = service.CancelLibrarytotal();
		
		ReservePaging paging = new ReservePaging(page, total);
		List<ReserveLibrary> list = service.mylibraryCancel(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "library/myLibraryCancel";
	}
	
	@GetMapping("/allLibrary")
	public String allLibrary(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		int total = service.allLibraryTotal();
		
		ReservePaging paging = new ReservePaging(page, total);
		List<ReserveLibrary> list = service.allLibrary(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		return "library/allLibrary";
	}
}
