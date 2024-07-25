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
	${user}
	<br>
	<c:choose>
		<c:when test="${user=='anonymousUser'}">
			<a href="/loginUser">로그인</a><br>
			<a href="/registerUser">회원가입</a><br>
		</c:when>
		<c:otherwise>
		<!-- <sec:authorize access="hasRole('ROLE_ADMIN') and isAuthenticated()">
				<a href="/admin">관리자 페이지</a><br>
			</sec:authorize> -->
			<a href="/logout">로그아웃</a>	
		</c:otherwise>
	</c:choose>

</body>
</html>