<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../../../resources/css/note/noteViewBar.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="sideBar">
	<ul>
		<li><i class="fa-solid fa-envelope"></i>
			<ul>
				<li>-------------------</li>
				<li><a href="/viewAllNote?userCode=${user.userCode}">전체 쪽지함</a></li>
				<li><a href="/viewReceiverNote?userCode=${user.userCode}">받은 쪽지함</a></li>
				<li><a href="/viewSenderNote?userCode=${user.userCode}">보낸 쪽지함</a></li>
			</ul>
		</li>
		<li><i class="fa-solid fa-comments"></i>
			<ul>
				<li>-------------------</li>
				<li><a href="/viewListChat?userCode=${user.userCode}">채팅방 목록</a></li>
			</ul>
		</li>
		<li><i class="fa-solid fa-bell"></i>
			<ul>
				<li>-------------------</li>
				<li><a href="/viewAllAlarm?userCode=${user.userCode}">알림</a></li>
			</ul>
		</li>
	</ul>
</div>
</body>
</html>