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
		<div id="registerBtn">
			<c:if test="${user!='anonymousUser'}">
				<button type="button" onclick="location.href='/registerBoardFree';">게시물 작성</button>
			</c:if>
		</div>
		<div id="searchBoardFree">
			<form action="boardFreeViewAll" method="get">
				<select name="select">
					<option value="allFind">전체</option>
					<option value="titleFind">제목</option>
					<option value="contentFind">내용</option>
				</select>
				<input type="text" name="keyword">
				<input type="submit" value="조회" id="searchOk">
			</form>
		</div>
		
		
	<table>
		<thead>
			<tr>
				<td>제목</td>
				<td>내용</td>
				<td>닉네임</td>
				<td>작성일</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="item" varStatus="status">
				<tr>
					<td>${item.freeTitle}</td>
					<td>${item.freeContent}</td>
					<td>${item.user.userNickname}</td>
					<td>
						<fmt:formatDate value="${item.freeWritedate}" pattern="yy-MM-dd HH:mm" />
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<nav id="paging">
		<ul class="pagination">
			<li class="page-item ${paging.prev ? '':'disabled'}">
				<c:choose>
					<c:when
						test="${(paging.startPage == 1)&&(paging.select != null) && (paging.keyword != null)}">
						<a class="page-link"
							href="/boardFreeViewAll?select=${paging.select}&keyword=${paging.keyword}&page=${paging.startPage=1}">Previous</a>
					</c:when>
					<c:when
						test="${(paging.startPage == 1)&&(paging.select == null) && (paging.keyword == null)}">
						<a class="page-link" href="/boardFreeViewAll?page=${paging.startPage=1}">Previous</a>
					</c:when>
					<c:otherwise>
						<a class="page-link" href="/boardFreeViewAll?page=${paging.startPage-1}">Previous</a>
					</c:otherwise>
				</c:choose>
			</li>
			
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
				<li class="page-item">
					<c:choose>
						<c:when test="${(paging.select != null) && (paging.keyword != null)}">
							<a class="page-link ${paging.page== page ? 'active' : ''}"
								href="/boardFreeViewAll?select=${paging.select}&keyword=${paging.keyword}&page=${page}"
								id="page_num">
								${page}
							</a>
						</c:when>
						<c:otherwise>
							<a class="page-link ${paging.page== page ? 'active' : ''}"
								href="/boardFreeViewAll?page=${page}" id="page_num">
								${page}
							</a>
						</c:otherwise>
					</c:choose>
				</li>
			</c:forEach>

			<li class="page-item ${paging.next ? '' : 'disabled'}">
				<c:choose>
					<c:when
						test="${(paging.endPage < 10)&&(paging.select != null) && (paging.keyword != null)}">
						<a class="page-link"
							href="/boardFreeViewAll?select=${paging.select}&keyword=${paging.keyword}&page=${paging.endPage=paging.endPage}">Next</a>
					</c:when>
					<c:when
						test="${(paging.endPage < 10)&&(paging.select == null) && (paging.keyword == null)}">
						<a class="page-link"
							href="/boardFreeViewAll?page=${paging.endPage=paging.endPage}">Next</a>
					</c:when>
					<c:otherwise>
						<a class="page-link" href="/boardFreeViewAll?page=${paging.endPage + 1}">Next</a>
					</c:otherwise>
				</c:choose>
			</li>

		</ul>
	</nav>
</div>
</body>
</html>