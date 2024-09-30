<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<link href="../../resources/css/boardNotice/updateNotice.css" rel="stylesheet" type="text/css">

</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
	
	<div id="content">
		<h1>공지 수정</h1>
		<form action="/updateBoardNotice" method="post" enctype="multipart/form-data" onsubmit="return validate()">
			<input type="hidden" name="delImages" id="delImages" value="false"/>
			<div id="input">
				<input type="text" name="noticeTitle" id="noticeTitle" value="${notice.noticeTitle}" placeholder="제목">
				<textarea name="noticeContent" id="noticeContent"  placeholder="내용">${notice.noticeContent}</textarea>
			</div>
			<input type="file" name="files" multiple="multiple" id="file" style="display: none;" onchange="setImage(event)"/>
			<input type="hidden" name="userCode" value="${user.userCode}" readonly/>
			<input type="hidden" name="noticeCode" value="${notice.noticeCode}" readonly/>
			
			<div id="button-container">
				 <div id="images">
			        <c:if test="${images != null}">
			            <c:forEach items="${images}" var="img" varStatus="status">
			                <img src="/recoaImg/boardNotice/${img.noticeImgUrl}"/>
			            </c:forEach>
			        </c:if>
			    </div>
			        <div id="preview"></div>
			    <div id="imgButtons">
			        <button type="button" id="addImg">이미지 추가</button>
			        <button type="button" id="deleteImg" style="display: none;">이미지 삭제</button> <!-- Always in DOM -->
    			</div> 	
			</div>
			
			<div id="buttons">
				<div id="checkbox">
					<input type="checkbox" id="important" name="important" <c:if test="${notice.important}">checked</c:if> > <label for="important">중요글</label>
				</div>
				<button type="submit" id="submit">수정하기</button>
				<button type="button" onclick="location.href='/viewNotice?noticeCode=${notice.noticeCode}'">수정 취소</button>
			</div>
		</form>
	</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script src="../../../resources/js/boardNotice/updateBoardNotice.js"></script>
</body>
</html>