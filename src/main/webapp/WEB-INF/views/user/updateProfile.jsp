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
		height:90vh;
		padding-top:10vh;
		display:flex;
		align-items:center;
		margin:0 50px;
	}
	#content>#userSideBar{
		height:70%;
		width:15%;
		margin-left : 10%;
		margin-right:5%;
		
	}
	#content>#container{
		width: 75%;
		height:70%;
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
		width:80%;
		border : 2px solid black;
		border-radius : 30px;
		height:100%;
		display:flex;
	}
	form>#img{
	    display: flex;
	    padding: 50px;
	    align-items: center;
	    flex-direction:column;
	    justify-content: space-around;
	}
	#img>img{
		border-radius: 50%;
	    width: 250px;
	    height: 250px;
	    cursor:pointer;
	}
	#img>img:hover{
		border : 1px solid black;
	}
	form>#userInfo{
		width:100%;
		padding:50px;
		display:flex;
		flex-direction:column;
		justify-content:center;
	}
	#userInfo>p, input{
		font-size : 1.3rem;
		font-family: 'GangwonEdu_OTFBoldA';
	}
	#userInfo>input{
		width:60%;
		margin-top:10px;
	}
	#userInfo>#btn{
		margin-top:25px;
		width:60%;
		display:flex;
		justify-content:space-evenly;
	}
	button{
		font-size : 1rem;
		font-family: 'GangwonEdu_OTFBoldA';
		border-radius:10px;
		padding-top:6px;
		border:none;
		width:100px; 
		height:35px;
		cursor:pointer;
	}
	button:hover{
		border : 1px solid black;
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
		<h3>프로필 설정</h3>
		<form action="updateProfile" method="post" enctype="multipart/form-data" onsubmit="return validate()">
		<input type="hidden" name="userId" value="${user.userId}" >
			<div id="img">
				<c:choose>
					<c:when test="${user.userImgUrl==null}">
						<img src="resources/images/user/default_profile.png" class="userImg"/>
					</c:when>
					<c:otherwise>
						<img src="/recoaImg/user/${user.userImgUrl}" class="userImg"/>
					</c:otherwise>
				</c:choose>
					<input type="file" name="file" id="userImgUrl" style="display: none;" accept="image/*">	
			<button onclick="delImg()">이미지 삭제</button>
			</div>
 			<div id="userInfo">
				<p>닉네임</p> 
				<input type="text" name="userNickname" placeholder="${user.userNickname}" id="userNickname"><br>
				<span id="nickNameCheck" style="font-family: 'GangwonEdu_OTFBoldA'"></span>
				<div id="btn">
					<button type="submit">변경 완료</button>
					<button type="button" onclick="location.href='/myPageUser';">변경 취소</button>
				</div>
			</div>
		</form>
	</div>
	<script>
    const userImgUrl = document.querySelector('#userImgUrl');
    const userImg = document.querySelector('.userImg');
    userImg.addEventListener('click', () => userImgUrl.click());
   
    let userNicknameCheck = false;
 /// 닉네임 중복확인
    $('#userNickname').keyup(() => {
    	const userNickname = $('#userNickname').val();
    	$.ajax({
    		type: "post",
    		url: "/nickNameCheck",
    		data: "userNickname=" + userNickname,

    		success: function (result) {
    			if (result) {
    				$('#nickNameCheck').text("중복된 닉네임입니다").css("color", "gray");
    				userNicknameCheck = true;
    			} else {
    				$('#nickNameCheck').text("").css("color", "gray");
    				userNicknameCheck = false;
    			}
    		}
    	})
    })
    
    function validate(){
    	if(userNickname.value==''){
    		userNickname.focus();
    		return false;
    	}else if(userNicknameCheck){
    		userNickname.focus();
    		return false;
    	}
    	alert("변경이 완료되었습니다.");
   	 return true; 
 }
  </script>
</div>
</html>