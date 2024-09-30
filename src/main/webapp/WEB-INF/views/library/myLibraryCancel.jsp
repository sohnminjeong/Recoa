<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../resources/css/reset.css" />
<title>Insert title here</title>
<link href="../../resources/css/library/list.css" rel="stylesheet" type="text/css">
</head>
<body>
	<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
	<div id="content">
		<div id="userSideBar">
		<%@ include file="../user/userSideBar.jsp" %>
		</div>
	<div id="container">
<h3>예약 취소 내역</h3>	

	<table class="table">
		<thead>
			<tr>
				<th>예약 번호</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>호점</th>
				<th>좌석 번호</th>
				<th>예약 상태</th>
			
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="item" varStatus="status">
				<tr>
					<td>${paging.total - (paging.page - 1) * 10 - status.index}</td>
					<td><fmt:formatDate value="${item.start_time}" pattern="yy-MM-dd" /></td>
					<td><fmt:formatDate value="${item.end_time}" pattern="yy-MM-dd" /></td>
					<td>${item.library_code}호점</td>
					<td>${item.room_code}호실</td>
					<td>예약 취소됨</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		<nav id="paging">
							<ul class="pagination">
								<li class="page-item ${paging.prev ? '' : 'disabled'}">

									<c:choose>
										<c:when
											test="${(paging.startPage == 1)&&(paging.select != null) && (paging.keyword != null)}">
											<a class="page-link"
												href="/myLibraryCancel?select=${paging.select}&keyword=${paging.keyword}&page=${paging.startPage=1}">Previous</a>
										</c:when>
										<c:when
											test="${(paging.startPage == 1)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link" href="/myLibraryCancel?page=${paging.startPage=1}"><</a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/myLibraryCancel?page=${paging.startPage-1}"><</a>
										</c:otherwise>
									</c:choose>

								</li>

								<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
									<li class="page-item">
										<c:choose>
											<c:when test="${(paging.select != null) && (paging.keyword != null)}">
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/myLibraryCancel?select=${paging.select}&keyword=${paging.keyword}&page=${page}"
													id="page_num">
													${page}
												</a>
											</c:when>
											<c:otherwise>
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/myLibraryCancel?page=${page}" id="page_num">
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
												href="/myLibraryCancel?select=${paging.select}&keyword=${paging.keyword}&page=${paging.endPage=paging.endPage}">Next</a>
										</c:when>
										<c:when
											test="${(paging.endPage < 10)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link"
												href="/myLibraryCancel?page=${paging.endPage=paging.endPage}">></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/myLibraryCancel?page=${paging.endPage + 1}">></a>
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