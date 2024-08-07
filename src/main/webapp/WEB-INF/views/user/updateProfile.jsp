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
		margin:0 10%;
		
	}
	#content>#container{
		width: 75%;
		height:70%;
	    display: flex;
	    flex-direction: column;
		align-items:center;
	    margin-right: 10%;
	}
	#container>h3{
		font-size:1.7rem;
	}
	#container>form{
		margin-top:20px;
		display: flex;
	    justify-content: center;
	    flex-direction: column;
	}
	.view{
		display:block;
	}
	.notView{
		display:none;
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
		<form action="updateProfile" method="post" enctype="multipart/form-data">
		<input type="hidden" name="userId" value="${user.userId}" >
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
			
			닉네임 <input type="text" name="userNickname" placeholder="${user.userNickname}"><br>
			
			
			<div id="btn">
				<button type="submit">변경 완료</button>
				<button type="button" onclick="location.href='/myPageUser';">변경 취소</button>
			</div>
			
		</form>
	</div>
	<script>
    const userImgUrl = document.querySelector('#userImgUrl');
    const userImg = document.querySelector('.userImg');
    userImg.addEventListener('click', () => userImgUrl.click());
  </script>
</div>
</html>