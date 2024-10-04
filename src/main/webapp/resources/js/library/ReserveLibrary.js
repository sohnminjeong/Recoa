    let ticketType = 'daily'; // 기본값은 일일권
	
    $(document).ready(function() {
    
    	let today = moment().startOf('day'); 
    	
    	$('#selected-dates').text(today.format('YYYY-MM-DD'));
    	$('#startTime').val(today.format('YYYY-MM-DD'));
    	$('#endTime').val(today.format('YYYY-MM-DD'));
    	
    	 $('#selected-seatCode').css("display", "none");
    	 $('#submit').prop('disabled', true);
    	
        // 1. 초기 daterangepicker 설정==================================================
        $('#daterange').daterangepicker({
        	drops: 'down',
        	startDate: today,
			minDate: today,
        	singleDatePicker: true, // 한 날짜만 선택 가능
            locale: {
                format: 'YYYY-MM-DD', // 날짜 형식
            }
        }, function(start, end, libraryCode) {
            $('#startTime').val(start.format('YYYY-MM-DD'));

            if (ticketType === 'monthly') {
                let endDate = moment(start).add(30, 'days');
                $('#endTime').val(endDate.format('YYYY-MM-DD')); 
                
                // 종료일 출력
                $('#endDate').text(endDate.format('YYYY-MM-DD'));
                $('#endDateText').show(); 
                end = endDate;
                
            } else {
                $('#endTime').val(start.format('YYYY-MM-DD')); 
                $('#endDateText').hide();
            }
            
            // 확인 내역에 텍스트 출력
            $('#selected-dates').text(start.format('YYYY/MM/DD') + '-' + end.format('YYYY/MM/DD'));
            
            // 시작일 선택 시 호점 선택 가능하도록 
            $('#libraryCode').prop('disabled', false);
            
            $('#selected-libraryCode').text("");
            $('#selected-seatCode').text("");
            
            // 예약 가능 좌석 정보 가져오기
            fetchAvailableSeats(start.format('YYYY-MM-DD'), end.format('YYYY-MM-DD'), $('#libraryCode').val());
            
         // + 체크박스 리셋 함수
            resetCheckbox();
            // + 체크박스 상태 업데이트 함수
            updateCheckboxState();
        });

	       $('#daterange').on('apply.daterangepicker', function(ev, picker) {
	         $('#startTime').val(picker.startDate.format('YYYY-MM-DD') + ' - ' + picker.endDate.format('YYYY-MM-DD'));
	      });

        // 9. 예약 가능 좌석 확인하기====================================================
        function fetchAvailableSeats(startTime, endTime, libraryCode) {
	    	$.ajax({
	    		url: '/availableSeats',
	    		type: 'GET',
	    		data: {
	    			startTime: startTime,
	    			endTime: endTime,
	    			libraryCode: libraryCode
	    		},
	    		success: function(data){
	    			updateSeatOptions(data);
	    		},
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("AJAX Error: " + textStatus + ": " + errorThrown);
                }
	    	});
	    }
        
// 10. 좌석 출력하기
function updateSeatOptions(seats) {
    const seatGrid = document.querySelector('#seat-grid');
    seatGrid.innerHTML = ''; // 그리드 초기화

    const totalSeats = 20; // 좌석 총 개수
	const reservedSeats = seats.map(seat => seat.seat_code);
	
    for (let i = 1; i <= totalSeats; i++) {
        const seat = document.createElement('div');
        seat.classList.add('seat');
        
        // 좌석 번호 표시
        const seatNumber = document.createElement('span');
        seatNumber.textContent = i;
        seat.appendChild(seatNumber);

        // 예약된 좌석인 경우
        if (reservedSeats.includes(i)) {
            seat.classList.add('reserved');
            seat.style.backgroundColor = 'red'; // 붉은 색으로 표시
        } else {
            // 예약되지 않은 좌석에 대한 클릭 이벤트
            seat.addEventListener('click', function() {
                selectSeat(i);
            });
        }

        // 그리드에 좌석 추가
        seatGrid.appendChild(seat);
    }
}

// 1. 좌석 선택 시 처리 함수
	    function selectSeat(seatCodeText) {
	        alert(seatCodeText + '번 좌석을 선택하셨습니다');
	        $('#selected-seatCode').css("display", "");
	        $('#selected-seatCode').text(seatCodeText + "번 좌석");
	        
	        $('#seatCode').val(seatCodeText);
	        
	        $('.seat').removeClass('selected');
	        $('.seat').eq(seatCodeText -1).addClass('selected');
            // + 체크박스 리셋 함수
            resetCheckbox();
            // + 체크박스 상태 업데이트 함수
            updateCheckboxState();
	    
   	 }
        // 2. 티켓 타입 변경 =========================================================
        document.querySelectorAll('input[name="ticket"]').forEach((radio) => {
            radio.addEventListener('change', function () {
                ticketType = this.value; 
                updateDateDisplay(); 
         	});
        });

        // 3. 호점 선택 시  =========================================================
        $('#libraryCode').click(function() {
        	  let start = $('#daterange').data('daterangepicker').startDate;
              let end = $('#daterange').data('daterangepicker').endDate;
              
              if (ticketType === 'monthly') {
                let endDate = moment(start).add(30, 'days');
                $('#endTime').val(endDate.format('YYYY-MM-DD')); 
                
                end = endDate;
            } else {
                $('#endTime').val(start.format('YYYY-MM-DD')); 
                end = start;
            }
              
              // 호점 선택 시 화면에 표시
              let libraryCodeText = $(this).find("option:selected").text();
              $('#selected-libraryCode').text(libraryCodeText);
              $('#selected-seatCode').text("");
              
              fetchAvailableSeats(start.format('YYYY-MM-DD'), end.format('YYYY-MM-DD'), $(this).val());
			
              // + 체크박스 리셋 함수
              resetCheckbox();
              // + 체크박스 상태 업데이트 함수
              updateCheckboxState();
        });
        
        // 5. 체크박스 리셋 함수  =========================================================
        function resetCheckbox(){
        	$('#agreement').prop('checked', false); // 체크 해제
	        $('#agreement').prop('disabled', true); // 비활성화
	        $('#submit').prop('disabled', true); // 제출 버튼 비활성화
        }
        
        // 6. 체크박스 상태 업데이트 함수 =================================================
	        function updateCheckboxState() {
	            const seatCodeText = $('#selected-seatCode').text().trim();
	            
	            if (seatCodeText) {
	                $('#agreement').prop('disabled', false); 
	            } else {
	                $('#agreement').prop('disabled', true);
	            }
	        }
        
        // 7. 체크박스 상태에 따른 제출 버튼 활성화 함수  =================================
            $('#agreement').change(function() {
                if ($(this).is(':checked')) {
                    $('#submit').prop('disabled', false);
                } else {
                    $('#submit').prop('disabled', true);
                }
            });
        
        // 8. 제출  =========================================================
             $('#reserveGuest').submit(function() {
                let daterange = $('#daterange').val();
                let dates = daterange.split(' - ');
                $('#startTime').val(moment(dates[0], 'YYYY/MM/DD').format('YYYY-MM-DDTHH:mm:ss'));
                $('#endTime').val(moment(dates[1], 'YYYY/MM/DD').format('YYYY-MM-DDTHH:mm:ss'));
            });

        // 10. 날짜 변경 시  ====================================================
	    function updateDateDisplay() {
	        let startDate = $('#startTime').val();
	        let endDate = $('#endTime').val();
	        
	        if (ticketType === 'monthly' && startDate) {
	            let newEndDate = moment(startDate).add(30, 'days').format('YYYY-MM-DD');
	            $('#endTime').val(newEndDate);
	            $('#endDate').text(newEndDate);
	            $('#endDateText').show(); 
	        } else {
	            $('#endDateText').hide();
	        }
	    }
        
	    fetchAvailableSeats(today.format('YYYY-MM-DD'), 1);
        // document.ready 닫기
    });
        
        