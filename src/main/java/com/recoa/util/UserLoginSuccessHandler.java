package com.recoa.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class UserLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		List<String> roleNames = new ArrayList<>();
		
		authentication.getAuthorities().forEach(authority->{
			String auth = authority.getAuthority();
			roleNames.add(auth);
		});
		
		if(roleNames.contains("admin")) {
			response.sendRedirect("/adminPage");
			return;
		}
//		else if(roleNames.contains("user")) {
//			response.sendRedirect("/myPageUser");
//			return;
//		} 
		response.sendRedirect("/");
	}
	
}
