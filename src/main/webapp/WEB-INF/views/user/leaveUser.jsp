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
		margin-top:25px;
		width:300px;
		display:flex;
		flex-direction:row;
		justify-content:space-evenly;
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
	#afterPwdCheck{
		display:none;
		height:100%;
		width:100%;
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
</body>
</html>