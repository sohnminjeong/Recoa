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
#chattingRoom{
	/*width: 12%;height: 35%;*/
	width:100%;
    height: 100%;
     border: 1px solid black;
	 border-radius:5px;
}
#chattingReceiver{
	height:10%;
	border-bottom:1px dashed black;
	display:flex;
	justify-content:space-between;
	align-items:center;
	padding: 0 10px;
	
	  #interlocutor{
    	display:flex;
    	align-items:center;
    	
    	img{
    		border-radius:50%;
    		width:20px;
    		height:20px;
    		margin-right:10px;
    		border:0.5px solid black;
    	}
    	
    }
	
}
#chattingContents{
	height:90%;
	width:100%;
	font-size: 0.8rem;
}
#chattingContents>#chatMessageArea{
	height:90%;
	width:100%;
	overflow-y: scroll;
	overflow-x: hidden;
    position: relative;
}
#chattingContents>#chatRoomBottom{
	display:flex;
	justify-content: space-between;
	height:10%;
	border-top : 1px dashed gray;
	
	input{
		width:80%;
		font-family: 'SDMiSaeng';
	}
	button{
		font-family: 'SDMiSaeng';
		width: 20%;
        font-size: 1.1rem;
	}
}
.backColorGray{
	
	position: relative;
    left: 30%;
    width: 70%;
    margin: 5px 0;
    padding: 5px;
    display: flex;
    justify-content: flex-end;

    b{
    	border: 0.1px solid gray;
        border-radius: 3px;
        margin-left: 5px;
        width: 100%;
        padding: 5px;
    }
	
}
.backColorYellow{
	
	position: relative;
    left: 0%;
    width: 70%;
   	margin : 5px 0;
    padding : 5px;
    display:flex;

    b{
    	border:0.1px solid gray;
    	border-radius:3px;
    	margin : 0px 5px;
    	width:95%;
    	padding : 5px;
    }
	
}
i:hover{
	cursor:pointer;
}
</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="chattingRoom">
	<div id="chattingReceiver">
		<div id="interlocutor">
			<c:choose>
				<c:when test="${interlocutor.userImgUrl==null}">
					<img src="resources/images/user/default_profile.png" class="userImg"/>
				</c:when>
				<c:otherwise>
					<img src="/recoaImg/user/${interlocutor.userImgUrl}" class="userImg"/>
				</c:otherwise>
			</c:choose>
			
			<span id="interlocutorNickname">${interlocutor.userNickname}</span>
			
		</div>	
		<div id="chatRoomOutBtn">
			<!-- <i class="fa-regular fa-circle-xmark"onclick=""></i> -->
			<i class="fa-solid fa-door-open" onclick="onClose()"></i>
		</div>
		
	</div>
	<div id="chattingContents">
		<div id="chatMessageArea" class="col">
			<!-- 기존 적힌 부분 -->
			<c:forEach items="${chatList}" var="hadChat">
				<!-- 채팅 작성자==현유저 -->
				<c:if test="${hadChat.userNumber==user.userCode}">
					<div class="backColorGray">
						<div>
							<fmt:formatDate value="${hadChat.chatTime}" pattern="HH:mm" />
						</div>
						
						<b>${hadChat.chatMessage}</b>
					</div>
				</c:if>
				<c:if test="${hadChat.userNumber!=user.userCode}">
					<div class="backColorYellow">
						<b>${hadChat.chatMessage}</b>
						<div>
							<fmt:formatDate value="${hadChat.chatTime}" pattern="HH:mm" />
						</div>
					</div>
				</c:if>
			</c:forEach>
				<!-- 새로 적히는 부분 -->
		</div>
		<!-- input태그에 메세지 작성해 #button-send누르면 메세지 전송 -->
		<div id="chatRoomBottom" class="col">
			<input type="text" id="chatMessage" class="chatMessage">
			<button type="button" id="button-send">전송</button>
			<!-- <button type="button" onclick="onClose()">나가기</button> -->
		</div>	
	</div>
</div>
		


<!-- sockJs의 CDN 추가해야 함 -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
const chatRoomCode = ${chatRoomCode};
const userCode = ${user.userCode};

var sock = new SockJS('http://localhost:8080/chatting');
sock.onmessage = onMessage;
sock.onclose = onClose;
//채팅창에 들어왔을 때 자동실행
sock.onopen = function(){
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
	
	const chatContext = {
			"userCode" : userCode,
			"chatRoomCode":chatRoomCode,
			"chatMessage":$("#chatMessage").val()
	};
	sock.send(JSON.stringify(chatContext));
}

//서버에서 메시지를 받았을 때
function onMessage(msg) {
	
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	var chatTime = null;
	
	var arr = data.split(":");
	sessionId = arr[0]; // 작성자 닉네임
	message = arr[1]; // 작성 내용
	chatTimeHour = arr[2]; // 작성 시간
	chatTimeMinutes = arr[3]; // 작성 분
	
	var cur_session = '${user.userNickname}'; //현재 세션에 로그인 한 사람
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	if(sessionId == cur_session){
		// 보낸user와 먼저 방을 연 user가 같을 경우
		var str="<div class='backColorGray'>";
			str+="<span>"+chatTimeHour+":"+chatTimeMinutes+"</span>";
		 	str+="<b>"+message + "</b>";
		 	str+="</div>"
		
		$("#chatMessageArea").append(str);
		  
	}
	else{
		// 보낸 user와 방을 연 user가 다를 경우
		var str="<div class='backColorYellow'>";
		str+="<span>"+chatTimeHour+":"+chatTimeMinutes+"</span>";
		 str+="<b>" + message + "</b>";
		 str+="</div>"
		
		$("#chatMessageArea").append(str);
	}
}

//채팅창에서 나갔을 때
function onClose() {
	var user = '${user.userNickname}';
	var str = user + " 님이 퇴장하셨습니다.";
	$("#chatMessageArea").append(str);
	window.location.reload();
}


</script>
</body>
</html>