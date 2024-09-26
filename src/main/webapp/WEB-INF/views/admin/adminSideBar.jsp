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
<style>
@font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
#sideBar{
	border-radius : 30px;
	width:100%;
	height:100%;
	background-color : #e1f1fa;
}
#sideBar>ul{
	display: flex;
    flex-direction: column;
    align-items: center;
    height: 100%;
    padding-top: 20px;
    padding-bottom: 30px;
}
#sideBar a{
	font-family: 'GangwonEdu_OTFBoldA';
}
#myInfo{
	font-size : 1.4rem;
}
.subInfo{
	font-size : 1.1rem;
}
#sideBar>ul>li:nth-child(1){
	height:10%;
}
#sideBar>ul>li:nth-child(2){
	height:33%;
}
#sideBar>ul>li:nth-child(3){
	height:35%;
}
#sideBar>ul>li:nth-child(4){
	height:20%;
}

#sideBar ul li a:hover{
	color : gray;
}
</style>
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