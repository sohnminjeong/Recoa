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
	#container>#containerContent{
		width:90%;
		border : 2px solid black;
		border-radius : 30px;
		height:100%;
		display: grid;
    	grid-template-columns: 2fr 3fr;
	}
	#containerContent>#img{
	    display: flex;
	    justify-content:center;
	    padding: 50px;
	    align-items: center;
	}
	#containerContent>#img>img{
		border-radius: 50%;
	    width: 200px;
	    height: 200px;
	    border:1px solid black;
	}
	#containerContent>#userInfo{
		width:100%;
		padding:50px;
		display:flex;
		flex-direction:column;
		justify-content:space-around;
	}
	#userInfo>p{
		font-size : 1.3rem;
		font-family: 'GangwonEdu_OTFBoldA';
	}
</style>
</head>
<body>
<!--  <sec:authentication property="principal" var="user" /> -->


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
</body>
</html>