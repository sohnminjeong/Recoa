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
	<h2>회원 정보 수정</h2>
	<form action="/updateUser" method="post"  enctype="multipart/form-data">
	<sec:authentication property="principal" var="user" />
		<input type="text" name="userId" readonly value="${user.userId}" hidden>
		이름 : <input type="text" name="userRealName" placeholder="${user.userRealName}"><br>		
		핸드폰번호 : <input type="text" name="userPhone" placeholder="${user.userPhone}"><br>
		거주동 : <input type="text" name="userAdr" placeholder="${user.userAdr}"><br>
		거주호수 : <input type="text" name="userAdrDetail" placeholder="${user.userAdrDetail}"><br>
		이메일 : <input type="text" name="userEmail" placeholder="${user.userEmail}"><br>
		<input type="submit">
	</form>
</body>
</html>