<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	width:100%;
}
#content{
	position:relative;
	z-index:0;
	height:100vh;
	padding-top:10vh;
	margin:0 50px;
}
#content #container{
	margin-top : 20px;
}
</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
	<div id="container">
		<h3>자유 게시판</h3>
		<c:choose>
			<c:when test="${user=='anonymousUser'}">
				<span>비회원</span>
			</c:when>
			<c:otherwise>
				<button type="button" onclick="location.href='/registerBoardFree';">게시물 작성</button>
			</c:otherwise>
		</c:choose>
	</div>
	<table>
		<thead>
		</thead>
			<tr>
				<td>제목</td>
				<td>내용</td>
				<td>닉네임</td>
				<td>작성일</td>
			</tr>
		<tbody>
			<c:forEach items="${list}" var="item" varStatus="status">
				<tr>
					<td>${item.freeTitle}</td>
					<td>${item.freeContent}</td>
					<td>${item.userCode}</td>
					<td>
						<fmt:formatDate value="${item.freeWritedate}" pattern="yy-MM-dd HH:mm" />
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	
	
	

</div>
</body>
</html>