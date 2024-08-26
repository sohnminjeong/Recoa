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
                
                $('#selected-roomType').text("");
                $('#selected-roomCode').text("");
                
                // 예약 가능 객실 정보 가져오기
                fetchAvailableRooms(start.format('YYYY-MM-DDTHH:mm:ss'), end.format('YYYY-MM-DDTHH:mm:ss'));

                // 체크박스 상태 해제 및 비활성화
                resetCheckbox();
                // 체크박스 상태 업데이트
                updateCheckboxState();
            });

            $('#roomType').click(function() {
                let start = $('#daterange').data('daterangepicker').startDate;
                let end = $('#daterange').data('daterangepicker').endDate;
             	
                // 객실 타입 선택 시 화면에 표시
                let roomTypeText = $(this).find("option:selected").text();
                $('#selected-roomType').text(roomTypeText);
                $('#selected-roomCode').text("");
                
                if($('#roomType').val() === '1'){
                	document.querySelector("#roomImg").src = "../../resources/images/guest/oneroom.jpg";
                } else if($('#roomType').val() === '2') {
                	document.querySelector("#roomImg").src = "../../resources/images/guest/tworoom.png";
                }
                
                fetchAvailableRooms(start.format('YYYY-MM-DDTHH:mm:ss'), end.format('YYYY-MM-DDTHH:mm:ss'), $(this).val());
                resetCheckbox();
                updateCheckboxState();
            });
            
            $('#roomCode').click(function(){
                // 객실 번호 선택 시 화면에 표시
                
               // let roomTypeText = $('#roomType').find("option:selected").text();
               // $('#selected-roomType').text(roomTypeText);
                
                let roomCodeText = $(this).find("option:selected").text();
                $('#selected-roomCode').text(roomCodeText);
                resetCheckbox();
                updateCheckboxState();
            })
            
            // 체크박스 상태 해제 및 비활성화 함수
		    function resetCheckbox() {
		        $('#agreement').prop('checked', false); // 체크 해제
		        $('#agreement').prop('disabled', true); // 비활성화
		        $('#submit').prop('disabled', true); // 제출 버튼 비활성화
		    }
            
            
            // 예약 정보 확인 후 체크박스 상태 업데이트 함수
	        function updateCheckboxState() {
            	// roomCodeText의 앞뒤 공백 제거
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
   