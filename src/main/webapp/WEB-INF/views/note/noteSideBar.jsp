<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%String param1=request.getParameter("param1"); %>
<%String param2=request.getParameter("param2"); %>
<%Integer param3=Integer.parseInt(request.getParameter("param3")); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../../../resources/css/note/noteSideBar.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
	
		<div id="noteSideBar">
			<span id="noteBtn">쪽지 보내기</span>
			<span id="chatBtn">채팅 하기</span>
		</div>
	
	<div id="noteWrite" style="display:none">
	<c:set var="receiverNick" value="<%=param1 %>"/>
		<c:if test="${user!='anonymousUser' and user.userNickname ne receiverNick }">
			<div id="noteWriteInner">
				<h3>쪽지 보내기</h3>
				<form action="/registerNote" id="registerNote" method="post" enctype="multipart/form-data">
					<div id="person">
						<div>
							<span>보내는 사람</span>
							<input type="text" id="senderNick" name="senderNick" value="${user.userNickname}">
						</div>
						<div>
							<span>받는 사람</span>
							<input type="text" id="receiverNick" name="receiverNick" value="<%=param1%>">
						</div>
					</div>
					<div id="innerContents">
						<input type="text" id="noteTitle" name="noteTitle" placeholder="제목"> 
						<textarea placeholder="내용" name="noteContent" id="noteContent"></textarea>
						<input type="file" id="noteFile" name="noteFile" multiple="multiple" onchange="fileRegi(event)" >
					</div>
					<div id="innerBtn">
						<button type="button" id="registerNoteBtn">쪽지 전송</button>
						<button type="button" onclick="location.href=location.href">쪽지 취소</button>
					</div>
				</form>
			</div>
		</c:if>
		<c:if test="${user=='anonymousUser'}">
			<div class="noteWriteInnerNo">
				<span>비회원의 경우, 로그인 부탁드립니다.</span>
				<div>
					<button type="button" onclick="location.href='/loginUser';">로그인</button>
					<button type="button" onclick="location.href=location.href">뒤로가기</button>
				</div>
			</div>
		</c:if>
		<c:if test="${user!='anonymousUser' and user.userNickname eq receiverNick }">
			<div class="noteWriteInnerNo">
				<span>본인에게 쪽지 보내기는 불가합니다.</span>
				<div>
					<button type="button" onclick="location.href=location.href">뒤로가기</button>
				</div>
			</div>
		</c:if>
	</div>
<div id="nowChatting" class="nowChatting" style="display:none">
</div>	
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
const receiverCode = <%=param3%>;
const senderCode = ${user.userCode};
</script>
<script src="../../../resources/js/note/noteSideBar.js"></script>
<script>
$('#registerNoteBtn').click(function(){
	$.ajax({
		type:"post",
		url:"/registerNote",
		data:$("#registerNote").serialize(),
		
		success:function(result){
			if(alarmSocket){
    			let socketMsg = "note,"+result.senderNick+","+result.receiverNick+","+result.noteTitle+","+result.noteCode;
    			alarmSocket.send(socketMsg);
       		}
			
			location.replace('/viewAllNote?userCode=${user.userCode}');
		}
	})
})
</script>
</body>
</html>