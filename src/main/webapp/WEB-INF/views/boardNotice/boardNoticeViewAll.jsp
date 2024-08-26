<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<style>
#header {
    position: absolute;
    z-index: 1;
    width: 100%;
    top: 0;
    left: 0;
    border-bottom:1px solid black;
}
#content{
	position:relative;
	z-index:0;
	height:100vh;
	padding-top:10vh;
	margin:0 50px;
}
#container{
	margin-top: 10px;
}
</style>
</head>
<body>
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
	<div id="container">
		<h3>공지 게시판</h3>
		<a href="/registerNotice">공지 작성</a>
	</div>
</div>
</body>
</html>