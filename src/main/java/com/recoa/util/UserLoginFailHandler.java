package com.recoa.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class UserLoginFailHandler implements AuthenticationFailureHandler{

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
			
			String url = "myPage";
			if (exception instanceof AuthenticationServiceException) {
				String loginFailMsg = "존재하지 않는 사용자입니다.";
				alertAndGo(response, loginFailMsg, url);
			} else if (exception instanceof BadCredentialsException) {
				String loginFailMsg = "아이디 또는 비밀번호가 틀립니다.";
				alertAndGo(response, loginFailMsg, url);
			} else if (exception instanceof DisabledException) {
				String loginFailMsg = "비활성화된 계정입니다.. 아니왜되던로그인이여기서만안돼";
				alertAndGo(response, loginFailMsg, url);
			}
		
	}
	public static void alertAndGo(HttpServletResponse response, String msg, String url) {
		try {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter w = response.getWriter();
			w.write("<script>alert('" + msg + "');location.href='" + url + "';</script>");
			w.flush();
			w.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
}
