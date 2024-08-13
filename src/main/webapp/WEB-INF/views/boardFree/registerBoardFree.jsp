<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<style>
@font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
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
	margin:0 50px;
	display:flex;
	justify-content:center;
	align-items:center;
}
#content #container{
	border:1px solid black;
	height:70%;
}
</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
	<div id="container">
		<h3>게시물 작성</h3>
		<form action="/registerBoardFree" method="post" enctype="multipart/form-data">
		
			<input type="text" value="${user.userCode}" placeholder="${user.userCode}" name="userCode">
			
			<input type="text" placeholder="글 제목" name="freeTitle" id="freeTitle">
			<input type="text" placeholder="글 내용" name="freeContent" id="freeContent">
			<input type="file" name="file" multiple="multiple">
			<button>글 작성 완료</button>
		</form>
	</div>
</div>
</body>
</html>