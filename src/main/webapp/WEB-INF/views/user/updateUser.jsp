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
<link rel="stylesheet" href="../../../resources/css/user/updateUser.css" />
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
		<h3>내 정보 설정</h3>
		<form action="/updateUser" method="post"  enctype="multipart/form-data" onsubmit="return validate()">
			<div id="pwdCheck">
				<span>[정보 수정 위한 비밀번호 확인]</span>
				<input type="hidden" name="userId" id="userId" value="${user.userId}">
				<input type="password" name="userPwd" id="userPwd" placeholder="비밀번호 입력">
				<button type="button" id="pwdCheckBtn">비밀번호 확인</button>
			</div>
			<div id="afterPwdCheck">
				<div id="left">
					<div>
						<span>이름</span> 
						<input type="text" name="userRealName" id="userRealName" value="${user.userRealName}">	
						<span id="realNameCheck"></span>
					</div>
					<div>
						<span>핸드폰번호</span> 
						<input type="text" name="userPhone" id="userPhone" value="${user.userPhone}">
						<span id="userPhoneCheck"></span>
					</div>
					
					<div>
						<span>이메일</span> 
						<input type="text" name="userEmail" id="userEmail" value="${user.userEmail}">
						<span id="emailCheck"></span>
					</div>
				</div>
				<div id="right">
					<div>
						<span>거주동</span>  
						<input type="text" name="userAdr" id="userAdr" value="${user.userAdr}">
						<span id="userAdrCheck"></span>
					</div>
		
					<div>
						<span>거주호수</span>  
						<input type="text" name="userAdrDetail" id="userAdrDetail" value="${user.userAdrDetail}">
						 <span id="userAdrDetailCheck"></span>
					</div>
					<div id="btn">
						<button type="submit">정보 변경 완료</button>
						<button type="button" onclick="location.href='/myPageUser';">정보 변경 취소</button>
					</div>
				</div>	
			</div>
		</form>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script src="../../../resources/js/user/updateUser.js"></script>
</body>
</html>