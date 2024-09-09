package com.recoa.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.recoa.model.vo.ReserveLibrary;
import com.recoa.model.vo.ReservePaging;

@Repository
public class ReserveLibraryDAO {
	
	@Autowired
	private SqlSessionTemplate session;
	
	// 사용 가능한 좌석 조회
	public List<Map<String, Object>> getAvailableSeats(Map<String, Object> params){
		return session.selectList("ReserveLibrary.checkSeat", params);
	}
	
	// 독서실 예약 등록
	public int registerLibrary(ReserveLibrary reserveLibrary) {
		return session.insert("ReserveLibrary.registerLibraryReserve", reserveLibrary);
	}
	
	// 내 독서실 예약 내역 조회
	public List<ReserveLibrary> myLibrary(ReservePaging paging){
		return session.selectList("ReserveLibrary.myLibrary", paging);
	}
	
	public int libraryTotal(String userId) {
		return session.selectOne("ReserveLibrary.libraryTotal", userId);
	}
	
	// 독서실 예약 취소
	public int cancelLibrary(Integer reserveLibraryCode) {
		return session.update("ReserveLibrary.cancelLibrary", reserveLibraryCode);
	}
	
	// 예약 취소 내역 조회
	public List<ReserveLibrary> mylibraryCancel(ReservePaging paging){
		return session.selectList("ReserveLibrary.myLibraryCancel", paging);
	}
	
	public int CancelLibrarytotal(String userId) {
		return session.selectOne("ReserveLibrary.CancelLibrarytotal", userId);
	}

}
