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
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<style>
@font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'Ownglyph_jiwoosonang';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2408@1.0/Ownglyph_jiwoosonang.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

#header {
    position: absolute;
    z-index: 1;
    width: 100%;
    top: 0;
    left: 0;
}

#content{
	margin-top: 10vh;
	position: relative;
	z-index: 0;
}

h1{
	font-size: 2rem;
	font-family: 'Ownglyph_jiwoosonang';
	font-weight: bolder;
	padding: 30px;
}

form{
	font-family: 'GangwonEdu_OTFBoldA';
	display: flex;
	padding-top: 20px;
	flex-direction: row;
	height: 400px;
}

form input {
	font-family: 'GangwonEdu_OTFBoldA';
	padding-left: 10px;
}

form select {
	font-family: 'Ownglyph_jiwoosonang';
	margin: 10px;
}

form select option{
	font-size: 15px;
}

#seat {
    width: 500px;
    padding-top: 20px;
    margin-left: 200px;
    margin-right: 100px;
    h2{
		margin-bottom: 15px;
	}
}

#seat-grid {
    border: 1px solid lightgray;
    border-radius: 10px;
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    grid-gap: 10px;
    padding: 10px;
}

.seat {
    width: 50px;
    height: 50px;
    background-color: lightgray;
    text-align: center;
    line-height: 50px;
    cursor: pointer;
    border-radius: 5px;
}

.seat.selected {
    background-color: skyblue;
}

.seat.reserved {
    background-color: red;
    cursor: not-allowed;
}

#select {
	display: flex;
	flex-direction: column;
	div{
		margin-bottom: 10px;
	}
}

#ticket{
	display: flex;
	flex-direction: row;
	div{
		margin-left: 10px;
		margin-bottom: 5px;
	}
}

#date{
	display: flex;
	flex-direction: row;
	input{
		margin-left: 10px;
	}
	p{
		margin-left: 10px;
	}
}

#branch{
	display: flex;
	flex-direction: row;
	select{
		margin-left: 10px;
	}
}

#selection-summary{
	margin: 10px;
	margin-top: 30px;
	padding-top: 15px;
	align-items: center;
	display: flex;
	flex-direction: column;
	justify-content: center;
	background-color: rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

#checkbox{
	display: flex;
	flex-direction: row;
	margin-top: 20px;
}

#checkbox label {
    display: block; 
    margin-top: 10px; 
}

#submit{
	padding: 10px;
	padding-top: 15px;
}

.daterangepicker {
   	z-index: 10;
   	position: absolute;
}
</style>
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