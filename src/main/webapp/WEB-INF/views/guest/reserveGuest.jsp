<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>

<body>
	<h1>게스트하우스 예약</h1>
	
	<input type="text" name="daterange" id="daterange"/>
	
	
	
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	
	<script>
	$(document).ready(function() {
		today = new Date();
		
		console.log(today.toISOString().slice(0, 10));
		
		year = today.toISOString().slice(0, 4);
		month = today.toISOString().slice(5, 7);
		date = today.toISOString().slice(8, 10);
		date1 = Number(date) + 1;
		date2 = Number(date) + 2;
		
		startdate = month + "/" + date1 + "/" + year;
		enddate = month + "/" + date2 + "/" + year;
        
        $('#daterange').val(startdate + ' - ' + enddate);
       
        
    });

	$(function() {
		  $('input[name="daterange"]').daterangepicker({
		    opens: 'left',
		    startDate: startdate,
            endDate: enddate,
            minDate: startdate,  
            maxSpan: {
                "days": 2  // 최대 2박 3일 설정
            }
		  },

		  function(start, end, label) {
		    console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
		  });
		});
	</script>
</body>


</html>