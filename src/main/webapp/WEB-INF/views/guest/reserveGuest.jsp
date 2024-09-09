<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../resources/css/reset.css" />
<title>Insert title here</title>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link href="../../resources/css/guest/reserve.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<style>
#header {
    position: absolute;
    z-index: 1;
    width: 100%;
    top: 0;
    left: 0;
}

#page{
	position: relative;
	z-index: 0;
}

form select option p{
	color: green;
}

</style>
</head>
<body>
	<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
<h1>게스트하우스 예약</h1>
	<div id="page">
		
		<div class="roompicture">
			<img id="roomImg" src="../../resources/images/guest/oneroom.jpg"/>
		</div>
	
		<form action="reserveGuest" method="post" id="reserveGuest" name="reserveGuest">
		<div id="select">
			<p class="selection">기간 선택</p>
			<input type="text" name="daterange" id="daterange"/>
			<input type="hidden" name="startTime" id="startTime"/>
			<input type="hidden" name="endTime" id="endTime"/>
			<input type="hidden" name="userCode" value="${user.userCode}" readonly/>
			
				<p class="selection">객실 타입</p>
				<select name="roomType" id="roomType" disabled>
					<option value="1">원룸</option>
					<option value="2">투룸</option>
				</select>
			
				<p class="selection">객실 번호</p>
		        <select name="roomCode" id="roomCode" disabled>
		        </select>
	            
		</div>
		  <div id="agree">
			  <div id="agreetext">
				  <p>1. 예약 취소의 경우 마이페이지 내 예약 목록에서 취소 부탁드리며 당일 취소는 불가합니다.
				  <p>2. 게스트하우스 체크인 및 체크아웃 시간 안내</p>
				  <p>&nbsp;&nbsp;&nbsp;&nbsp;- 체크인 15:00 ~ 23:00</p>
				  <p>&nbsp;&nbsp;&nbsp;&nbsp;- 체크아웃 11:00</p>
				  <p>3. 게스트하우스는 세대 당 월 1회 이용 가능합니다.</p>
			  </div>
		  	<div id="selection-summary">
			    <h2>예약 내용</h2>
			    <br>
			    <span>날짜: <span id="selected-dates">-</span></span>
			    <div id="room">
			    <span id="selected-roomType"></span>
			    <span>&nbsp;&nbsp;&nbsp;</span>
			    <span id="selected-roomCode"></span>
			    </div>
			</div>
		  <div id="checkbox">
		   	<input type="checkbox" id="agreement" name="agreement" disabled>
            <label for="agreement">예약 내용을 확인하였습니다.</label>
		  </div>
           
        </div>
		
		
		<input type="submit" value="게스트하우스 예약" id="submit" disabled>
	</form>
</div>
	
	
	<script src="../../../resources/js/guest/ReserveGuest.js"></script>

</body>


</html>