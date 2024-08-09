package com.recoa.model.vo;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class User implements UserDetails {
	private int userCode;
	private String userId;
	private String userPwd;
	private String userRealName;
	private String userNickname;
	private String userImgUrl;
	private String userPhone;
	private String userAdr;
	private String userAdrDetail;
	private String userEmail;
	private String userAdmin;  // 권한 : user, manager, admin
	
	// security 사용 시 권한 필수/enabled는 선택
	private int enabled;
	
	private boolean delUserImgUrl;
	private MultipartFile file;
	
	
	// 권한 관리 메서드
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		ArrayList<GrantedAuthority> authList = new ArrayList<>();
		authList.add(new SimpleGrantedAuthority(userAdmin));
		return authList;
	}
	
	@Override
	public String getPassword() {
		return userPwd;
	}
	@Override
	public String getUsername() {
		return userId;
	}
	
	
	@Override
	public boolean isAccountNonExpired() {
		
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {	
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	// 탈퇴 여부  
	@Override
	public boolean isEnabled() {
		return true;
	}
	

}
