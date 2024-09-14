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
<title>Insert title here</title>
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
	position:relative;
	z-index:0;
	height:100vh;
	padding-top:10vh;
	display:flex;
	align-items:center;
	margin:0 50px;
}
#content>#userSideBar{
	height:80%;
	width:15%;
	margin-left : 10%;
	margin-right:5%;
}

#content>#container{
	width: 75%;
	height:80%;
    display: flex;
    flex-direction: column;
    margin-right: 10%;
}

#container>h1{
	font-size: 2rem;
 	 font-family: 'GangwonEdu_OTFBoldA';
	font-weight: bolder;
	padding: 30px;
}

#container>h2{
	font-size: 1.5rem;
 	 font-family: 'GangwonEdu_OTFBoldA';
	font-weight: bolder;
	padding: 30px;
	color: gray;
	text-decoration: underline;
	margin-top: 30px;
}

#userFloating{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    right: 4%;
}

/* 테이블 스타일 */
 #table {
            width: 100%;
            font-family: 'GangwonEdu_OTFBoldA';
        th, td {
            border: 1px solid lightgray;
            padding: 8px;
            text-align: left;
        }
        
        th {
            font-weight: bold;
        }
        
        td {
            font-size: 1rem;
        }
        
        .info-label {
            font-weight: bold;
            text-align: left;
        }
 }
 #cost{
 	width: 100%;
 	 font-family: 'GangwonEdu_OTFBoldA';
   font-size : 1.2rem;
   thead{
      height: 8%;
         border-bottom: 1px solid black;
         color : gray;
   }
   tr{
      display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        width: 100%;
        text-align: center;
          a:hover{
             color : gray;
          }
   }
   
   tbody{
	   height: 100px;
        display: grid;
        grid-template-rows: 1fr 1fr;
        margin-top: 15px;
   }
   
   td{
   	margin-top: 15px;
   }
   
 }
 
 .summary{
 	text-align: right;
 	margin-top: 45px;
 	font-weight: bolder;
 	font-size: 1.2rem;
 	font-family: 'GangwonEdu_OTFBoldA';
 }
</style>
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
				<th>이용 요금</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>독서실</td>
				<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${libraryPrice}" />원
				</td>
				<td><button type="button" onclick="location.href='/myBillLibDesc'">상세보기</button></td>
			</tr>
			<tr>
				<td>게스트하우스</td>
				<td>
				<fmt:formatNumber type="number" maxFractionDigits="3" value="${guestPrice}" />원
				</td>
				<td><button type="button" onclick="location.href='/myBillGuestDesc'">상세보기</button></td>
			</tr>
		</tbody>
	</table>
	    
	
	    <div class="summary">
	        <p>총 예약 요금: ${totalPrice}원</p>
	    </div>
	
	</div>
	
	</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</body>
</html>