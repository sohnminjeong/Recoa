<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<h3>비밀번호 변경</h3>
	<form action="/updateUserPwd" method="post" onsubmit="return validate()">
		<input type="text" name="userId" id="userId" value="${user.userId}" hidden>	
		<input type="password" placeholder="현재 비밀번호" name="newUserPwd" id="userPwd"><br>
		<span id="userPwdCheck"></span><br>
		<input type="password" placeholder="변경할 비밀번호" name="userPwd" id="newUserPwd"><br>
		<span id="newUserPwdCheck"></span><br>
		<input type="password" placeholder="변경할 비밀번호 재입력" name="checkNewUserPwd" id="checkNewUserPwd"><br>
		<span id="newUserPwdDoubleCheck"></span><br>
		<button type="submit">비밀번호 변경</button>
		
	</form>
	<script src="../../../resources/js/user/updateUserPwd.js"></script>
</body>
</html>