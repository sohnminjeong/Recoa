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
<link rel="stylesheet" href="../../../resources/css/user/userSideBar.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="sideBar">
		<ul>
			<li><a href="/myPageUser" id="myInfo">내 정보</a></li>
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
					<li><a href="/myGuest" class="subInfo">내 게스트룸 예약</a></li>
					<li><a href="/myGuestCancel" class="subInfo">게스트룸 취소 내역</a></li>
					<li><a href="/myLibrary" class="subInfo">내 독서실 예약</a></li>
					<li><a href="/myLibraryCancel" class="subInfo">독서실 취소 내역</a></li>
					<li><a href="/myBill" class="subInfo">내 고지서 확인</a></li>
				</ul>
			</li>
			<li><i class="fa-solid fa-pen-to-square"></i>
				<ul>
					<li>-------------------</li>
					<li><a href="/writedBoardFree?userCode=${user.userCode}" class="subInfo">작성한 게시물</a></li>
					<li><a href="/liked?userCode=${user.userCode}" class="subInfo">좋아요</a></li>
					<li><a href="/bookmarked" class="subInfo">북마크</a></li>
				</ul>
			</li>
		</ul>
	</div>
</body>
</html>