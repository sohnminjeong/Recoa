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
		<c:choose>
			<c:when test="${user.userImgUrl==null}">
				<img src="resources/images/user/default_profile.png"/><br>
			</c:when>
			<c:otherwise>
				<img src="/recoaImg/user/${user.userImgUrl}" /><br>
			</c:otherwise>
		</c:choose>
		프로필 이미지 : <input type="file" name="file" id="userImgUrl"><br>
		이름 : <input type="text" name="userRealName" placeholder="${user.userRealName}"><br>
		닉네임 : <input type="text" name="userNickname" placeholder="${user.userNickname}"><br>
		
		핸드폰번호 : <input type="text" name="userPhone" placeholder="${user.userPhone}"><br>
		거주동 : <input type="text" name="userAdr" placeholder="${user.userAdr}"><br>
		거주호수 : <input type="text" name="userAdrDetail" placeholder="${user.userAdrDetail}"><br>
		이메일 : <input type="text" name="userEmail" placeholder="${user.userEmail}"><br>
		
		<input type="submit">
	</form>
</body>
</html>