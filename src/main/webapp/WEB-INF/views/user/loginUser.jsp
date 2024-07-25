<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>로그인 페이지</h1>
	<form action="login" method="post">
		아이디 : <input type="text" name="username" id="userId"><br>
		비밀번호 : <input type="password" name="password" id="userPwd"><br>
		<input type="submit">
	</form>
</body>
</html>