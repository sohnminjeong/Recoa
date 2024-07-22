package com.recoa.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class User {
	private int userCode;
	private String userId;
	private String userPwd;
	private String userName;
	private String userNickname;
	private String userImgUrl;
	private String userPhone;
	private String userAdr;
	private String userAdrDetail;
	private String userEmail;
	private String userAdmin;
	
}
