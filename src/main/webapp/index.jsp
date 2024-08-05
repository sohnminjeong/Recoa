<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="WEB-INF/views/main/header.jsp" %>
 
	<sec:authentication property="principal" var="user" />
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