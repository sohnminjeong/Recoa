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
		width:90%;
		border : 2px solid black;
		border-radius : 30px;
		height:100%;
		 display: flex;
	    align-items: center;
	    padding: 40px 0px;
	    justify-content: center;
	   
	}

	form input{
		width : 200px;
		height:40px;
		border-radius:7px;
		font-family: 'GangwonEdu_OTFBoldA';
		font-size : 1.1rem;
		margin-bottom:5px;
	}
	#left, #right{
		width: 100%;
	    height: 100%;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    justify-content: space-around;
	}
	#left div, #right div{
		display: flex;
	    flex-direction: column;
	    width: 100%;
	    align-items: center;
	}
	form span{
		font-family: 'GangwonEdu_OTFBoldA';
		font-size : 1.1rem;
	}
	div#btn{
		width:300px;
		display: flex;
    	justify-content: space-around;
	}
	button{
		font-size : 1rem;
		font-family: 'GangwonEdu_OTFBoldA';
		border-radius:10px;
		padding-top:6px;
		border:none;
		width:105px; 
		height:35px;
		cursor:pointer;
		
	}
	button:hover{
		border : 1px solid black;
	}
	#pwdCheck{
		display:flex;
		flex-direction:column;
		justify-content : space-evenly;
		height:70%;
	}
	#pwdCheck #leave{
		font-size:1.4rem;
	}
	#pwdCheck div span{
		margin-right:20px;
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