package com.recoa.model.vo;

import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
public class Utillbill {
    private String serviceName; // "Library" 또는 "GuestHouse"
    private int reserveGuestCode;
    private int reserveLibraryCode;
    private Date startTime;
    private Date endTime;
    private Date regiDate;
    private String roomType;
    private BigDecimal price;
    private String userCode;
}
