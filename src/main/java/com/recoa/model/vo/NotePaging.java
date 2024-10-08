package com.recoa.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class NotePaging {

	private int page=1; // 현재 페이지
	private int offset = 0; //시작
	private int limit=10; // 레코드 수 (몇개 보일지)
	
	private int pageSize=10; // 한 페이지 당 페이지 갯수
	private int endPage;
	private int startPage;
	private int total;
	
	private String sort;
	
	private boolean prev;
	private boolean next;
	
	private int userCode;
	
	public NotePaging(int page, int total, int userCode) {
		this.userCode = userCode;
		this.page = page;
		this.total = total;
	
		int totalPages = (int) Math.ceil((double) total / this.limit);

		this.startPage = ((page - 1) / pageSize) * pageSize + 1;

		this.endPage = Math.min(startPage + pageSize - 1, totalPages);
	
		this.prev = this.startPage > 1;
		this.next = this.endPage < totalPages;
	}
	public NotePaging(int page, int total, int userCode, String sort) {
		this.userCode = userCode;
		this.page = page;
		this.total = total;
		this.sort = sort;
	
		int totalPages = (int) Math.ceil((double) total / this.limit);

		this.startPage = ((page - 1) / pageSize) * pageSize + 1;

		this.endPage = Math.min(startPage + pageSize - 1, totalPages);
	
		this.prev = this.startPage > 1;
		this.next = this.endPage < totalPages;
	}
}
