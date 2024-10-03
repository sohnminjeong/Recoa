<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../resources/css/reset.css" />
<link href="../../resources/css/utillbill/viewUserBill.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
	<div id="content">
			<div id="userSideBar">
		<%@ include file="../admin/adminSideBar.jsp" %>
		</div>
		<div id="container">
		<h1><span id="userId"></span> 고지서</h1>
					<div id="input">
						<input type="text" name="id" id="id" placeholder="아이디">
						<i class="fa-solid fa-magnifying-glass" id="search"></i>
					</div>
<table id="table">
    <tr>
        <td class="info-label">아파트</td>
        <td>블루포레스트시티</td>
        <td class="info-label">이름</td>
        <td id="userRealName"></td>
    </tr>
    <tr>
        <td class="info-label">주소</td>
        <td id="userAdr"></td>
        <td class="info-label">결제일</td>
        <td>2024-10-25</td>
    </tr>
</table>

<h2>예약 요금 내역</h2>
<table id="cost">
    <thead>
        <tr>
            <th>서비스명</th>
            <th></th>
            <th>이용 요금</th>
            <th>총 요금</th>
            <th>상세보기</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>독서실</td>
            <td></td>
            <td id="libraryPrice"></td>
            <td id="libraryPriceTotal"></td>
        </tr>
        <tr>
            <td>게스트하우스</td>
            <td id="guestOneDesc">원룸</td>
            <td id="guestOnePrice"></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td id="guestTwoDesc">투룸</td>
            <td id="guestTwoPrice"></td>
            <td id="guestPriceTotal"></td>
        </tr>
    </tbody>
</table>

<div class="summary">
    총 예약 요금: <span id="totalPrice"></span>
</div>
</div>
	</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script>
$(document).ready(function() {
    $("#search").click(function() {
        const userId = $('#id').val();
        $.ajax({
            type: "post",
            url: "/viewUserBill",
            data: { "id": userId },
            success: function(data) {
            		var userAdr = data.user.userAdr + '동 ' + data.user.userAdrDetail + '호';
                	var libraryPrice = data.libraryPrice + '원';
                	var libraryPriceTotal = data.libraryPrice + '원';
                	
                	var guestOnePrice = data.guestOnePrice + '원';
                	var guestTwoPrice = data.guestTwoPrice + '원';
                	var guestPriceTotal = data.guestPrice + '원';
                	
                	var totalPrice = data.totalPrice + '원';
                	
                    $('#userId').text(data.user.userRealName);
                    $('#userRealName').text(data.user.userRealName);
                    $('#userAdr').text(userAdr);
                    
                    $('#libraryPrice').text(libraryPrice);
                    $('#libraryPriceTotal').text(libraryPriceTotal);
                    
                    $('#guestOnePrice').text(guestOnePrice);
                    $('#guestTwoPrice').text(guestTwoPrice);
                    $('#guestPriceTotal').text(guestPriceTotal);
                    
                    $('#totalPrice').text(totalPrice);
            	
                    if (data.message) { 
                        $('#userId').text('');
                        $('#userRealName').text('');
                        $('#userAdr').text('');
                        
                        $('#libraryPrice').text('');
                        $('#libraryPriceTotal').text('');
                        
                        $('#guestOnePrice').text('');
                        $('#guestTwoPrice').text('');
                        $('#guestPriceTotal').text('');
                        
                        $('#totalPrice').text('');
                        
                        $('#id').text('');
                        alert("조회 결과가 없습니다.");
                        location.reload();
                        return; 
                    }
            },
            error: function(xhr, status, error) {
                console.log("Error: " + error);
            }
        });
    });
});
</script>
</body>
</html>