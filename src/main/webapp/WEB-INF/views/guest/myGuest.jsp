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
<link href="../../resources/css/guest/reserve.css" rel="stylesheet" type="text/css">
<style>
#header {
    position: absolute;
    z-index: 1;
    width: 100%;
    top: 0;
    left: 0;
}

#body{
	position: relative;
	z-index: 0;
}
</style>
</head>
<body>
	<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
	<div id="body">
<h1>내 게스트룸 예약 내역</h1>	

	<table class="table">
		<thead>
			<tr>
				<th>Num</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>룸 타입</th>
				<th>호실 번호</th>
				<th>예약 상태</th>
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
					<td>${item.status}</td>
					
					<td><form action="cancelGuest" method="post">
		                <input type="hidden" name="reserveGuestCode" value="${item.reserve_guest_code}" />
		                <button type="submit">예약 취소</button>
		            </form></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>

</body>
</html>