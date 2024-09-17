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

#container>h3{
	font-size : 1.7rem;
	font-weight:bold;
	margin : 20px;
	font-family: 'GangwonEdu_OTFBoldA';
}

#userFloating{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    right: 4%;
}

/* 테이블 스타일 */
 #cost {
            width: 100%;
            font-family: 'GangwonEdu_OTFBoldA';
            height: 420px;
            font-size: 1.2rem;
 }
 
  thead{
		      height: 8%;
		         border-bottom: 1px solid black;
		         color : gray;
 		  }
   tr{
      display: grid;
        grid-template-columns: 0.5fr 1fr 2fr 1fr 1fr;
        width: 100%;
        text-align: center;
   }
   
   tbody{
      height: 100%;
        display: grid;
        grid-template-rows: repeat(10, 1fr);
        margin-top: 15px;
   }
        
  .info-label {
       font-weight: bold;
       text-align: left;
   }
 #paging{
	width: 100%;
	display: flex;
	flex-direction: row;
}

#paging ul{
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
    width: 100%;
    position: relative;
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
				<h3>게스트하우스 이용 내역</h3>	
			<table id="cost">
	        <thead>
        <tr>
        <th>NO</th>
        <th>룸타입</th>
            <th>사용일</th>
            <th>예약일</th>
            <th>가격</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="bill" items="${bills}" varStatus="status">
            <tr>
            <td>${paging.total - (paging.page - 1) * 10 - status.index}</td>
           <c:choose>
					    <c:when test="${bill.roomType eq 'one'}">
					    	<td>원룸</td>
					    </c:when>
					    <c:otherwise>
							 <td>투룸</td>
					    </c:otherwise>
					</c:choose>
                <td>
	               	<fmt:formatDate value="${bill.startTime}" pattern="yy-MM-dd" /> ~ <fmt:formatDate value="${bill.endTime}" pattern="yy-MM-dd" />     
                </td>
               <td>
               		<fmt:formatDate value="${bill.regiDate}" pattern="yy-MM-dd" />
				</td>
                <td>${bill.price}원</td>
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
												href="/myLibrary?select=${paging.select}&keyword=${paging.keyword}&page=${paging.startPage=1}">Previous</a>
										</c:when>
										<c:when
											test="${(paging.startPage == 1)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link" href="/myLibrary?page=${paging.startPage=1}"><</a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/myLibrary?page=${paging.startPage-1}"><</a>
										</c:otherwise>
									</c:choose>

								</li>
								<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
									<li class="page-item">
									
										<c:choose>
											<c:when test="${(paging.select != null) && (paging.keyword != null)}">
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/myLibrary?select=${paging.select}&keyword=${paging.keyword}&page=${page}"
													id="page_num">
													${page}
												</a>
											</c:when>
											<c:otherwise>
												<a class="page-link ${paging.page== page ? 'active' : ''}"
													href="/myLibrary?page=${page}" id="page_num">
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
												href="/myLibrary?select=${paging.select}&keyword=${paging.keyword}&page=${paging.endPage=paging.endPage}">Next</a>
										</c:when>
										<c:when
											test="${(paging.endPage < 10)&&(paging.select == null) && (paging.keyword == null)}">
											<a class="page-link"
												href="/myLibrary?page=${paging.endPage=paging.endPage}">></a>
										</c:when>
										<c:otherwise>
											<a class="page-link" href="/myLibrary?page=${paging.endPage + 1}">></a>
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