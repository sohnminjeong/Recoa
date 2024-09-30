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
<link rel="stylesheet" href="../../../resources/css/user/leaveUser.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
	<div id="userSideBar">
		<c:choose>
			<c:when test="${user.userAdmin=='manager'||user.userAdmin=='admin'}"><%@ include file="../admin/adminSideBar.jsp" %></c:when>
			<c:otherwise><%@ include file="../user/userSideBar.jsp" %></c:otherwise>
		</c:choose>
	</div>
	<div id="container">
		<h3>회원 탈퇴</h3>
		<form action="/leaveUser" method="post" onsubmit="return validate()">
			<div id="pwdCheck">
				<span id="leave">[회원 탈퇴 위한 비밀번호 확인]</span>
				<input type="hidden" name="userId" id="userId" value="${user.userId}">
				<div>
					<span>현재 비밀번호</span>
					<input type="password" name="userPwd" id="userPwd" >
				</div>
				<div>
					<span>비밀번호 확인</span>
					<input type="password" name="userPwdCheck" id="userPwdCheck">
				</div>
				<span id="userPwdDoubleCheck"></span>
				<div id="btn">
					<button type="submit" id="pwdCheckBtn">회원 탈퇴</button>
					<button type="button" onclick="location.href='/myPageUser';">회원 탈퇴 취소</button>
				</div>
				
			</div>
		</form>
	</div>
</div>
<div id="userFloating">
		<%@ include file="../main/floating.jsp" %>
	</div>
<script>
let pwdDoubleCheck = false;
//변경할 비밀번호 재입력 일치 확인
$('#userPwdCheck').keyup((e) =>{
	let userPwdCheck=$(e.target).val(); 
	let userPwd = $('#userPwd').val();
	
	if(userPwdCheck==userPwd){
		pwdDoubleCheck = false;
	} else {
		pwdDoubleCheck = true;
	}
});

function validate(){
	if(userPwd.value==''){
		userPwd.focus();
		return false;
	} else if(userPwdCheck.value==''){
		userPwdCheck.focus();
		return false;
	} else if(pwdDoubleCheck){
		$('#userPwdDoubleCheck').text("현재 비밀번호와 일치하지 않습니다.").css("color", "gray");
		userPwdCheck.focus();
		return false;
	}
		return true;
	
}
</script>
</body>
</html>