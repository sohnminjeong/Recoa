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
	display:flex;
	align-items:center;
	margin:0 50px;
}
#content>#noteViewBar{
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
#container>#containerContent{
	width:100%;
	border : 2px solid black;
	border-radius : 30px;
	height:100%;
	padding: 0 10px;
	
}
#userFloating{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    right: 4%;
}
.backColorGray{
	background-color:gray;
}
.backColorYellow{
	background-color:yellow;
}
</style>
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
		<h3>채팅</h3>
		<div id="containerContent">
			<!-- 채팅 -->
			<div class="container">
				
				<div>
					<div id="chatMessageArea" class="col">
						<!-- 기존 적힌 부분 -->
						<c:forEach items="${chatList}" var="hadChat">
							<!-- 채팅 작성자==현유저 -->
							<c:if test="${hadChat.userNumber==user.userCode}">
								<div class="backColorGray">
									<b>${hadChat.chatMessage}</b>
								</div>
							</c:if>
							<c:if test="${hadChat.userNumber!=user.userCode}">
								<div class="backColorYellow">
									<b>${hadChat.chatMessage}</b>
								</div>
							</c:if>
						</c:forEach>
		 				<!-- 새로 적히는 부분 -->
					</div>
					
					<div class="col-6">
						<div class="input-group mb-3">
							<!-- input태그에 메세지 작성해 #button-send누르면 메세지 전송 -->
							<input type="text" id="chatMessage" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
								<button type="button" onclick="onClose()">나가기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>

<!-- sockJs의 CDN 추가해야 함 -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
var sock = new SockJS('http://localhost:8080/chatting');
sock.onmessage = onMessage;
sock.onclose = onClose;
var chatRoomCode = ${chatRoomCode};
//채팅창에 들어왔을 때 자동실행
// sock.send( JSON.stringify({"chatRoomCode": chatRoomCode}));
sock.onopen = function(){
	alert(chatRoomCode);
	var user = '${user.userNickname}';
	var str="<div>";
	 str+="<b>" + user + "님이 입장하셨습니다." + "</b>";
	 str+="</div>"
	 
	$("#chatMessageArea").append(str);
}


//전송 버튼 누르는 이벤트
$("#button-send").on("click", function(e) {
	sendMessage();
	$('#chatMessage').val('')
});
// 작성한 내용 전달
function sendMessage() {
	sock.send($("#chatMessage").val());
}

//서버에서 메시지를 받았을 때
function onMessage(msg) {
	
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	
	var arr = data.split(":");
	sessionId = arr[0]; // 작성자 닉네임
	message = arr[1]; // 작성 내용
	
	var cur_session = '${user.userNickname}'; //현재 세션에 로그인 한 사람
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	if(sessionId == cur_session){
		// 보낸user와 먼저 방을 연 user가 같을 경우
		var str="<div class='backColorGray'>";
		 str+="<b>" + sessionId + " : " + message + "</b>";
		 str+="</div>"
		
		$("#chatMessageArea").append(str);
	}
	else{
		// 보낸 user와 방을 연 user가 다를 경우
		var str="<div class='backColorYellow'>";
		 str+="<b>" + sessionId + " : " + message + "</b>";
		 str+="</div>"
		
		$("#chatMessageArea").append(str);
	}
	
	$.ajax({
		type:"post",
		url:"/insertChatting",
		data : {"chatRoomCode":chatRoomCode, "chatMessage":message,"userNumber":${user.userCode}},
		 
		success:function(result){
			if(result){
				alert("디비 저장 성공");
			}else{
				alert("디비 저장 실패");
			}
		}
	})
	
}
//채팅창에서 나갔을 때
function onClose() {
	
	var user = '${user.userNickname}';
	var str = user + " 님이 퇴장하셨습니다.";
	
	$("#chatMessageArea").append(str);
	//location.replace("/");
}


</script>
</body>
</html>