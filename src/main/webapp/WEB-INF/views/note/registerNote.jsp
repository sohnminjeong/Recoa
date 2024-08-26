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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	#noteWrite{
		width:50%;
		height:50%;
		border:1px solid black;
		border-radius:10px;
	}
</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="noteWrite">
		<h3>쪽지 보내기</h3>
		<form action="/registerNote" method="post" enctype="multipart/form-data">
		
		</form>
	</div>
	
</body>
</html>