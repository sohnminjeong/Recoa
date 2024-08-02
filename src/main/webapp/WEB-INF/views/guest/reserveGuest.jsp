<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>

<body>
	<sec:authentication property="principal" var="user" />
	<h1>게스트하우스 예약</h1>
	
	<form action="reserveGuest" method="post" id="reserveGuest" name="reserveGuest">
	<div>
		<p>기간 선택</p>
		<input type="text" name="daterange" id="daterange"/>
		<input type="hidden" name="startTime" id="startTime"/>
		<input type="hidden" name="endTime" id="endTime"/>
	</div>
		<div>
		<p>유저 코드</p>
		<input type="text" name="userCode" value="${user.userCode}" readonly/>
		
		<p>객실 타입</p>
		<select name="roomType">
			<option value="1">원룸</option>
			<option value="2">투룸</option>
		</select>
		
		<p>객실 번호</p>
			<select name="roomCode">
                <option value="1">1호실</option>
                <option value="2">2호실</option>
                <option value="3">3호실</option>
                <option value="4">4호실</option>
                <option value="5">5호실</option>
                <option value="6">6호실</option>
                <option value="7">7호실</option>
            </select>
		</div>
		<hr/>
		<input type="submit" value="게스트하우스 예약" id="submit">
	</form>

	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	
	<script>
		$(document).ready(function() {
			
            let today = moment().startOf('day'); // 오늘 날짜의 시작
            let tomorrow = moment(today).add(1, 'days'); // 내일 날짜

            $('#daterange').daterangepicker({
                opens: 'left',
                startDate: tomorrow,
                endDate: moment(tomorrow).add(2, 'days'),
                minDate: tomorrow,  // 오늘 날짜 이전은 선택 불가
                maxSpan: {
                    "days": 2  // 최대 2박 3일 설정
                },
                locale: {
                    format: 'YYYY/MM/DD'
                }
            }, function(start, end, label) {
                $('#startTime').val(start.format('YYYY-MM-DDTHH:mm:ss'));
                $('#endTime').val(end.format('YYYY-MM-DDTHH:mm:ss'));
               
            });

            $('#reserveGuest').submit(function() {
                let daterange = $('#daterange').val();
                let dates = daterange.split(' - ');
                $('#startTime').val(moment(dates[0], 'YYYY/MM/DD').format('YYYY-MM-DDTHH:mm:ss'));
                $('#endTime').val(moment(dates[1], 'YYYY/MM/DD').format('YYYY-MM-DDTHH:mm:ss'));
            });
            

        });
   

	</script>
</body>


</html>