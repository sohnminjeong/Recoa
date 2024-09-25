<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
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
#header {
    position: absolute;
    z-index: 1;
    width: 100%;
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

#container>h3{
	font-size : 1.7rem;
	font-weight:bold;
	margin : 20px;
	font-family: 'GangwonEdu_OTFBoldA';
}
table{
   width:100%;
   height:420px;
   font-family: 'GangwonEdu_OTFBoldA';
   font-size : 1.2rem;
   thead{
      height: 8%;
         border-bottom: 1px solid black;
         color : gray;
         tr{
         	font-family: 'GangwonEdu_OTFBoldA';
         }
   }
   tr{
      display: grid;
        grid-template-columns: 0.5fr 1fr 1.8fr 1fr 0.7fr;
        width: 100%;
        text-align: center;
        
          a:hover{
             color : gray;
          }
        
   }
   
   tbody{
   
      height: 100%;
        display: grid;
        grid-template-rows: repeat(10, 1fr);
        margin-top: 15px;
        tr{
        	font-family: 'SDMiSaeng';
        	font-size:1.3rem;
        }
   }
   button{
   		height: 15px;
   		margin-bottom: 5px;
   }
}
#paging{
	width: 100%;
	ul{
		width: 100%;
	    display: flex;
	    flex-direction: row;
	    font-family: 'GangwonEdu_OTFBoldA';
	}
}

.pagination{
	display: flex;
	align-items: center;
	margin: 0 auto;
	
	justify-content: space-evenly;
	padding-top: 25px;
    width: 100%;
    position: relative;
}
#userFloating{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    right: 4%;
}
tr td{
	overflow:hidden
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
		<h3>좋아요</h3>
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="item" varStatus="status">
					<tr>
						<td>${paging.total - (paging.page - 1) * 10 - status.index}</td>
						<td><a href="/viewOneBoardFree?freeCode=${item.freeCode}">
					                ${item.freeTitle}
					        </a>
					    </td>
					    <td>
					    	<a href="/viewOneBoardFree?freeCode=${item.freeCode}">
					                ${item.freeContent}
					        </a>
						<td>
							<fmt:formatDate value="${item.freeWritedate}" pattern="yy-MM-dd HH:mm" />
						</td>
						<td>${item.freeView}</td>
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
								href="/liked?page=${paging.startPage=1}&userCode=${user.userCode}">
								<i class="fa-solid fa-chevron-left"></i>
							</a>
						</c:when>
						<c:otherwise>
							<a class="page-link" href="/liked?page=${paging.startPage-1}&userCode=${user.userCode}">
								<i class="fa-solid fa-chevron-left"></i>
							</a>
						</c:otherwise>
					</c:choose>
				</li>
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
					<li class="page-item">
						<a class="page-link ${paging.page== page ? 'active' : ''}"
							href="/liked?page=${page}&userCode=${user.userCode}" id="page_num">
							${page}
						</a>
					</li>
				</c:forEach>
	
				<li class="page-item ${paging.next ? '' : 'disabled'}">
					<c:choose>
						<c:when
							test="${paging.endPage < 100}">
							<a class="page-link"
								href="/liked?page=${paging.endPage}&userCode=${user.userCode}">
								<i class="fa-solid fa-chevron-right"></i>
							</a>
						</c:when>
						<c:otherwise>
							<a class="page-link" href="/liked?page=${paging.endPage + 1}&userCode=${user.userCode}">
								<i class="fa-solid fa-chevron-right"></i>
							</a>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</nav>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</body>
</html>