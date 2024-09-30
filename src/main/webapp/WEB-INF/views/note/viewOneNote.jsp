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
<link rel="stylesheet" href="../../../resources/css/note/viewOneNote.css" />
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
		<h3>쪽지 확인</h3>
		<div id="containerContent">
			<div id="contentTop">
				<span>보낸 사람 : ${vo.senderNick}</span>
				<span>받는 사람 : ${vo.receiverNick}</span>
				<span>작성일 : <fmt:formatDate value="${vo.noteWritedate}" pattern="yy-MM-dd HH:mm"/></span>
			</div>
			<div id="contentCenter">
				<span>${vo.noteTitle }</span>
				<div id="contentFiles">
					<c:forEach items="${files}" var="file" >
						<a href="/recoaImg/note/${file.noteFileUrl}" download>
		                <i class="fa-solid fa-file-arrow-down"> </i>
		                첨부 파일 다운로드
		              </a>
					</c:forEach>
				</div>
			</div>
			<div id="contentBottom">
				<span>${vo.noteContent}</span>
			</div>
			<div id="noteBtn">
				<c:if test="${vo.receiverNick==user.userNickname}">
					<button type="button" id="replyNote">답장</button>
					<div id="noteJsp" style="display : none">
						<jsp:include page="../note/noteSideBar.jsp" flush="true">
							<jsp:param value="${vo.senderNick}" name="param1"/>
							<jsp:param value="${vo.noteSender}" name="param3"/>
						</jsp:include>
					</div>
				</c:if>
				<button type="button" onclick="location.href='/deleteNote?noteCode=${vo.noteCode}'">삭제</button>
				<button type="button"  onclick="history.back()">목록</button>
			</div>
		</div>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script src="../../../resources/js/note/viewOneNote.js"></script>
</body>
</html>