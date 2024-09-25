package com.recoa.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class LikedPaging {

	private int page=1; // 현재 페이지
	private int offset = 0; //시작
	private int limit=10; // 레코드 수 (몇개 보일지)
	
	private int pageSize=10; // 한 페이지 당 페이지 갯수
	private int endPage;
	private int startPage;
	private int total;
	
	private boolean prev;
	private boolean next;
	
	private int userCode;
	private String sort;
	
	public LikedPaging(int page, int total, int userCode) {
		this.page = page;
		this.total = total;
		this.userCode = userCode;
	
		int totalPages = (int) Math.ceil((double) total / this.limit);

		this.startPage = ((page - 1) / pageSize) * pageSize + 1;

		this.endPage = Math.min(startPage + pageSize - 1, totalPages);
	
		this.prev = this.startPage > 1;
		this.next = this.endPage < totalPages;
		
	}
	public LikedPaging(int page, int total, int userCode, String sort) {
		this.page = page;
		this.total = total;
		this.userCode = userCode;
		this.sort = sort;
	
		int totalPages = (int) Math.ceil((double) total / this.limit);

		this.startPage = ((page - 1) / pageSize) * pageSize + 1;

		this.endPage = Math.min(startPage + pageSize - 1, totalPages);
	
		this.prev = this.startPage > 1;
		this.next = this.endPage < totalPages;
		
	}
}
