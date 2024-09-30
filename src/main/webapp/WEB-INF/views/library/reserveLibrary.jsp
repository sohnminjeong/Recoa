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
<link href="../../resources/css/library/reserveLibrary.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>
<body>
	<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
	<div id="content">
		<h1>독서실 예약</h1>
		
		<form action="reserveLibrary" method="post" id="reserveLibrary" name="reserveLibrary">

	    <div id="seat">
	        <h2>좌석 선택</h2>
	        	<div id="seat-grid">
	        		<!-- 좌석선택 -->
	        	</div>
	        	<input type="hidden" name="seatCode" id="seatCode" value="seatCode"/>
	    </div>
	    
	    <!-- 선택 -->
	    <div id="select">
			<div id="ticket">
	        	<h2>권종 선택</h2>
	        	<div>
			        <label>
			            <input type="radio" name="ticket" value="daily" checked> 일일권
			        </label>
			        <label>
			            <input type="radio" name="ticket" value="monthly"> 월 정기권
			        </label>
		        </div>
	   		 </div>
	
		    <div id="date">
		        <h2>시작일 선택</h2>
		        <input type="text" name="daterange" id="daterange"/>
		        <input type="hidden" id="startTime" name="startTime">
				<input type="hidden" name="endTime" id="endTime"/>
				<input type="hidden" name="userCode" value="${user.userCode}" readonly/>
		        <p id="endDateText" style="display:none;">월 정기권 종료일: <span id="endDate"></span></p>
		    </div>
	
		    <div id="branch">
		        <h2>호점 선택</h2>
		        <select name="libraryCode" id="libraryCode">
		            <option value="1">1호점</option>
		            <option value="2">2호점</option>
		            <option value="3">3호점</option>
		        </select>
		    </div>
		    
		    <!-- 동의 문구 -->
		    <div id="agree">
			  <div id="agreetext">
				  <p>1. 예약 취소의 경우 마이페이지 내 예약 목록에서 취소 부탁드리며 당일 취소는 불가합니다.</p>
				  <p> 독서실 운영 시간 09:00 ~ 23:00</p>
			  </div>
		  	<div id="selection-summary">
			    <h2>예약 내용</h2>
			    <br>
			    <span>날짜: <span id="selected-dates">-</span></span>
			    <div id="lib">
				    <span id="selected-libraryCode"></span>
				    <span>&nbsp;&nbsp;&nbsp;</span>
				    <span id="selected-seatCode"></span>
			    </div>
			</div>
		  <div id="checkbox">
		   	<input type="checkbox" id="agreement" name="agreement" disabled>
            <label for="agreement">예약 내용을 확인하였습니다.</label>
		  </div>
           
        </div>
		
		    <input type="submit" value="독서실 예약" id="submit"/>
		</div>
	</form>

	</div>
	<script src="../../../resources/js/library/ReserveLibrary.js"></script>
</body>
</html>