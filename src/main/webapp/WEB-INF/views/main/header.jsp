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
<header id="header">
	<nav id="nav1"><a href="/">Recoa</a></nav>
	
	<nav id="nav2">
		<div class="menu">
			<p id="menu1">아파트 소개</p>
			<div id="underBar1" class="hide">
				<a href="/">인사말</a>
				<a href="/">내부시설</a>
				<a href="/">커뮤니티 시설</a>
			</div>
		</div>
		<div class="menu">
			<p id="menu2">커뮤니티 예약</p>
			<div id="underBar2" class="hide">
				<a href="/">독서실</a>
				<a href="/">게스트하우스</a>
			</div>
		</div>	
		<div class="menu">	
			<p id="menu3">게시판</p>
			<div id="underBar3" class="hide">
				<a href="/">자유게시판</a>
				<a href="/">공지게시판</a>
			</div>
		</div>
		<div class="menu">
			<c:choose>
				<c:when test="${user=='anonymousUser'}">
					<a href="/loginUser"><i class="fa-solid fa-user"></i></a>
				</c:when>
				<c:otherwise>
					<div id="userMenu">
						<a href="/selectUser"><i class="fa-solid fa-clipboard-user"></i></a>
						<a href="/logout"><i class="fa-solid fa-circle-xmark"></i></a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
</header>
	
<script src="../../resources/js/main/header.js"></script>
</body>
</html>