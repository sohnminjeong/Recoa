package com.recoa.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.recoa.model.vo.ReserveGuest;
import com.recoa.model.vo.ReservePaging;
import com.recoa.model.vo.Utillbill;
import com.recoa.service.ReserveGuestService;


@Controller
public class ReserveGuestController {

	@Autowired
	private ReserveGuestService service;
	
	// 객실 예약 가능 여부 확인하기
    @GetMapping("/availableRooms")
    @ResponseBody
    public List<Map<String, Object>> getAvailableRooms(
            @RequestParam("startTime") String startTime,
            @RequestParam("endTime") String endTime,
            @RequestParam(value="roomType", defaultValue = "1") int roomType) {

        Map<String, Object> params = new HashMap<>();
        params.put("startTime", startTime);
        params.put("endTime", endTime);
        params.put("roomType", roomType);

        System.out.println("Available rooms: " + service.getAvailableRooms(params)); // 로그 추가
        System.out.println("controller : " + service.getAvailableRooms(params));
        System.out.println("roomType : " + roomType);
        return service.getAvailableRooms(params); // JSP 페이지 이름
    }
	
	
	// 예약하기 페이지 불러오기
	@GetMapping("/reserveGuest")
	public String reserveGuest() {
		return "guest/reserveGuest";
	}
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
	
	@PostMapping("/reserveGuest")
	public String reserveGuest( @RequestParam("startTime") Date startTime,
					            @RequestParam("endTime") Date endTime,
					            @RequestParam("userCode") int userCode,
					            @RequestParam("roomType") int roomType,
					            @RequestParam("roomCode") int roomCode,
								Model model) throws ParseException {
		
		
        // ReserveGuest 객체 생성 및 데이터 설정
        ReserveGuest vo = new ReserveGuest();
        vo.setStartTime(startTime);
        vo.setEndTime(endTime);
        
        vo.setUserCode(userCode);
        vo.setRoomType(roomType);
        vo.setRoomCode(roomCode);
        
        // 모델에 추가
        model.addAttribute("vo", vo);

        // 예약 등록
        service.registeGuest(vo);

        // 고지서 관리
        // 1. 고지서 조회
        LocalDate today = LocalDate.now();
        int year = today.getYear();
        int month = today.getMonthValue(); 
        
        // 두 날짜 사이의 차이를 밀리초로 계산
        long diffInMillis = endTime.getTime() - startTime.getTime();

        // 밀리초를 일(day) 단위로 변환
        int diffInDays = (int) (diffInMillis / (1000 * 60 * 60 * 24));

        
        Utillbill checkbill = new Utillbill();
        checkbill.setUserCode(userCode);
        checkbill.setBillYear(year);
        checkbill.setBillMonth(month);
        
        // 해당 유저의 고지서 존재 여부 확인
        List<Utillbill> check = service.checkBill(checkbill);
        
        if(check.size() == 0) {
        	System.out.println("유저의 고지서가 비어있구나 등록!");
        	// 2. 첫 고지서 등록
        	
        	Utillbill bill = new Utillbill();
        	bill.setUserCode(vo.getUserCode());
        	bill.setBillYear(year);
        	bill.setBillMonth(month);
        	bill.setLibUsePeriod(0);
        	bill.setLibTotalPrice(0);
        	
        	
        	if(vo.getRoomType() == '1') {
        		bill.setGuest1UsePeriod(diffInDays);
        		bill.setGuest2UsePeriod(0);
        		bill.setRoomTotalPrice(diffInDays * 40000);
        		bill.setTotalPrice(diffInDays * 40000);
        	} else {
        		bill.setGuest2UsePeriod(diffInDays);
        		bill.setGuest1UsePeriod(0);
        		bill.setRoomTotalPrice(diffInDays * 50000);
        		bill.setTotalPrice(diffInDays * 50000);
        	}
        	
        	System.out.println("등록 : " + bill);
        	service.registBill(bill);
        } else {
        	// 고지서 업데이트 쿼리
        	
        	Utillbill bill = new Utillbill();
        	
        	bill.setUserCode(userCode);
        	
        	if(vo.getRoomType() == '1') {
        		bill.setGuest1UsePeriod(diffInDays);
        		bill.setGuest2UsePeriod(0);
        		bill.setRoomTotalPrice(diffInDays * 40000);
        		bill.setTotalPrice(diffInDays * 40000);
        	} else {
        		bill.setGuest2UsePeriod(diffInDays);
        		bill.setGuest1UsePeriod(0);
        		bill.setRoomTotalPrice(diffInDays * 50000);
        		bill.setTotalPrice(diffInDays * 50000);
        	}
        	System.out.println("업데이트!");
        	//service.updateBill(bill);
        }
        return "redirect:/myGuest"; // 예약 성공 페이지로 이동
	}

	// 마이페이지 (내 게스트룸 예약 내역)
	@GetMapping("/myGuest")
	public String myGuest(Principal principal, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		// 페이징처리
		int total = service.Guesttotal();
					
		ReservePaging paging = new ReservePaging(page, total);
		List<ReserveGuest> list = service.myGuest(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
//		paging.setKeyword(keyword);
//		paging.setSelect(select);
					
		return "guest/myGuest";
	} 
	
	// 마이페이지 (내 게스트룸 예약 취소 내역)
	@GetMapping("/myGuestCancel")
	public String myGuestCancel(Principal principal, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		int total = service.CancelGuesttotal();
		
		ReservePaging paging = new ReservePaging(page, total);
		List<ReserveGuest> list = service.myGuestCancel(paging);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "guest/myGuestCancel";
	}
	
	@PostMapping("/cancelGuest")
	public String cancelGuest(Principal principal,  @RequestParam(value = "page", defaultValue = "1") int page, @RequestParam("reserveGuestCode") Integer reserveGuestCode, Model model) {
		int total = service.Guesttotal();
		
		ReservePaging paging = new ReservePaging(page, total);
		List<ReserveGuest> list = service.myGuestCancel(paging);
		
		System.out.println("reserveGuestCode : " + reserveGuestCode);
		service.cancelGuest(reserveGuestCode);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "redirect:/myGuest";
	}
	
	
}
