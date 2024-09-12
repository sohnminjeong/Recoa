package com.recoa.service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.UtillbillDAO;
import com.recoa.model.vo.Utillbill;

@Service
public class UtillbillService {

	@Autowired
	private UtillbillDAO dao;

	
	// 독서실 하루 요금
    private static final BigDecimal lib_price = new BigDecimal("3000");
	
	// 예약 기간에 따른 총 요금 계산 함수
	private BigDecimal calculateLibraryPrice(LocalDateTime startTime, LocalDateTime endTime) {
        long daysBetween = ChronoUnit.DAYS.between(startTime, endTime) + 1;
        return lib_price.multiply(BigDecimal.valueOf(daysBetween));
    }
	
	// 원룸 하루 요금
	private static final BigDecimal one_price = new BigDecimal("40000");
	
	// 원룸
	private BigDecimal calculateGuestOnePrice(LocalDateTime startTime, LocalDateTime endTime) {
        long daysBetween = ChronoUnit.DAYS.between(startTime, endTime);
        return one_price.multiply(BigDecimal.valueOf(daysBetween));
    }
	
	// 투룸 하루 요금
	private static final BigDecimal two_price = new BigDecimal("50000");
	
	// 투룸
	private BigDecimal calculateGuestTwoPrice(LocalDateTime startTime, LocalDateTime endTime) {
        long daysBetween = ChronoUnit.DAYS.between(startTime, endTime);
        return two_price.multiply(BigDecimal.valueOf(daysBetween));
    }
	
	// TIMESTAMP를 LocalDateTime으로 변환하는 메서드
	private LocalDateTime convertToLocalDateTime(Timestamp timestamp) {
	    if (timestamp != null) {
	        return timestamp.toLocalDateTime();
	    }
	    return null;  // null인 경우 처리
	}
	
	public List<Utillbill> viewMyBills(String userCode) {
        List<Utillbill> bills = new ArrayList<>();
        
        // 당월 독서실 예약 조회
     // 당월 독서실 예약 조회
        List<Map<String, Object>> libList = dao.libraryBill(userCode);
        for (Map<String, Object> library : libList) {
            Utillbill bill = new Utillbill();
            bill.setServiceName("library");
            bill.setRegiDate((Date) library.get("regi_date"));
            
            bill.setStartTime((Date) library.get("start_time"));
            bill.setEndTime((Date) library.get("end_time"));
            
            // Date 타입의 startTime과 endTime을 LocalDate로 변환
            LocalDateTime startTime = convertToLocalDateTime((Timestamp) library.get("start_time"));
            LocalDateTime endTime = convertToLocalDateTime((Timestamp) library.get("end_time"));

            // 예약 기간에 따른 총 요금 계산
            BigDecimal totalPrice = calculateLibraryPrice(startTime, endTime);

            // 요금을 bill 객체에 설정
            bill.setPrice(totalPrice);
            bills.add(bill);
        }

        // 당월 게스트하우스 예약 조회
        List<Map<String, Object>> guestList = dao.guestBill(userCode);
        
        for (Map<String, Object> guest : guestList) {
            Utillbill bill = new Utillbill();
            bill.setServiceName("guest");
            bill.setRegiDate((Date) guest.get("regi_date"));
            
            LocalDateTime startTime = convertToLocalDateTime((Timestamp) guest.get("start_time"));
            LocalDateTime endTime = convertToLocalDateTime((Timestamp) guest.get("end_time"));

            bill.setStartTime((Date) guest.get("start_time"));
            bill.setEndTime((Date) guest.get("end_time"));
            
            int roomType = (int) guest.get("room_type");
            if (roomType == 1) {
                BigDecimal onePrice = calculateGuestOnePrice(startTime, endTime);
                bill.setRoomType("one");
                bill.setPrice(onePrice);
            } else {
                BigDecimal twoPrice = calculateGuestTwoPrice(startTime, endTime);
                bill.setRoomType("two");
                bill.setPrice(twoPrice);
            }
            bills.add(bill);
        }
        return bills; // 합쳐진 데이터를 반환
    }
	
	// 총합 계산 메서드
    public BigDecimal calculateTotalPrice(List<Utillbill> bills) {
        BigDecimal total = BigDecimal.ZERO;
        for (Utillbill bill : bills) {
            total = total.add(bill.getPrice());  // 가격을 모두 더함
        }
        return total;
    }
}
