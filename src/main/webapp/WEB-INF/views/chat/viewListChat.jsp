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
	display:flex;
	
	#chatList{
		width:40%;
		display: grid;
	    grid-template-rows: repeat(10, 1fr);
	    overflow-y: scroll;
	    padding: 10px;
	    
	    .chat{
	    	display:flex;
	    	flex-direction:column;
	    	
	    	border-bottom : 0.5px dashed black;
	    	border-top : 0.5px dashed black;
	    	padding : 5px 0;
	    	font-family: 'GangwonEdu_OTFBoldA';
	    	
	    	#chat_interlocutor{
		    	display:flex;
		    	align-items:center;
		    	height:50%;
		    	
		    	img{
		    		border-radius:50%;
		    		width:20px;
		    		height:20px;
		    		margin-right:10px;
		    		border:0.5px solid black;
		    	}
		    	
		    }
		    #chat_content{
		    	height:50%;
		    	display:flex;
		    	justify-content:space-between;
		    	  font-family: 'SDMiSaeng';
		    	  font-size:1.2rem;
		    	  margin : 5px 10px 0 35px;
		    	  
		    	  #chatTime{
		    	  	font-size:1rem;
		    	  }
		    }
	    	
	    }
	    .chat:hover{
	    	cursor : pointer;
	    }
	}
	#chatBox{
		width:60%;
	}
	
}
#userFloating{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    right: 4%;
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
		<h3>채팅방 목록</h3>
		<div id="containerContent">
			<!-- 채팅방 리스트 -->
			<div id="chatList">
				<c:forEach items="${chatList}" var="chat">
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
						<div id="chat_content">
							<div>${chat.chatMessage}</div>
							<div  id="chatTime"> 
								<fmt:formatDate value="${chat.chatTime}" pattern="yy-MM-dd HH:mm"/>
							</div>
						</div>	
						
					</div>
				</c:forEach>
			</div>
			
			
			
			<!-- 채팅방 클릭 시 채팅 창 열릴 공간 -->
			<div id="chatBox">
			
			</div>
		</div>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</body>
</html>