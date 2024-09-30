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
<link rel="stylesheet" href="../../../resources/css/user/updateProfile.css" />
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
					<input type="file" name="file" id="userImgUrl" style="display: none;" accept="image/*" onchange="imgShow(event)">	
			<button type="button" id="delImg">이미지 삭제</button>
			<input type="hidden" value="${user.delUserImgUrl}" name="delUserImgUrl" id="delUserImgUrl" />
			
			</div>
 			<div id="userInfo">
				<p>닉네임</p> 
				<input type="text" name="userNickname" value="${user.userNickname}" placeholder="${user.userNickname}" id="userNickname" ><br>
				<span id="nickNameCheck" style="font-family: 'GangwonEdu_OTFBoldA'"></span>
				<div id="btn">
					<button type="submit">변경 완료</button>
					<button type="button" onclick="location.href='/myPageUser';">변경 취소</button>
				</div>
			</div>
		</form>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script src="../../../resources/js/user/updateProfile.js"></script>
</body>
</html>