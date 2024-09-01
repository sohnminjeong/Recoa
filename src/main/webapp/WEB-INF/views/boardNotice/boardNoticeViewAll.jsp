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
	margin:0 50px;
}

#container{
	display: flex;
	flex-direction: column;
	justify-content:center;
	align-items:center;
	width: 100%;
	height: 100%;
}

#topBar{
	display: flex;
	justify-content: space-between;
	width: 70%;
	border-bottom: 1px dashed black;
	padding-bottom: 15px;
}

h3{
	font-family: 'GangwonEdu_OTFBoldA';
	font-size:1.7rem;
}
#searchBar{
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
#regist{
	display: flex;
	justify-content: right;
	width: 70%;
	margin: 15px;
}
#regist button{
	border-radius: 5px;
	border: none;
	padding-top: 5px;
	font-family: 'GangwonEdu_OTFBoldA';
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

#paging{
	width: 100%;
	display: flex;
	flex-direction: row;
}

.pagination{
	align-items: center;
	margin: 0 auto;
	display: flex;
	justify-content: space-evenly;
	padding-top: 25px;
    position: relative;
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
	<div id="container">
		<div id="topBar">
			<h3>공지 게시판</h3>
			<div id="searchBar">
				<form action="boardNoticeList" method="get">
					<select name="select">
						<option value="all">전체</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="keyword">
					<button type="submit" id="searchOk"><i class="fa-solid fa-magnifying-glass"></i></button>
				</form>
			</div>
		</div>
		
		<div id="regist">
			<c:if test="${user!='anonymousUser'}">
				<button type="button" onclick="location.href='/registerNotice'">공지 작성</button>
			</c:if>
		</div>
			<table>
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성일</td>
						<td>조회수</td>
						<td>북마크</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="item" varStatus="status">
						<tr>
							<td>${item.noticeCode}</td>
							<td>
								<a href="/viewNotice?noticeCode=${item.noticeCode}">
					                ${item.noticeTitle}
					            </a>
							</td>
							<td>
								<fmt:formatDate value="${item.noticeWritedate}" pattern="yy-MM-dd HH:mm" />
							</td>
							<td>${item.noticeView}</td>
							<td>북마크수</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
	

	<nav id="paging">
			<ul class="pagination">
								<li class="page-item ${paging.prev ? '' : 'disabled'}">

									<c:choose>
										<c:when
											test="${(paging.startPage == 1)&&(paging.select != null) && (paging.keyword != null)}">
											<a class="page-link"
												href="/boardNoticeList?select=${paging.select}&keyword=${paging.keyword}&page=${paging.startPage=1}">Previous</a>
										</c:when>
										<c:when
											test="${(paging.startPage == 1)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link" href="/boardNoticeList?page=${paging.startPage=1}"><</a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/boardNoticeList?page=${paging.startPage-1}"><</a>
										</c:otherwise>
									</c:choose>

								</li>
								<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
									<li class="page-item">
									
										<c:choose>
											<c:when test="${(paging.select != null) && (paging.keyword != null)}">
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/boardNoticeList?select=${paging.select}&keyword=${paging.keyword}&page=${page}"
													id="page_num">
													${page}
												</a>
											</c:when>
											<c:otherwise>
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/boardNoticeList?page=${page}" id="page_num">
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
												href="/boardNoticeList?select=${paging.select}&keyword=${paging.keyword}&page=${paging.endPage=paging.endPage}">Next</a>
										</c:when>
										<c:when
											test="${(paging.endPage < 10)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link"
												href="/boardNoticeList?page=${paging.endPage=paging.endPage}">></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/boardNoticeList?page=${paging.endPage + 1}">></a>
										</c:otherwise>
									</c:choose>
								</li>
							</ul>
						</nav>
	</div>
</div>
<script>

</script>
</body>
</html>