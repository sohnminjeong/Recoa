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
<link href="../../resources/css/utillbill/viewMyBill.css" rel="stylesheet" type="text/css">
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
		<%@ include file="../user/userSideBar.jsp" %>
		</div>
		<div id="container">
		<h1>아파트 관리비 고지서</h1>
	
	<table id="table">
	        <tr>
	            <td class="info-label">아파트</td>
	            <td>블루포레스트시티</td>
	            <td class="info-label">이름</td>
	            <td>${user.userRealName}</td>
	        </tr>
	        <tr>
	            <td class="info-label">주소</td>
	            <td>${user.userAdr}동 ${user.userAdrDetail}호</td>
	            <td class="info-label">결제일</td>
	            <td>2024-09-25</td>
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
				<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${libraryPrice}" />원
				</td>
				<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${libraryPrice}" />원
				</td>
				<td><button type="button" onclick="location.href='/myBillLibDesc'">상세보기</button></td>
			</tr>
			<tr>
				<td>게스트하우스</td>
				<td id="desc">원룸</td>
				<td  id="desc">
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${guestOnePrice}" />원
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td  id="desc">투룸</td>
				<td  id="desc">
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${guestTwoPrice}" />원
				</td>
				<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${guestPrice}" />원
				</td>
				<td><button type="button" onclick="location.href='/myBillGuestDesc'">상세보기</button></td>
			</tr>
		</tbody>
	</table>
	    <div class="summary">
	        총 예약 요금: <span id="totalPrice">${totalPrice}</span>원
	        <button id="payment" 
			        ${paid ? 'disabled' : ''}>
			    ${paid ? '결제 완료' : '결제하기'}
</button>
	    </div>
	</div>
	
	</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script>
$(document).ready(function() {
    
    // 결제 버튼 클릭 이벤트
    $("#payment").on("click", function () {
        const userRealName = '${user.userRealName}';
        const userPhone = '${user.userPhone}';
        const userAdr = '${user.userAdr}';
        const userAdrDetail = '${user.userAdrDetail}';
        const totalPrice = document.getElementById("totalPrice").textContent.replace('원', '').trim();

        var IMP = window.IMP;
        IMP.init('imp07788852');

        IMP.request_pay({
            pg: 'html5_inicis',
            pay_method: 'card',
            merchant_uid: "O" + new Date().getTime(),
            name: "결제 금액",
            amount: 100,
            buyer_email: "",
            buyer_name: userRealName,
            buyer_tel: userPhone,
            buyer_addr: userAdr,
            buyer_postcode: userAdrDetail
        }, function (rsp) {
            console.log("rsp: ", rsp);
            if (rsp.success) {
                const today = new Date();
                const month = today.getMonth() + 1;
                const day = today.getDate();

                $.ajax({
                    url: "/payments/verify",
                    method: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify({
                        imp_uid: rsp.imp_uid,
                        merchant_uid: rsp.merchant_uid,
                        month: month,
                        day: day
                    }),
                    success: function(response) {
                        if (response.response.status == "paid") {
                            $.ajax({
                                url: '/updatebills',
                                method: 'POST',
                                contentType: 'application/json',
                                data: JSON.stringify({}),
                                success: function(response) {
                                    alert("결제되었습니다");
                                    // 결제 완료 후 버튼 상태 업데이트
                                    $('#payment').text('결제 완료');
                                    $('#payment').attr('disabled', true);
                                },
                                error: function(error) {
                                    console.error("청구서 정보 저장 오류:", error);
                                    alert("청구서 정보 저장에 실패했습니다.");
                                }
                            });
                        } else {
                            console.log("결제 정보 저장 실패 이유:", response);
                            alert("결제 정보 저장에 실패했습니다.");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX 요청 오류:", status, error);
                    }
                });
            } else {
                alert('결제에 실패하였습니다. 에러내용 : ' + rsp.error_msg);
            }
        });
    });
});

</script>
</body>
</html>