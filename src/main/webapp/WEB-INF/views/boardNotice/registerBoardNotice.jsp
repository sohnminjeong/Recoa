<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../resources/css/reset.css" />
<title>Insert title here</title>
<link href="../../resources/css/boardNotice/registerNotice.css" rel="stylesheet" type="text/css">
<style>
#header {
    position: absolute;
    z-index: 1;
    width: 100%;
    top: 0;
    left: 0;
}
#content{
	position:relative;
	z-index:0;
	height:100vh;
	padding-top:10vh;
	margin:0 50px;
	display:flex;
	align-items:center;
	justify-content: center;
}

</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
	
	<div id="content">
		<form action="registerNotice" method="post" id="registerNotice" name="registerNotice">
			<div id="input">
				<input type="text" name="noticeTitle" id="noticeTitle" placeholder="제목">
				<textarea name="noticeContent" id="noticeContent" placeholder="내용"></textarea>
			</div>
			<input type="hidden" name="userCode" value="${user.userCode}" readonly/>
			<input type="submit" value="등록하기" id="submit">
		</form>	
	</div>
</body>
</html>