<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%String param1=request.getParameter("param1"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<style>
#noteSideBar{
	width: 80px;
    height: 35px;
    border: 1px solid black;
    border-radius: 10px;
    align-content: center;
    text-align: center;
    font-size: 0.8rem;
    margin-left: 7px;
	
	span:hover{
		color : black;
	}
}

#noteWrite{
	width:400px;
	height:250px;
	border : 1px solid black;
	border-radius:10px;
	position:fixed;
	left:35%;
	box-shadow : rgba(0,0,0,0.5) 0 0 0 9999px;
	background-color : black;
	color : white;
	padding : 10px;
	display:flex;
	flex-direction:column;
}

</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="noteSideBar">
		<span id="noteBtn">쪽지 보내기</span><br>
		<span>채팅 하기</span>
	</div>
	<div id="noteWrite" style="display:none">
		<h3>쪽지 보내기</h3>
		<form action="/registerNote" method="post" enctype="multipart/form-data">
		<div>
			<span>보내는 사람</span>
			<input type="text" id="senderNick" name="senderNick" value="${user.userNickname}">
		</div>
		<div>
			<span>받는 사람</span>
			<input type="text" id="receiverNick" name="receiverNick" value="<%=param1%>">
		</div>
		
		<input type="text" id="noteTitle" name="noteTitle" placeholder="제목"> 
		<textarea placeholder="내용" name="noteContent" id="noteContent"></textarea>
		<input type="file" id="file" name="file" multiple="multiple" >
		<button>쪽지 보내기</button>
		</form>
	</div>
	<script>
	$('#noteBtn').click(function(){
		$('#noteWrite').css({"display":"block"});
	})
	</script>
</body>
</html>