<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../../../resources/css/admin/adminSideBar.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="sideBar">
	<ul>
		<li><a href="/adminPage" id="myInfo">관리자 정보</a></li>
		<li><i class="fa-solid fa-gear"></i>
			<ul>
				<li>-------------------</li>
				<li><a href="/updateProfile" class="subInfo">프로필 설정</a></li>
				<li><a href="/updateUser" class="subInfo">내정보 설정</a></li>
				<li><a href="/updateUserPwd" class="subInfo">비밀번호 변경</a></li>
				<li><a href="/leaveUser" class="subInfo">회원 탈퇴</a></li>
			</ul>
		</li>
		<li><i class="fa-solid fa-clipboard-check"></i>
			<ul>
				<li>-------------------</li>
				<li><a href="/" class="subInfo">게스트룸 예약 리스트</a></li>
				<li><a href="/" class="subInfo">독서실 예약 리스트</a></li>
				<li><a href="/" class="subInfo">고지서 리스트</a></li>
			</ul>
		</li>
		<li><i class="fa-solid fa-pen-to-square"></i>
			<ul>
				<li>-------------------</li>
				<li><a href="/" class="subInfo">작성한 공지사항</a></li>
				<li><a href="/liked?userCode=${user.userCode}" class="subInfo">좋아요</a></li>
				<li><a href="/bookmarked" class="subInfo">북마크</a></li>
			</ul>
		</li>
	</ul>
</div>
</body>

</html>