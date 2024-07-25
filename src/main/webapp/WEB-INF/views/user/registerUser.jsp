<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원가입 페이지</h2>
	<form action="/registerUser" method="post"  enctype="multipart/form-data">
		아이디 : <input type="text" name="userId"><br>
		비밀번호 : <input type="password" name="userPwd"><br>
		이름 : <input type="text" name="userName"><br>
		닉네임 : <input type="text" name="userNickname"><br>
		userImgUrl : <input type="file" name="file" id="userImgUrl"><br>
		핸드폰번호 : <input type="text" name="userPhone"><br>
		거주동 : <input type="text" name="userAdr"><br>
		거주호수 : <input type="text" name="userAdrDetail"><br>
		이메일 : <input type="text" name="userEmail"><br>
		<input type="submit">
	</form>
</body>
</html>