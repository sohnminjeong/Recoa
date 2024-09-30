<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../resources/css/reset.css" />
<link href="../../resources/css/utillbill/myBillGuestDesc.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<style>
 
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
				<h3>게스트하우스 이용 내역</h3>	
			<table id="cost">
	        <thead>
        <tr>
        <th>NO</th>
        <th>룸타입</th>
            <th>사용일</th>
            <th>예약일</th>
            <th>가격</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="bill" items="${bills}" varStatus="status">
            <tr>
            <td>${paging.total - (paging.page - 1) * 10 - status.index}</td>
           <c:choose>
					    <c:when test="${bill.roomType eq 'one'}">
					    	<td>원룸</td>
					    </c:when>
					    <c:otherwise>
							 <td>투룸</td>
					    </c:otherwise>
					</c:choose>
                <td>
	               	<fmt:formatDate value="${bill.startTime}" pattern="yy-MM-dd" /> ~ <fmt:formatDate value="${bill.endTime}" pattern="yy-MM-dd" />     
                </td>
               <td>
               		<fmt:formatDate value="${bill.regiDate}" pattern="yy-MM-dd" />
				</td>
                <td>${bill.price}원</td>
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
												href="/myBillGuestDesc?select=${paging.select}&keyword=${paging.keyword}&page=${paging.startPage=1}">Previous</a>
										</c:when>
										<c:when
											test="${(paging.startPage == 1)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link" href="/myBillGuestDesc?page=${paging.startPage=1}"><</a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/myBillGuestDesc?page=${paging.startPage-1}"><</a>
										</c:otherwise>
									</c:choose>

								</li>
								<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
									<li class="page-item">
									
										<c:choose>
											<c:when test="${(paging.select != null) && (paging.keyword != null)}">
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/myBillGuestDesc?select=${paging.select}&keyword=${paging.keyword}&page=${page}"
													id="page_num">
													${page}
												</a>
											</c:when>
											<c:otherwise>
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/myBillGuestDesc?page=${page}" id="page_num">
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
												href="/myBillGuestDesc?select=${paging.select}&keyword=${paging.keyword}&page=${paging.endPage=paging.endPage}">Next</a>
										</c:when>
										<c:when
											test="${(paging.endPage < 10)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link"
												href="/myBillGuestDesc?page=${paging.endPage=paging.endPage}">></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/myBillGuestDesc?page=${paging.endPage + 1}">></a>
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