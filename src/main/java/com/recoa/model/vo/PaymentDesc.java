package com.recoa.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class PaymentDesc {

	private String imp_uid;
	private String merchant_uid;
	private int month;
	private int day;
}
