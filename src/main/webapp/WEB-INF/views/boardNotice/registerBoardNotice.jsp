<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../resources/css/reset.css" />
<link href="../../resources/css/boardNotice/registerNotice.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
	
	<div id="content">
		<h1>공지 작성</h1>
		<form action="/registerNotice" method="post" enctype="multipart/form-data" onsubmit="return validate()">
			<div id="input">
				<input type="text" name="noticeTitle" id="noticeTitle" placeholder="제목">
				<textarea name="noticeContent" id="noticeContent" placeholder="내용"></textarea>
			</div>
			<input type="file" name="files" multiple="multiple" id="file" style="display: none;" onchange="setImage(event)"/>
			<input type="hidden" name="userCode" value="${user.userCode}" readonly/>
			
			<!-- 사진이 추가되지 않았을 경우 -->
			<div id="button-container">
				<button type="button" id="addImg">이미지 첨부</button>
				<button type="button" id="deleteImg" style="display:none;">이미지 삭제</button>
			</div>
			<!-- 미리보기 보일 곳 -->
			<div id="preview" style="display: none;"></div>
			<div id="buttons">
				<div id="checkbox">
					<input type="checkbox" id="important" name="important"><label for="important">중요글</label>
				</div>
				<button type="submit" id="submit">등록하기</button>
				<button type="button" onclick="location.href='/boardNoticeList';">작성 취소</button>
			</div>
		</form>
	</div>
	<div id="userFloating">
		<%@ include file="../main/floating.jsp" %>
	</div>
	
<script src="../../../resources/js/boardNotice/registerBoardNotice.js"></script>
</body>
</html>