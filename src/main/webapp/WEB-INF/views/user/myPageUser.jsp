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
	    justify-content: center;
	    align-items: center;
	    margin-right: 10%;
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
			<div>
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
				<p>아이디 : ${user.userId}</p>
			</div>
			<div>
				<p>이름 : ${user.userRealName}</p>
			</div>
			<div>
				<p>닉네임 : ${user.userNickname}</p>
			</div>
			
			<div>
				<p>핸드폰 번호 : ${user.userPhone}</p>
			</div>
			
			<div>
				<p>거주 동 : ${user.userAdr}</p>
			</div>
			<div>
				<p>거주 호수 : ${user.userAdrDetail}</p>
			</div>
			<div>
				<p>이메일 : ${user.userEmail}</p>
			</div>
		</div>
	</div>	
</body>
</html>