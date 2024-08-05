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
<link rel="stylesheet" href="../../../resources/css/main/header.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="header">
		<h3>Recoa</h3>
		<div id="menu">
			<div class="menuName">
			<div id="menu1">아파트 소개</div>
				<div id="underBar1">
					<a href="/">인사말</a>
					<a href="/">내부시설</a>
					<a href="/">커뮤니티 시설</a>
				</div>
			</div>
			<div class="menuName">
				<div id="menu2">커뮤니티 예약</div>
				<div id="underBar2">
					<a href="/">독서실</a>
					<a href="/">게스트하우스</a>
				</div>
			</div>
			<div class="menuName">
			<div id="menu3">게시판</div>
				<div id="underBar3">
					<a href="/">자유게시판</a>
					<a href="/">공지게시판</a>
				</div>
			</div>
			<div>
				<c:choose>
					<c:when test="${user=='anonymousUser'}">
						<a href="/loginUser"><i class="fa-solid fa-user"></i></a><br>
					</c:when>
					<c:otherwise>
						<div id="userMenu">
							<a href="/selectUser"><i class="fa-solid fa-clipboard-user"></i></a><br>
							<a href="/logout"><i class="fa-solid fa-circle-xmark"></i></a>	<br>
						</div>
					</c:otherwise>
				</c:choose>		
		</div>
	</div>
	</div>
	<script src="../../../resources/js/main/header.js"></script>
</body>
</html>