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
			<table id="cost">
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
	               			 <fmt:formatDate value="${bill.startTime}" pattern="yy-MM-dd" /> ~ <fmt:formatDate value="${bill.endTime}" pattern="yy-MM-dd" />     
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
			</div>
	</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</body>
</html>