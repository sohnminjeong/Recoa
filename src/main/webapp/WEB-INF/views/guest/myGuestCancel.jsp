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
<link href="../../resources/css/guest/list.css" rel="stylesheet" type="text/css">
<style>
#header {
    position: absolute;
    z-index: 1;
    width: 100%;
    top: 0;
    left: 0;
}
#content{
	position:relative;
	z-index:0;
	height:100vh;
	padding-top:10vh;
	display:flex;
	align-items:center;
	margin:0 50px;
}
	
#content>#userSideBar{
	height:80%;
	width:15%;
	margin-left : 10%;
	margin-right:5%;
}

#content>#container{
	width: 75%;
	height:80%;
    display: flex;
    flex-direction: column;
    margin-right: 10%;
}

#container>h3{
	font-size : 1.7rem;
	font-weight:bold;
	margin : 20px;
	font-family: 'GangwonEdu_OTFBoldA';
}

</style>
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
				<th>룸 타입</th>
				<th>호실 번호</th>
				<th>예약 상태</th>
				<th>예약 취소</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="item" varStatus="status">
				<tr>
					<td>${item.reserve_guest_code}</td>
					<td><fmt:formatDate value="${item.start_time}" pattern="yy-MM-dd" /></td>
					<td><fmt:formatDate value="${item.end_time}" pattern="yy-MM-dd" /></td>
					<td>${item.room_type}</td>
					<td>${item.room_code}</td>
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
												href="/myGuestCancel?select=${paging.select}&keyword=${paging.keyword}&page=${paging.startPage=1}">Previous</a>
										</c:when>
										<c:when
											test="${(paging.startPage == 1)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link" href="/myGuestCancel?page=${paging.startPage=1}">Previous</a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/myGuestCancel?page=${paging.startPage-1}">Previous</a>
										</c:otherwise>
									</c:choose>

								</li>

								<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
									<li class="page-item">
										<c:choose>
											<c:when test="${(paging.select != null) && (paging.keyword != null)}">
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/myGuestCancel?select=${paging.select}&keyword=${paging.keyword}&page=${page}"
													id="page_num">
													${page}
												</a>
											</c:when>
											<c:otherwise>
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/myGuestCancel?page=${page}" id="page_num">
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
												href="/myGuestCancel?select=${paging.select}&keyword=${paging.keyword}&page=${paging.endPage=paging.endPage}">Next</a>
										</c:when>
										<c:when
											test="${(paging.endPage < 10)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link"
												href="/myGuestCancel?page=${paging.endPage=paging.endPage}">Next</a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/myGuestCancel?page=${paging.endPage + 1}">Next</a>
										</c:otherwise>
									</c:choose>
								</li>
							</ul>
						</nav>
	</div>
</div>
</body>
</html>