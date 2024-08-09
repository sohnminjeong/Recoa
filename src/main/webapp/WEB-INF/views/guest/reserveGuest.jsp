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
    top: 0;
    left: 0;
}

#page{
	position: relative;
	z-index: 0;
	height: 100vh;
	padding-top: 10vh;
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
	<div id="page">
		<h1>게스트하우스 예약</h1>
		<div class="roompicture">
			<img src="../../resources/images/guest/oneroom.jpg"/>
		</div>
	
		<form action="reserveGuest" method="post" id="reserveGuest" name="reserveGuest">
		<div>
			<p>기간 선택</p>
			<input type="text" name="daterange" id="daterange"/>
			<input type="hidden" name="startTime" id="startTime"/>
			<input type="hidden" name="endTime" id="endTime"/>
		</div>
		<div>
			<input type="hidden" name="userCode" value="${user.userCode}" readonly/>
		
			<p>객실 타입</p>
			<select name="roomType" id="roomType">
				<option value="1">원룸</option>
				<option value="2">투룸</option>
			</select>
		
			<p>객실 번호</p>
            <select name="roomCode" id="roomCode">
            <!-- AJAX -->
            </select>
		</div>
		<hr/>
		
		
		<input type="submit" value="게스트하우스 예약" id="submit">
	</form>
</div>
	
	
	<script>
		$(document).ready(function() {
			
            let today = moment().startOf('day'); // 오늘 날짜의 시작
            let tomorrow = moment(today).add(1, 'days'); // 내일 날짜

         // ajax를 통해 동적으로 예약 가능한 객실 정보를 가져옴
            function fetchAvailableRooms(startTime, endTime, roomType) {
                $.ajax({
                    url: '/availableRooms',
                    type: 'GET',
                    data: {
                        startTime: startTime,
                        endTime: endTime,
                        roomType: roomType
                    },
                    success: function(data) {
                    	console.log(data);
                        updateRoomOptions(data);
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error("AJAX Error: " + textStatus + ": " + errorThrown);
                    }
                });
            }
            
            // 가져온 정보들을 바탕으로 select option를 출력
            function updateRoomOptions(rooms) {
			    let roomSelect = $('#roomCode');
			    roomSelect.empty(); // 기존 옵션을 제거합니다.
			    for (let i = 1; i <= 7; i++) { // 예시로 1호실부터 7호실까지
			    	let isReserved = rooms.some(room => room.room_code == i);
			        let optionText = i + "호실";
		            if (isReserved) {
		                optionText += " (예약 마감)";
		                roomSelect.append('<option value="' + i + '" disabled>' + optionText + '</option>');
		            } else {
		                roomSelect.append('<option value="' + i + '">' + optionText + '</option>');
		            }
			    }
			}
            
            // daterangepicker
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
                fetchAvailableRooms(start.format('YYYY-MM-DDTHH:mm:ss'), end.format('YYYY-MM-DDTHH:mm:ss'));
            });

            $('#roomType').change(function() {
                let start = $('#daterange').data('daterangepicker').startDate;
                let end = $('#daterange').data('daterangepicker').endDate;
                fetchAvailableRooms(start.format('YYYY-MM-DDTHH:mm:ss'), end.format('YYYY-MM-DDTHH:mm:ss'), $(this).val());
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