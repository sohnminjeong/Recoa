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
<link rel="stylesheet" href="../../../resources/css/boardFree/updateBoardFree.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
	<div id="container">
		<h3>게시물 수정</h3>
		<form action="/updateBoardFree" method="post" enctype="multipart/form-data" onsubmit="return validate()">
		<input type="hidden" value="${vo.freeCode}" name="freeCode">
			<div id="data">
				<input type="text" value="${vo.freeTitle}" name="freeTitle" id="freeTitle">
				<textarea name="freeContent" id="freeContent">${vo.freeContent}</textarea>
				<input type="file" name="file" multiple="multiple" id="file" style="display: none;" onchange="imgShow(event)">
				
				<div id="addImg">
					<c:if test="${imgList!=null}">
						<c:forEach items="${imgList}" var="img" varStatus="status">
							<img src="/recoaImg/boardFree/${img.freeImgUrl}" class="clickImg"/>
						</c:forEach>						
					</c:if>				
				</div>
				<div id="imgBtn">
					<button type="button" id="selectImg">이미지 첨부</button>
					<button type="button" id="delImg">이미지 삭제</button>
					<input type="hidden" id="delImgBtn" value="${vo.delImgBtn}" name="delImgBtn"/>
				</div>
				
				<div id="createImg"></div>
			</div>
			<div class="btn">
				<button type="submit">수정 완료</button>
				<button type="button" onclick="location.href='/viewOneBoardFree?freeCode=${vo.freeCode}';">수정 취소</button>
			</div>
		</form>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script src="../../../resources/js/boardFree/updateBoardFree.js"></script>
</body>
</html>