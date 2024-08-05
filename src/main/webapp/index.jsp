<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Recoa 메인 화면 페이지</h1>
	<sec:authentication property="principal" var="user" />
	<span>로그인 유저 확인용 : </span> 
	${user}
	<br>
	<c:choose>
		<c:when test="${user=='anonymousUser'}">
			<a href="/loginUser">로그인 및 회원가입</a><br>
		</c:when>
		<c:otherwise>
			<a href="/selectUser">마이 페이지</a><br>
			<a href="/logout">로그아웃</a>	<br>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${user=='anonymousUser'}">
			<a href="/loginUser">게스트하우스 예약하기</a><br>
		</c:when>
		<c:otherwise>
			<a href="/reserveGuest">게스트하우스 예약하기</a>
		</c:otherwise>
	</c:choose>
	<%@ include file="WEB-INF/views/main/section1.jsp" %>
	
</body>
</html>