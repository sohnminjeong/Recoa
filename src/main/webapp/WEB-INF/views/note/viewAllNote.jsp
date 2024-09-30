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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../../../resources/css/note/viewAllNote.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
	<div id="noteViewBar">
		<%@ include file="../note/noteViewBar.jsp" %>
	</div>
	<div id="container">
		<h3>내 쪽지함 _ 전체 쪽지함</h3>
		<div id="containerContent">
			
			<table>
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>보낸 사람</td>
						<td>받은 사람</td>
						<td>작성일</td>
						<td>첨부 파일</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="item" varStatus="status">
						<tr>
							<td>${paging.total-(paging.page-1)*10-status.index}</td>
							<td><a href="/viewOneNote?noteCode=${item.noteCode}">${item.noteTitle}</a></td>
							<td>${item.senderNick}</td>
							<td>${item.receiverNick}</td>
							<td>
								<fmt:formatDate value="${item.noteWritedate}" pattern="yy-MM-dd HH:mm" />
							</td>
							<td>
								<c:if test="${item.hasNote!=false}">
									<i class="fa-solid fa-file-lines"></i>
								</c:if>
							</td>
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
									href="/viewAllNote?page=${paging.startPage=1}&userCode=${user.userCode}">
									<i class="fa-solid fa-chevron-left"></i>
								</a>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="/viewAllNote?page=${paging.startPage-1}&userCode=${user.userCode}">
									<i class="fa-solid fa-chevron-left"></i>
								</a>
							</c:otherwise>
						</c:choose>
					</li>
					<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
						<li class="page-item">
							<a class="page-link ${paging.page== page ? 'active' : ''}"
								href="/viewAllNote?page=${page}&userCode=${user.userCode}" id="page_num">
								${page}
							</a>
						</li>
					</c:forEach>
		
					<li class="page-item ${paging.next ? '' : 'disabled'}">
						<c:choose>
							<c:when
								test="${paging.endPage < 100}">
								<a class="page-link"
									href="/viewAllNote?page=${paging.endPage}&userCode=${user.userCode}">
									<i class="fa-solid fa-chevron-right"></i>
								</a>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="/viewAllNote?page=${paging.endPage + 1}&userCode=${user.userCode}">
									<i class="fa-solid fa-chevron-right"></i>
								</a>
							</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</body>
</html>