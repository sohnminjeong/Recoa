<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
@font-face {
    font-family: 'SDMiSaeng';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SDMiSaeng.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
#header {
    position: absolute;
    z-index: 1;
    width: 100%;
    border-bottom:1px solid black;
}
#content{
	position:relative;
	z-index:0;
	height:100vh;
	padding-top:10vh;
	margin:0 50px;
	h3{
		font-family: 'GangwonEdu_OTFBoldA';
		font-size:1.4rem;
	}
}
#container{
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
	height: 100%;
	padding-top: 5%;
}
#topBar{
	width: 70%;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	height: 5%;
	border-bottom: 1px dashed black;
	padding-bottom: 15px;
	margin-bottom: 10px;
	
	button{
		border-radius:3px;
		border:none;
		font-family: 'SDMiSaeng';
		font-size:1rem;
	}
	
	button:hover{
		background-color: black;
		color: white;
		cursor: pointer;
	}
}

#desc{
	width: 70%;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	#writer{
		display: flex;
		
		img{
			width: 30px;
			height: 30px;
			border-radius: 50%;
			margin-right: 10px;
		}
		
	}
	#noticedesc{
		display: flex;
		flex-direction: row;
		background-color: pink;
	}
}
#noticeContent{
	margin-top: 30px;
	height: 200px;
	width: 70%;
	p{
		font-family: 'GangwonEdu_OTFBoldA';
		font-size: 1.3rem;
	}
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
	<div id="topBar">
		<h3>${notice.noticeTitle}</h3>
		<div id="buttons">
			<button type="button" onclick="location.href=''">수정</button>
			<button type="button" onclick="location.href='/deleteNotice?noticeCode=${notice.noticeCode}'">삭제</button>
			<button type="button" onclick="location.href='/boardNoticeList'">목록</button>
		</div>
	</div>
    <div id="desc">
    	<div id="writer">
    		<c:choose>
				<c:when test="${vo.user.userImgUrl==null}">
					<img src="resources/images/user/default_profile.png" class="userImg"/>
				</c:when>
				<c:otherwise>
					<img src="/recoaImg/user/${vo.user.userImgUrl}" class="userImg"/>
				</c:otherwise>
			</c:choose>
    		<div>
	    		<span id="writerAdr">관리자</span>
				<span id="writerNickname">${notice.user.userNickname}</span>
    		</div>
    	</div>
    	<div id="noticedesc">
    		<p>작성일: <fmt:formatDate value="${notice.noticeWritedate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
			<p>조회수</p>
			<p>북마크 수</p>
    	</div>
    </div>
    <div id="noticeContent">
    	<p>${notice.noticeContent}</p>
    </div>
    
    </div>
</div>
</body>
</html>