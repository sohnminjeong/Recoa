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
<link href="../../resources/css/boardNotice/boardNoticeAll.css" rel="stylesheet" type="text/css">
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>

<div id="content">
	<div id="container">
		<div id="topBar">
			<h3>공지 게시판</h3>
			<div id="searchBar">
				<form action="boardNoticeList" method="get">
					<select name="select">
						<option value="all">전체</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="nickname">닉네임</option>
					</select>
					<input type="text" name="keyword">
					<button type="submit" id="searchOk"><i class="fa-solid fa-magnifying-glass"></i></button>
				</form>
			</div>
		</div>
		
		<div id="regist">
			<c:choose>
				<c:when test="${user!='anonymousUser' && user.userAdmin == 'admin'}">
					<button type="button" onclick="location.href='/registerNotice'">공지 작성</button>
				</c:when>
				<c:otherwise>
					<button type="button" style="visibility: hidden;"></button>
				</c:otherwise>
			</c:choose>
		</div>
			<table>
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성일</td>
						<td>작성자</td>
						<td>조회수</td>
						<td>북마크</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="item" varStatus="status">
						<tr>
							<td>${paging.total - (paging.page - 1) * 10 - status.index}</td>
							
							<td>
							<c:if test="${item.important}">
								<span style="color:red">!</span>
							</c:if>
								<a href="/viewNotice?noticeCode=${item.noticeCode}">
					                ${item.noticeTitle}
					            </a>
							</td>
							
							<td>
								<fmt:formatDate value="${item.noticeWritedate}" pattern="yy-MM-dd HH:mm" />
							</td>
							<td>${item.user.userNickname}</td>
							<td>${item.noticeView}</td>
							<td>${bookmarkCount[item.noticeCode]}</td>
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
												href="/boardNoticeList?select=${paging.select}&keyword=${paging.keyword}&page=${paging.startPage=1}">Previous</a>
										</c:when>
										<c:when
											test="${(paging.startPage == 1)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link" href="/boardNoticeList?page=${paging.startPage=1}"><</a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/boardNoticeList?page=${paging.startPage-1}"><</a>
										</c:otherwise>
									</c:choose>

								</li>
								<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
									<li class="page-item">
									
										<c:choose>
											<c:when test="${(paging.select != null) && (paging.keyword != null)}">
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/boardNoticeList?select=${paging.select}&keyword=${paging.keyword}&page=${page}"
													id="page_num">
													${page}
												</a>
											</c:when>
											<c:otherwise>
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/boardNoticeList?page=${page}" id="page_num">
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
												href="/boardNoticeList?select=${paging.select}&keyword=${paging.keyword}&page=${paging.endPage=paging.endPage}">Next</a>
										</c:when>
										<c:when
											test="${(paging.endPage < 10)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link"
												href="/boardNoticeList?page=${paging.endPage=paging.endPage}">></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/boardNoticeList?page=${paging.endPage + 1}">></a>
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