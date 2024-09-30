<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../../../resources/css/user/updateUserPwd.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
	<div id="userSideBar">
		<c:choose>
			<c:when test="${user.userAdmin=='admin'}"><%@ include file="../admin/adminSideBar.jsp" %></c:when>
			<c:otherwise><%@ include file="../user/userSideBar.jsp" %></c:otherwise>
		</c:choose>
	</div>
	<div id="container">
		<h3>비밀번호 변경</h3>
		<form action="/updateUserPwd" method="post" onsubmit="return validate()">
		<input type="hidden" name="userId" id="userId" value="${user.userId}">	
			<div>
				<input type="password" placeholder="현재 비밀번호" name="newUserPwd" id="userPwd"><br>
				<span id="userPwdCheck"></span>
			</div>
			<div>
				<input type="password" placeholder="변경할 비밀번호" name="userPwd" id="newUserPwd"><br>
				<span id="newUserPwdCheck"></span>
			</div>
			<div>
				<input type="password" placeholder="변경할 비밀번호 재입력" name="checkNewUserPwd" id="checkNewUserPwd"><br>
				<span id="newUserPwdDoubleCheck"></span>
			</div>
			<div id="btn">
				<button type="submit">비밀번호 변경 완료</button>
				<button type="button" onclick="location.href='/myPageUser';">비밀번호 변경 취소</button>
			</div>
		</form>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
	<script src="../../../resources/js/user/updateUserPwd.js"></script>
</body>
</html>