<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/main/header.css" />
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
</head>
<body>
<sec:authentication property="principal" var="user" />
<ul class="menu">
	<li>
		<a href="/" id="recoa">Recoa</a>
	</li>
	<li>
		<a href="/">아파트 소개</a>
		<ul class="submenu" id="submenu1">
			<li><a href="/">인사말</a></li>
			<li><a href="/">내부시설</a></li>
			<li><a href="/">커뮤니티 시설</a></li>
		</ul>
	</li>
	<li>
		<a href="/">커뮤니티 예약</a>
		<ul class="submenu" id="submenu2">
			<li>
				<c:choose>
					<c:when test="${user=='anonymousUser'}">
						<a href="/loginUser">독서실 예약</a><br>
					</c:when>
					<c:otherwise>
						<a href="/reserveLibrary">독서실 예약</a>
					</c:otherwise>
				</c:choose>
			</li>
			<li>
				<c:choose>
					<c:when test="${user=='anonymousUser'}">
						<a href="/loginUser">게스트하우스 예약</a><br>
					</c:when>
					<c:otherwise>
						<a href="/reserveGuest">게스트하우스 예약</a>
					</c:otherwise>
				</c:choose>
			</li>
		</ul>
	</li>
	<li>
		<a href="/">게시판</a>
		<ul class="submenu" id="submenu3">
			<li><a href="/boardNoticeList">공지 게시판</a></li>
			<li><a href="/viewAllBoardFree">자유 게시판</a></li>
		</ul>
	</li>
	<li>
		<c:choose>
			<c:when test="${user=='anonymousUser'}">
				<a href="/loginUser"><i class="fa-solid fa-user"></i></a>
			</c:when>
			<c:otherwise>
					<a href="/"><i class="fa-solid fa-clipboard-user"></i></a>
					<ul class="submenu" id="submenu4">
						<li>
							<c:choose>
								<c:when test="${user.userAdmin=='admin'}"><a href="/adminPage">마이페이지</a></c:when>
								<c:otherwise><a href="/myPageUser">마이페이지</a></c:otherwise>
							</c:choose>
						</li>
						<li><a href="/logout">로그아웃</a></li>
					</ul>
					
			</c:otherwise>
		</c:choose>
	</li>
</ul>

</body>
</html>