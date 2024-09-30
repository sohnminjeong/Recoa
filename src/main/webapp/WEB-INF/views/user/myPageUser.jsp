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
<link rel="stylesheet" href="../../../resources/css/user/myPageUser.css" />
</head>
<body>
<sec:authentication property="principal" var="user" /> 
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>

<div id="content">
	<div id="userSideBar">
		<%@ include file="../user/userSideBar.jsp" %>
	</div>
	<div id="container">
		<h3>내 정보</h3>
		<div id="containerContent">
			<div id="img">
				<c:choose>
					<c:when test="${user.userImgUrl==null}">
						<img src="resources/images/user/default_profile.png"/>
					</c:when>
					<c:otherwise>
						<img src="/recoaImg/user/${user.userImgUrl}" />
					</c:otherwise>
				</c:choose>
			</div>
			<div id="userInfo">
				<p>아이디 : ${user.userId}</p>
			
				<p>이름 : ${user.userRealName}</p>
			
				<p>닉네임 : ${user.userNickname}</p>
			
				<p>핸드폰 번호 : ${user.userPhone}</p>
			
				<p>거주 동 : ${user.userAdr}</p>
			
				<p>거주 호수 : ${user.userAdrDetail}</p>
			
				<p>이메일 : ${user.userEmail}</p>
			</div>
		</div>
	</div>
</div>	
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</body>
</html>