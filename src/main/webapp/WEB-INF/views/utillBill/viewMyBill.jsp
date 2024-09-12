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
	font-family: 'Ownglyph_jiwoosonang';
	font-weight: bolder;
	padding: 30px;
}

#userFloating{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    right: 4%;
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
	
	    <div>
	        <p>블루포레스트시티</p>
	        <p>${user.userAdr}동 ${user.userAdrDetail}호</p>
	        <p>이름: <strong>${user.userRealName}</strong></p>
	        <p>결제일: <strong>2024-09-25</strong></p>
	    </div>
	
	    <h2>예약 요금 내역</h2>
	
	    <table>
	        <thead>
        <tr>
            <th>서비스명</th>
            <th>사용일</th>
            <th>가격</th>
            <th>방 종류</th> 
        </tr>
    </thead>
    <tbody>
        <c:forEach var="bill" items="${bills}">
            <tr>
                <td>${bill.serviceName}</td>
                <td>
	                <c:choose>
	                    <c:when test="${bill.serviceName == 'library'}">
	                       <fmt:formatDate value="${bill.startTime}" pattern="yy-MM-dd" />
	                    </c:when>
	                    <c:otherwise>
	               			 <fmt:formatDate value="${bill.startTime}" pattern="yy-MM-dd" /> ~ <fmt:formatDate value="${bill.endTime}" pattern="yy-MM-dd" />     
	                    </c:otherwise>
	                   </c:choose>
                </td>
               
                <td>${bill.price}</td>
                <td>
                    <c:if test="${bill.serviceName == 'guest'}">
                        ${bill.roomType}
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
	    </table>
	
	    <div class="summary">
	        <p>총 예약 요금: ${totalPrice}</p>
	    </div>
	
	    <div>
	        <h3>결제 안내</h3>
	        <p>결제 방법: 온라인 이체, 자동 이체, 카드 결제</p>
	        <p>문의: </p>
	    </div>
	</div>
	
	</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>

</body>
</html>