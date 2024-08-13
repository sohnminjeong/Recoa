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
	
	
	<script>
		$(document).ready(function() {
			
            let today = moment().startOf('day'); // 오늘 날짜의 시작
            let tomorrow = moment(today).add(1, 'days'); // 내일 날짜
            
            // daterangepicker 초기화
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
                
             // 날짜 선택 시 화면에 표시
                $('#selected-dates').text(start.format('YYYY/MM/DD') + ' - ' + end.format('YYYY/MM/DD'));
             	
                $('#roomType').prop('disabled', false);
                $('#roomCode').prop('disabled', false);
                fetchAvailableRooms(start.format('YYYY-MM-DDTHH:mm:ss'), end.format('YYYY-MM-DDTHH:mm:ss'));
                
                
                $('#selected-roomType').text("");
                $('#selected-roomCode').text("");
                updateCheckboxState();
            });

            $('#roomType').change(function() {
                let start = $('#daterange').data('daterangepicker').startDate;
                let end = $('#daterange').data('daterangepicker').endDate;
             	
                // 객실 타입 선택 시 화면에 표시
                let roomTypeText = $(this).find("option:selected").text();
                $('#selected-roomType').text(roomTypeText);
                $('#selected-roomCode').text("");
                
                fetchAvailableRooms(start.format('YYYY-MM-DDTHH:mm:ss'), end.format('YYYY-MM-DDTHH:mm:ss'), $(this).val());
                
                if($('#roomType').val() === '1'){
                	document.querySelector("#roomImg").src = "../../resources/images/guest/oneroom.jpg";
                } else if($('#roomType').val() === '2') {
                	document.querySelector("#roomImg").src = "../../resources/images/guest/tworoom.png";
                }
                
            });
            
            $('#roomCode').change(function(){
                // 객실 번호 선택 시 화면에 표시
                
                let roomTypeText = $('#roomType').find("option:selected").text();
                $('#selected-roomType').text(roomTypeText);
                
                let roomCodeText = $(this).find("option:selected").text();
                $('#selected-roomCode').text(roomCodeText);
                updateCheckboxState();
            })
            
            // 예약 정보 확인 후 체크박스 상태 업데이트 함수
	        function updateCheckboxState() {
	            const roomCodeText = $('#selected-roomCode').text().trim();
	            
	            if (roomCodeText) {
	                $('#agreement').prop('disabled', false); // 모든 필드가 입력되면 체크박스 활성화
	            } else {
	                $('#agreement').prop('disabled', true); // 하나라도 비어있으면 체크박스 비활성화
	            }
	        }
            
            // 체크박스 상태에 따라 제출 버튼 활성화/비활성화
            $('#agreement').change(function() {
                if ($(this).is(':checked')) {
                    $('#submit').prop('disabled', false);
                } else {
                    $('#submit').prop('disabled', true);
                }
            });
            
            $('#reserveGuest').submit(function() {
                let daterange = $('#daterange').val();
                let dates = daterange.split(' - ');
                $('#startTime').val(moment(dates[0], 'YYYY/MM/DD').format('YYYY-MM-DDTHH:mm:ss'));
                $('#endTime').val(moment(dates[1], 'YYYY/MM/DD').format('YYYY-MM-DDTHH:mm:ss'));
            });
            
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
            
        });
   

	</script>
</body>


</html>