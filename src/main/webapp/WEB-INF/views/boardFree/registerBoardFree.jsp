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
	margin:0 50px;
	display:flex;
	justify-content:center;
	align-items:center;
}
#content #container{
	display:flex;
	flex-direction:column;
	align-items:center;
	height:80%;
	width:60%;
	padding : 20px;
}
#container h3{
	margin: 20px 0;
    font-size: 2rem;
    font-family: 'GangwonEdu_OTFBoldA';
}
#container form{
	display:flex;
	flex-direction:column;
	border:1px solid black;
	height:100%;
	width:80%;
	border-radius:10px;
}
form div#data{
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 80%;
    margin-top: 25px;
    
}
form div #freeTitle{
	width:75%;
	height:15%;
	font-family: 'SDMiSaeng';
	 font-size:1.5rem;

}
form div #freeContent{
	width:75%;
	height:70%;
	margin: 18px 0;
	 font-family: 'SDMiSaeng';
	 font-size:1.5rem;
	 resize:none;
	 overflow-y:scroll;
}
form div #file{
	width:75%;
}
form div.btn{
	height: 20%;
    display: flex;
    justify-content: center;
    align-items: center;
}
#addImg{
height: 20%;
    display: flex;
    justify-content: center;
    align-items: center;
}
#addImg button{
	 font-family: 'GangwonEdu_OTFBoldA';
}
.btn button{	
	margin : 0 10px;
	  font-family: 'GangwonEdu_OTFBoldA';

}
img{
	width:100px;
	height:100px;
	margin : 10px;
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
		<input type="hidden" value="${user.userCode}" name="userCode">
			<div id="data">
				<input type="text" placeholder="제목" name="freeTitle" id="freeTitle">
				<textarea placeholder="내용" name="freeContent" id="freeContent"></textarea>
				<input type="file" name="file" multiple="multiple" id="file" style="display: none;" onchange="imgShow(event)">
				<div id="addImg">
				<button type="button" id="selectImg">이미지 첨부</button>
				<button type="button" id="delImg" style="display:none">이미지 삭제</button>
				</div>
				<div id="createImg"></div>
			</div>
			<div class="btn">
				<button>작성 완료</button>
				<button type="button" onclick="location.href='/boardFreeViewAll';">작성 취소</button>
			</div>
		</form>
	</div>
</div>
<script>
const selectImg = document.querySelector('#selectImg');
const file = document.querySelector('#file');
const delImg = document.querySelector("#delImg");
const createImg = document.querySelector("#createImg");

selectImg.addEventListener('click', ()=>file.click());

function imgShow(event){
	if(event.target.files.length>=4){
		alert("최대 이미지 첨부 갯수는 3개입니다.");
		return;
	}
	
	for(let i=0; i<event.target.files.length; i++){
		const reader = new  FileReader();
		reader.onload=function(event){
			const newImgs = document.createElement('img');
			newImgs.src = event.target.result;
			createImg.appendChild(newImgs);	
		};
		reader.readAsDataURL(event.target.files[i]);
	}
	selectImg.style.display="none";
	createImg.style.display="block";
	delImg.style.display="block";
}


delImg.addEventListener('click', function(){
	file.value="";
	while ( createImg.hasChildNodes() )
	{
		createImg.removeChild( createImg.firstChild );       
	}  
	createImg.style.display="none";
	selectImg.style.display="block";
	delImg.style.display="none";
	
})
</script>
</body>
</html>