package com.recoa.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class Utillbill {
	private int billCode;
	private int userCode;
	private int billYear;
	private int billMonth;
	private int libUsePeriod;
	private int libTotalPrice;
	private int guest1UsePeriod;
	private int guest2UsePeriod;
	private int roomTotalPrice;
	private int totalPrice;
}
