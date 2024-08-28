<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	width:100px;
	height:100px;
	border:1px solid black;
	
}
#noteWrite{
	width:200px;
	height:200px;
	border : 1px solid black;
	border-radius:10px;
}
</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="noteSideBar">
		<span id="noteBtn">쪽지 보내기</span>
		<span>채팅 하기</span>
	</div>
	<div id="noteWrite" style="display:none">
		<h3>쪽지 보내기</h3>
		<form action="/registerNote" method="post" enctype="multipart/form-data">
		<input type="text" id="noteSender" name="noteSender" value="${user.userNickname}">
		<input type="text" id="noteReceiver" name="noteReceiver" value="${user.userNickname}">
		
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