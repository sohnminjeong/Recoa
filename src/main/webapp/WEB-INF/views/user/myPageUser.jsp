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
<sec:authentication property="principal" var="user" />
	<h1>마이페이지</h1>
	<a href="/updateUser">내정보 설정</a><br>
	<a href="/updateUserPwd">비밀번호 변경</a>
	<div>
		<h2>프로필 이미지</h2>
		<c:choose>
			<c:when test="${user.userImgUrl==null}">
				<img src="resources/images/user/default_profile.png"/>
			</c:when>
			<c:otherwise>
				<img src="/recoaImg/user/${user.userImgUrl}" />
			</c:otherwise>
		</c:choose>
	</div>
	<div>
		<h2>아이디</h2>
		<p>${user.userId}</p>
	</div>
	<div>
		<h2>이름</h2>
		<p>${user.userRealName}</p>
	</div>
	<div>
		<h2>닉네임</h2>
		<p>${user.userNickname}</p>
	</div>
	
	<div>
		<h2>핸드폰 번호</h2>
		<p>${user.userPhone}</p>
	</div>
	<div>
		<h2>거주 동</h2>
		<p>${user.userAdr}</p>
	</div>
	<div>
		<h2>거주 호수</h2>
		<p>${user.userAdrDetail}</p>
	</div>
	<div>
		<h2>이메일</h2>
		<p>${user.userEmail}</p>
	</div>
			
</body>
</html>