<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../../../resources/css/chat/viewListChat.css" />
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
		<h3>채팅방 목록</h3>
		<div id="containerContent">
			<!-- 채팅방 리스트 -->
			<div id="chatList">
				<c:forEach items="${chatList}" var="chat" varStatus="status">
					<div class="chat">
						<div id="chat_interlocutor">
							<c:choose>
								<c:when test="${chat.user.userImgUrl==null}">
									<img src="resources/images/user/default_profile.png" class="userImg"/>
								</c:when>
								<c:otherwise>
									<img src="/recoaImg/user/${chat.user.userImgUrl}" class="userImg"/>
								</c:otherwise>
							</c:choose>
							<span id="chat_interlocutorNickname">${chat.user.userNickname}</span>
						</div>
						<div class="chat_content" id="chatContent${chat.chatRoomCode}" value="${chat.chatRoomCode}">
							<c:choose>
								<c:when test="${chat.chatMessage==null||chat.chatMessage=='' }">
									<div id="content_chatMessage">${chat.chatFile.chatFileUrl}</div>
								</c:when>
								<c:otherwise>
									<div id="content_chatMessage">${chat.chatMessage}</div>
								</c:otherwise>
							</c:choose>
							
							<div  id="chatTime"> 
								<fmt:formatDate value="${chat.chatTime}" pattern="yy.MM.dd HH:mm"/>
							</div>
							<input  type="hidden" id="chatRoomCode" value="${chat.chatRoomCode}"/>
						</div>	
					</div>
				</c:forEach>
			</div>
			
			<!-- 채팅방 클릭 시 채팅 창 열릴 공간 -->
			<div id="chatBox" ></div>
		</div>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="../../../resources/js/chat/viewListChat.js"></script>
</body>
</html>