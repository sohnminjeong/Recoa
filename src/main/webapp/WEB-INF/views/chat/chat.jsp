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
    	 font-family: 'GangwonEdu_OTFBoldA';
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
	align-items : center;
	
	input{
		width:80%;
		font-family: 'SDMiSaeng';
		height:90%;
		border:none;
		font-size:1rem;
		
	}
	button{
		font-family: 'SDMiSaeng';
		width: 20%;
        font-size: 1.1rem;
        height:100%;
	}
}

.backColorGray{
	 font-family: 'GangwonEdu_OTFBoldA';
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
	 font-family: 'GangwonEdu_OTFBoldA';
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
.enter{
	margin:5px;
	 font-family: 'GangwonEdu_OTFBoldA';
}
#checkOut{
	position:fixed;
	left:43%;
	top:50%;
	width:300px;
	height:200px;
	border : 1px solid black;
	border-radius:3px;
	background-color : black;
	
	color:white;
	display:flex;
	flex-direction:column;
	align-items:center;
	justify-content:center;
	z-index:1;
	
	button{
		font-family: 'SDMiSaeng';
		font-size:1rem;
		margin-top:10px;
		
	}
	button:hover{
		cursor:pointer;
		
	}
}
.hasUrl{
	display: inline-block;
    width: 100%;
   overflow-wrap: break-word;
    padding-top: 5px;
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
			<i class="fa-solid fa-door-open" onclick="viewCheckOut()"></i>
		</div>
		<div id="checkOut" style="display:none">
			<span>채팅방을 나가시겠습니까?</span>
			<span>채팅방을 나갈 경우, 대화 내용이 전부 삭제됩니다.</span>
			<div id="checkOutBtn">
				<button type="button" onclick="onOut()">나가기</button>
				<button type="button"  onClick="window.location.reload()">취소</button>
			</div>
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
						<c:choose>
							<c:when test="${hadChat.chatMessage==null||hadChat.chatMessage==''}">
							<b>
								<a href="/recoaImg/chat/${hadChat.chatFile.chatFileUrl}" download class="hasUrl">
									${hadChat.chatFile.chatFileUrl}
								</a>
							</b>
							</c:when>
							<c:otherwise>
								<b>${hadChat.chatMessage}</b>		
							</c:otherwise>
						</c:choose>
					</div>
				</c:if>
				<c:if test="${hadChat.userNumber!=user.userCode}">
					<div class="backColorYellow">
						<c:choose>
							<c:when test="${hadChat.chatMessage==null||hadChat.chatMessage==''}">
								<b>
									<a href="/recoaImg/chat/${hadChat.chatFile.chatFileUrl}" download class="hasUrl">
										${hadChat.chatFile.chatFileUrl}
									</a>
								</b>
							</c:when>
							<c:otherwise>
								<b>${hadChat.chatMessage}</b>		
							</c:otherwise>
						</c:choose>
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
			<i class="fa-solid fa-paperclip"></i>
			<form action="/insertChatFile" method="post" id="insertChatFile" enctype="multipart/form-data">
				<input type="hidden" name="chatRoomCode" value="${chatRoomCode}">
				<input type="hidden" name="userNumber" value="${user.userCode}">
				<input type="file" name="fileList" id="fileList" multiple="multiple" onchange="showChatFile(event)" style="display:none">
			</form>
			
			<button type="button" id="button-send">전송</button>
		</div>	
	</div>
</div>
		


<!-- sockJs의 CDN 추가해야 함 -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
var chatRoomCode = ${chatRoomCode};
var userCode = ${user.userCode};

var fileUploadIcon = document.querySelector('.fa-paperclip');
var fileList = document.querySelector('#fileList');
fileUploadIcon.addEventListener('click', ()=>fileList.click());

var sock = new SockJS('http://localhost:8080/chatting');
sock.onmessage = onMessage;
sock.onclose = onClose;
//채팅창에 들어왔을 때 자동실행
sock.onopen = function(){
	var user = '${user.userNickname}';
	var str="<div class='enter'>";
	 str+="<b>" + user + "님이 입장하셨습니다." + "</b>";
	 str+="</div>"
	 
	$("#chatMessageArea").append(str);	 
}

// 이미지 name 보이도록
function showChatFile(event){
	if(event.target.files.length>=4){
		alert("한번에 첨부할 수 있는 파일 최대 갯수는 3개입니다.");
		return;
	}
	const formData = new FormData();
	formData.append('userNumber', userCode);
	formData.append('chatRoomCode', chatRoomCode);
	var fileList = event.target.files;
	for(var i=0; i<fileList.length; i++){
		formData.append('fileList',fileList[i]);	
	}
	
	$.ajax({
		type:"post",
		url:"/insertChatFile",
		data: formData,
		contentType:false,
		processData:false,
		
		success: function (result) {
			$(result).each(function(){
			 	sock.send("chatFile:"+this);
			});
		}
	})

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
	var cur_session = '${user.userNickname}'; //현재 세션에 로그인 한 사람
	
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	var chatTime = null;
	
	var arr = data.split(":");
	sessionId = arr[0]; // 작성자 닉네임
	message = arr[1]; // 작성 내용
	url=arr[2];
	chatTimeHour = arr[3]; // 작성 시간
	chatTimeMinutes = arr[4]; // 작성 분
	receiverNick = arr[5]; // 받는 사람 닉네임
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	if(sessionId == cur_session){
		// 보낸user와 먼저 방을 연 user가 같을 경우
		if(url!=0){
			// 파일 전송 경우
			var str="<div class='backColorGray'>";
			str+="<span>"+chatTimeHour+":"+chatTimeMinutes+"</span>";
		 	str+="<b>";
		 	str+="<a href='/recoaImg/chat/"+url+"'download class='hasUrl'>"; 
		 	str+=url+"</a>";
		 	str+= "</b>";
		 	str+="</div>"
		
			$("#chatMessageArea").append(str);
			
		} else{
			// 채팅 전송 경우
			var str="<div class='backColorGray'>";
			str+="<span>"+chatTimeHour+":"+chatTimeMinutes+"</span>";
		 	str+="<b>"+message+"</b>";
		 	str+="</div>"
		
			$("#chatMessageArea").append(str);	
		}
		  
	}
	else{
		// 보낸 user와 방을 연 user가 다를 경우
		if(url!=0){
			// 파일 전송 경우
			var str="<div class='backColorYellow'>";
			str+="<span>"+chatTimeHour+":"+chatTimeMinutes+"</span>";
		 	str+="<b>";
		 	str+="<a href='/recoaImg/chat/"+url+"'download class='hasUrl'>"; 
		 	str+=url+"</a>";
		 	str+= "</b>";
		 	str+="</div>"
		
			$("#chatMessageArea").append(str);
		}else{
			// 채팅 전송 경우
			var str="<div class='backColorYellow'>";
			str+="<span>"+chatTimeHour+":"+chatTimeMinutes+"</span>";
		 	str+="<b>"+message+"</b>";
		 	str+="</div>"
		
			$("#chatMessageArea").append(str);	
		}
	}
    
	if(alarmSocket){
		let socketMsg = "chat,"+sessionId+","+receiverNick+","+message+","+0;
		alarmSocket.send(socketMsg);
	}
}

//채팅창에서 나갔을 때
function onClose() {
	var user = '${user.userNickname}';
	var str = user + " 님이 퇴장하셨습니다.";
	$("#chatMessageArea").append(str);
	window.location.reload();
}

// 채팅방 나가기
function onOut(){
	
	const chatContext = {
			"userCode" : userCode,
			"chatRoomCode":chatRoomCode,
			"chatMessage":"chatRoomOut"
	};
	sock.send(JSON.stringify(chatContext));
	window.location.reload();
	
}

function viewCheckOut(){
	$('#checkOut').css({"display":"flex"});
}
</script>
</body>
</html>