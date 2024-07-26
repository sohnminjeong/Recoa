package com.recoa.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.recoa.model.vo.ReserveGuest;
import com.recoa.service.ReserveGuestService;

@Controller
public class ReserveGuestController {

	@Autowired
	private ReserveGuestService service;
	
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

        service.registeGuest(vo);

        return "guest/reserveSuccess"; // 예약 성공 페이지로 이동
       
	}
	

	
	
}
