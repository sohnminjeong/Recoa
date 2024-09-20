<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<style>
@font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'SDMiSaeng';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SDMiSaeng.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
#header{
	position:absolute;
	z-index:1;
	width:100%;
	border-bottom:1px solid black;
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
#content>#noteViewBar{
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
#container>h3{
	font-size : 1.7rem;
	font-weight:bold;
	margin : 15px;
	font-family: 'GangwonEdu_OTFBoldA';
}
#container>#containerContent{
	width:100%;
	border : 2px solid black;
	border-radius : 30px;
	height:100%;
	padding: 0 10px;
	
}
#userFloating{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    right: 4%;
}
table{
	width:100%;
	height:90%;
	font-family: 'GangwonEdu_OTFBoldA';
	
	thead{
		height: 12%;
   		border-bottom: 1px solid black;
   		color : gray;
   		font-family: 'GangwonEdu_OTFBoldA';
   		font-size : 1rem;
	}
	tr{
		display: grid;
        grid-template-columns: 0.5fr 1.6fr 0.7fr 0.7fr 0.9fr 0.4fr;
        width: 100%;
        text-align: center;
        align-items: center;
        height: 100%;
        
       	a:hover{
       		color : gray;
       	}
        
	}
	tbody{
		height: 92%;
        display: grid;
        grid-template-rows: repeat(10, 1fr);
        margin-top: 15px;
        font-family: 'GangwonEdu_OTFBoldA';
   		font-size : 1rem;
	}
}
#paging{
	height:10%;
	display:flex;
	justify-content:center;
	.pagination{
		width:65%;
		display:flex;
		justify-content:space-evenly;
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
	<div id="noteViewBar">
		<%@ include file="../note/noteViewBar.jsp" %>
	</div>
	<div id="container">
		<h3>내 쪽지함 _ 전체 쪽지함</h3>
		<div id="containerContent">
			
			<table>
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>보낸 사람</td>
						<td>받은 사람</td>
						<td>작성일</td>
						<td>첨부 파일</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="item" varStatus="status">
						<tr>
							<td>${paging.total-(paging.page-1)*10-status.index}</td>
							<td><a href="/viewOneNote?noteCode=${item.noteCode}">${item.noteTitle}</a></td>
							<td>${item.senderNick}</td>
							<td>${item.receiverNick}</td>
							<td>
								<fmt:formatDate value="${item.noteWritedate}" pattern="yy-MM-dd HH:mm" />
							</td>
							<td>
								<c:if test="${item.hasNote!=false}">
									<i class="fa-solid fa-file-lines"></i>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<nav id="paging">
				<ul class="pagination">
					<li class="page-item ${paging.prev ? '':'disabled'}">
						<c:choose>
							<c:when
								test="${paging.startPage == 1}">
								<a class="page-link"
									href="/viewAllNote?page=${paging.startPage=1}&userCode=${user.userCode}">
									<i class="fa-solid fa-chevron-left"></i>
								</a>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="/viewAllNote?page=${paging.startPage-1}&userCode=${user.userCode}">
									<i class="fa-solid fa-chevron-left"></i>
								</a>
							</c:otherwise>
						</c:choose>
					</li>
					<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
						<li class="page-item">
							<a class="page-link ${paging.page== page ? 'active' : ''}"
								href="/viewAllNote?page=${page}&userCode=${user.userCode}" id="page_num">
								${page}
							</a>
						</li>
					</c:forEach>
		
					<li class="page-item ${paging.next ? '' : 'disabled'}">
						<c:choose>
							<c:when
								test="${paging.endPage < 100}">
								<a class="page-link"
									href="/viewAllNote?page=${paging.endPage}&userCode=${user.userCode}">
									<i class="fa-solid fa-chevron-right"></i>
								</a>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="/viewAllNote?page=${paging.endPage + 1}&userCode=${user.userCode}">
									<i class="fa-solid fa-chevron-right"></i>
								</a>
							</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</body>
</html>