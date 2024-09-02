<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
	padding: 10px 20px;
	font-family: 'GangwonEdu_OTFBoldA';
}
#contentTop {
	height: 8%;
    border-bottom: 1px solid gray;
    display: flex;
    justify-content: space-between;
    
}
#contentCenter{
	padding: 15px 0 10px 0;
	border-bottom:1px dashed gray;
	display: flex;
	justify-content: space-between;
	
	span{
		font-size:1.5rem;
	}
	
	#contentFiles{
		display: flex;
    	flex-direction: column;
    	i{
			font-size:0.8rem;
		}
		a{
			font-family: 'SDMiSaeng';
			font-size:1rem;
		}
	}
	
}
#contentBottom{
	padding: 15px 0 10px 0;
	
	height: 65%;
	span{
		font-size:1rem;
	}
	
}
#noteBtn{
	display:flex;
	align-items:center;
	width: 100%;
    justify-content: center;
    
    button{
    	font-family: 'SDMiSaeng';
		font-size:1rem;
		margin : 0 5px;
		border:none;
		background-color : black;
		color :white;
		border-radius: 5px;
        width: 50px;
        height: 25px;
		
    }
    button:hover{
    	cursor:pointer;
    	color : black;
    	background-color:white;
    	border : 1px solid black;
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
		<h3>쪽지 확인</h3>
		<div id="containerContent">
			<div id="contentTop">
				<span>보낸 사람 : ${vo.senderNick}</span>
				<span>받는 사람 : ${vo.receiverNick}</span>
				<span>작성일 : <fmt:formatDate value="${vo.noteWritedate}" pattern="yy-MM-dd HH:mm"/></span>
			</div>
			<div id="contentCenter">
				<span>${vo.noteTitle }</span>
				<div id="contentFiles">
					<c:forEach items="${files}" var="file" >
						<a href="/recoaImg/note/${file.noteFileUrl}" download>
		                <i class="fa-solid fa-file-arrow-down"> </i>
		                첨부 파일 다운로드
		              </a>
					</c:forEach>
				</div>
			</div>
			<div id="contentBottom">
				<span>${vo.noteContent}</span>
			</div>
			<div id="noteBtn">
				<button>답장</button>
				<button type="button" onclick="location.href='/deleteNote?noteCode=${vo.noteCode}'">삭제</button>
				<button type="button"  onclick="history.back()">목록</button>
			</div>
		</div>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</body>
</html>