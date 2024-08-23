<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	margin:0 50px;
}
#content #container{
	display:flex;
	flex-direction:column;
	justify-content:center;
	align-items:center;
	width:100%;
	height:100%;
}
#containerHead{
	display:flex;
	justify-content:space-between;
	width:70%;
	border-bottom : 1px dashed black;
	padding-bottom:15px;
}
#containerHead h3{
	font-family: 'GangwonEdu_OTFBoldA';
	font-size:1.7rem;
}
#containerHead #searchBoardFree{
	select{
		 font-family: 'SDMiSaeng';
		 font-size:1rem;
	} 
	option{
		font-size:1rem;
	}
	input{
		font-family: 'SDMiSaeng';
		 font-size:1rem;
	}
}
table{
	width:70%;
	height:60%;
	font-family: 'GangwonEdu_OTFBoldA';
	font-size : 1.2rem;
	thead{
		height: 8%;
   		border-bottom: 1px solid black;
   		color : gray;
	}
	tr{
		display: grid;
        grid-template-columns: 0.5fr 2fr 1fr 1fr 0.5fr;
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
	}
}
#registerBtn{
	margin:15px 0;
	width:70%;
	display:flex;
	justify-content:right;
}
#registerBtn button{
	border-radius:3px;
	border:none;
	font-family: 'SDMiSaeng';
	font-size:1rem;
}
#registerBtn button:hover{
	background-color : black;
	color : white;
	cursor:pointer;
}

#paging{
	margin-top : 20px;
	width:40%;
	
	.pagination{
		width: 100%;
	    display: flex;
	    justify-content: space-evenly;
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
	<div id="container">
		<div id="containerHead">
			<h3>자유 게시판</h3>
			<div id="searchBoardFree">
				<form action="viewAllBoardFree" method="get">
					<select name="select">
						<option value="allFind">전체</option>
						<option value="titleFind">제목</option>
						<option value="contentFind">내용</option>
					</select>
					<input type="text" name="keyword">
					<button type="submit" id="searchOk"><i class="fa-solid fa-magnifying-glass"></i></button>
				</form>
			</div>
		</div>
		<div id="registerBtn">
			<c:if test="${user!='anonymousUser'}">
				<button type="button" onclick="location.href='/registerBoardFree';">게시물 작성</button>
			</c:if>
		</div>
		<table>
			<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>닉네임</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="item" varStatus="status">
					<tr>
						<td>${paging.total - (paging.page - 1) * 10 - status.index}</td>
						<td><a href="/viewOneBoardFree?freeCode=${item.freeCode}">${item.freeTitle}</a></td>
						<td>${item.user.userNickname}</td>
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
							test="${(paging.startPage == 1)&&(paging.select != null) && (paging.keyword != null)}">
							<a class="page-link"
								href="/viewAllBoardFree?select=${paging.select}&keyword=${paging.keyword}&page=${paging.startPage=1}"><i class="fa-solid fa-chevron-left"></i></a>
						</c:when>
						<c:when
							test="${(paging.startPage == 1)&&(paging.select == null) && (paging.keyword == null)}">
							<a class="page-link" href="/viewAllBoardFree?page=${paging.startPage=1}"><i class="fa-solid fa-chevron-left"></i></a>
						</c:when>
						<c:otherwise>
							<a class="page-link" href="/viewAllBoardFree?page=${paging.startPage-1}"><i class="fa-solid fa-chevron-left"></i></a>
						</c:otherwise>
					</c:choose>
				</li>
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
					<li class="page-item">
						<c:choose>
							<c:when test="${(paging.select != null) && (paging.keyword != null)}">
								<a class="page-link ${paging.page== page ? 'active' : ''}"
									href="/viewAllBoardFree?select=${paging.select}&keyword=${paging.keyword}&page=${page}"
									id="page_num">
									${page}
								</a>
							</c:when>
							<c:otherwise>
								<a class="page-link ${paging.page== page ? 'active' : ''}"
									href="/viewAllBoardFree?page=${page}" id="page_num">
									${page}
								</a>
							</c:otherwise>
						</c:choose>
					</li>
				</c:forEach>
	
				<li class="page-item ${paging.next ? '' : 'disabled'}">
					<c:choose>
						<c:when
							test="${(paging.endPage < 10)&&(paging.select != null) && (paging.keyword != null)}">
							<a class="page-link"
								href="/viewAllBoardFree?select=${paging.select}&keyword=${paging.keyword}&page=${paging.endPage=paging.endPage}"><i class="fa-solid fa-chevron-right"></i></a>
						</c:when>
						<c:when
							test="${(paging.endPage < 10)&&(paging.select == null) && (paging.keyword == null)}">
							<a class="page-link"
								href="/viewAllBoardFree?page=${paging.endPage=paging.endPage}"><i class="fa-solid fa-chevron-right"></i></a>
						</c:when>
						<c:otherwise>
							<a class="page-link" href="/viewAllBoardFree?page=${paging.endPage + 1}"><i class="fa-solid fa-chevron-right"></i></a>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</nav>
	</div>
</div>
</body>
</html>