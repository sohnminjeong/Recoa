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
#noteSideBar{
	width: 80px;
    height: 35px;
    border: 1px solid black;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin-left: 7px;
	font-family: 'SDMiSaeng';
	font-size : 1rem;
	span:hover{
		color : black;
		cursor: pointer;
	}
}

#noteWrite{
	width: 50%;
    height: 60%;
    border: 1px solid black;
    border-radius: 10px;
    
    position: fixed;
    margin: 0 auto;
    left:26%;
    top: 0px;
    bottom: 0;
    margin-top: auto;
    margin-bottom: auto;
    
    box-shadow: rgba(0, 0, 0, 0.5) 0 0 0 9999px;
    background-color: black;
    color: white;
    padding: 10px;
    font-family: 'SDMiSaeng';
}
#noteWriteInner{
	display: flex;
    flex-direction: column;
    height: 100%;
    h3{
    	height: 15%;
        font-size: 1.4rem;
        align-content: center;
        border-bottom: 1px dashed white;
        width: 30%;
    }
    form{
    	height: 85%;
        display: flex;
        flex-direction: column;
        
        
        #person{
        	display: flex;
            justify-content: space-around;
            height: 15%;
            align-items: center;
            font-family: 'SDMiSaeng';
    		font-size: 1rem;
    		
    		input{
    			font-family: 'SDMiSaeng';
    			font-size: 1.2rem;
    		}
        }
        #innerContents{
        	height: 70%;
		    display: flex;
		    flex-direction: column;
		   	font-family: 'SDMiSaeng';
		   
		    #noteTitle{
		    	height: 15%;
   				 margin-bottom: 10px;
   				 font-family: 'SDMiSaeng';
                font-size: 1.3rem;
		    }
		    #noteContent{
		    	height: 75%;
    			margin-bottom: 10px;
    			font-family: 'SDMiSaeng';
                font-size: 1.4rem;
		    }
		    #noteFile{
		    	margin-bottom:10px;
		    	font-family: 'SDMiSaeng';
                font-size: 0.8rem;
		    }
        }
        #innerBtn{
        	height: 15%;
		    display: flex;
		    justify-content: center;
		    
		    button{
		    	height: 75%;
    			margin: 0 5px;
    			font-family: 'SDMiSaeng';
   				font-size: 1rem;
   				width: 55px;
                border: 1px solid white;
                border-radius: 5px;
		    }
		    button:hover{
		    	cursor:pointer;
		    	color : black;
		    	background-color:white;
		    	border : 1px solid black;
		    }
        }
        
    }
}
.noteWriteInnerNo{
	display: flex;
    flex-direction: column;
    justify-content:center;
    height: 100%;
    span{
    	font-family: 'SDMiSaeng';
    	font-size: 1.2rem;
    	text-align: center;
        margin-bottom: 30px;
    }
    div{
    	display:flex;
    	justify-content: center;
    	button{
    		height: 75%;
   			margin: 0 5px;
   			font-family: 'SDMiSaeng';
  			font-size: 1.2rem;
            padding-bottom: 5px;
    	}
    }
}


#nowChatting{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    left: 3%;
   	width: 15%;
    height: 50%;
    border-radius:5px;
}


</style>
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
$('#noteBtn').click(function(){
	$('#noteWrite').css({"display":"block"});
})

const file = document.querySelector('#noteFile');
function fileRegi(event){
	if(event.target.files.length>=4){
		alert("최대 파일 첨부 갯수는 3개입니다.");
		$("#noteFile").val("");
	}
}

const receiverCode = <%=param3%>;
const senderCode = ${user.userCode};
$('#chatBtn').click(function(){
	
	$.ajax({
		type:"post",
		url:"/insertChatRoom",
		data : {"userNumber1":senderCode, "userNumber2":receiverCode},
		
		success:function(result){
			$('.nowChatting').css({"display":"block"});
			$('.nowChatting').load("/chat?chatRoomCode="+result);
			
		}
	})
	
})
$('#registerNoteBtn').click(function(){
	$.ajax({
		type:"post",
		url:"/registerNote",
		data:$("#registerNote").serialize(),
		
		success:function(result){
			if(socket){
    			let socketMsg = "note,"+result.senderNick+","+result.receiverNick+","+result.noteTitle+","+result.noteCode;
    			socket.send(socketMsg);
       		}
			
			location.replace('/viewAllNote?userCode=${user.userCode}');
		}
	})
})
</script>
</body>
</html>