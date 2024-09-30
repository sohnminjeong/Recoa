<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<link rel="stylesheet" href="../../../resources/css/boardFree/myLike.css" />
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
		<h3>좋아요</h3>
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="item" varStatus="status">
					<tr>
						<td>${paging.total - (paging.page - 1) * 10 - status.index}</td>
						<td><a href="/viewOneBoardFree?freeCode=${item.freeCode}">
					                ${item.freeTitle}
					        </a>
					    </td>
					    <td>
					    	<a href="/viewOneBoardFree?freeCode=${item.freeCode}">
					                ${item.freeContent}
					        </a>
						<td>
							<fmt:formatDate value="${item.freeWritedate}" pattern="yy-MM-dd HH:mm" />
						</td>
						<td>${item.freeView}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<nav id="paging">
			<ul class="pagination">
				<li class="page-item ${paging.prev ? '':'disabled'}">
					<c:choose>
						<c:when
							test="${paging.startPage == 1}">
							<a class="page-link"
								href="/liked?page=${paging.startPage=1}&userCode=${user.userCode}">
								<i class="fa-solid fa-chevron-left"></i>
							</a>
						</c:when>
						<c:otherwise>
							<a class="page-link" href="/liked?page=${paging.startPage-1}&userCode=${user.userCode}">
								<i class="fa-solid fa-chevron-left"></i>
							</a>
						</c:otherwise>
					</c:choose>
				</li>
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
					<li class="page-item">
						<a class="page-link ${paging.page== page ? 'active' : ''}"
							href="/liked?page=${page}&userCode=${user.userCode}" id="page_num">
							${page}
						</a>
					</li>
				</c:forEach>
	
				<li class="page-item ${paging.next ? '' : 'disabled'}">
					<c:choose>
						<c:when
							test="${paging.endPage < 100}">
							<a class="page-link"
								href="/liked?page=${paging.endPage}&userCode=${user.userCode}">
								<i class="fa-solid fa-chevron-right"></i>
							</a>
						</c:when>
						<c:otherwise>
							<a class="page-link" href="/liked?page=${paging.endPage + 1}&userCode=${user.userCode}">
								<i class="fa-solid fa-chevron-right"></i>
							</a>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</nav>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</body>
</html>