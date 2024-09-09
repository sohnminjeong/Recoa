package com.recoa.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import com.recoa.model.dao.ReserveLibraryDAO;
import com.recoa.model.vo.ReserveLibrary;
import com.recoa.model.vo.ReservePaging;

@Service
public class ReserveLibraryService {

	@Autowired
	private ReserveLibraryDAO dao;
	
	// 사용 가능한 좌석 조회
	public List<Map<String, Object>> getAvailableSeats(Map<String, Object> params){
		return dao.getAvailableSeats(params);
	}
	
	public int registerLibrary(ReserveLibrary reserveLibrary) {
		return dao.registerLibrary(reserveLibrary);
	}
	
	// 내 게스트룸 예약 내역 조회
		public List<ReserveLibrary> myLibrary(ReservePaging paging){
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			UserDetails userDetails = (UserDetails) principal;

			paging.setOffset(paging.getLimit() * (paging.getPage() - 1));

			paging.setId(userDetails.getUsername());
			return dao.myLibrary(paging);
		}
		
		// 예약 내역 total
		public int libraryTotal() {
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			UserDetails userDetails = (UserDetails) principal;
			return dao.libraryTotal(userDetails.getUsername());
		}
		
		// 독서실 예약 취소
		public int cancelLibrary(Integer reserveLibraryCode) {
			return dao.cancelLibrary(reserveLibraryCode);
		}
		
		// 예약 취소 내역 조회
		public List<ReserveLibrary> mylibraryCancel(ReservePaging paging){
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			UserDetails userDetails = (UserDetails) principal;

			paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
			paging.setId(userDetails.getUsername());
			
			return dao.mylibraryCancel(paging);
		}
		
		// 취소 내역 total
		public int CancelLibrarytotal() {
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			UserDetails userDetails = (UserDetails) principal;
			return dao.CancelLibrarytotal(userDetails.getUsername());
		}
	
}
