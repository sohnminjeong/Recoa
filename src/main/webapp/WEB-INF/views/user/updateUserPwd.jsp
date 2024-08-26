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
<style>
@font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
	#header{
		position:absolute;
		z-index:1;
		width:100%;
	}
	#content{
		position:relative;
		z-index:0;
		height:100vh;
		padding-top:10vh;
		display:flex;
		align-items:center;
		margin:0 50px;
	}
	#content>#userSideBar{
		height:80%;
		width:15%;
		margin-left : 10%;
		margin-right:5%;
		
	}
	#content>#container{
		width: 75%;
		height:80%;
	    display: flex;
	    flex-direction: column;
	    margin-right: 10%;
	}
	#container>h3{
		font-size : 1.7rem;
		font-weight:bold;
		margin : 20px;
		font-family: 'GangwonEdu_OTFBoldA';
	}
	#container>form{
		width: 90%;
	    border: 2px solid black;
	    border-radius: 30px;
	    height: 100%;
	    display: flex;
	    align-items: center;
	    padding: 40px 0px;
	    justify-content: space-evenly;
	    flex-direction: column;
	}
	form div{
		width: 100%;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    flex-direction: column;
	}
	form input{
		width : 300px;
		height:50px;
		border-radius:7px;
		font-family: 'GangwonEdu_OTFBoldA';
		font-size : 1.1rem;
		margin-bottom:5px;
	}
	form span{
		font-family: 'GangwonEdu_OTFBoldA';
		font-size : 1.1rem;
	}
	form #btn{
		display:flex;
		justify-content:center;
		flex-direction:row;
	}
	button{
		font-size : 1rem;
		font-family: 'GangwonEdu_OTFBoldA';
		border-radius:10px;
		padding-top:6px;
		border:none;
		width:150px; 
		height:35px;
		cursor:pointer;
		margin : 0 30px;
	}
	button:hover{
		border : 1px solid black;
	}
#userFloating{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    right: 4%;
}
</style>
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