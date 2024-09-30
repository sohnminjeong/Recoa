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
<link rel="stylesheet" href="../../../resources/css/boardFree/registerBoardFree.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
	<div id="container">
		<h3>게시물 작성</h3>
		<form action="/registerBoardFree" method="post" enctype="multipart/form-data" onsubmit="return validate()">
		<input type="hidden" value="${user.userCode}" name="userCode">
			<div id="data">
				<input type="text" placeholder="제목" name="freeTitle" id="freeTitle" maxlength="29">
				<textarea placeholder="내용" name="freeContent" id="freeContent"></textarea>
				<input type="file" name="file" multiple="multiple" id="file" style="display: none;" onchange="imgShow(event)">
				<div id="addImg">
				<button type="button" id="selectImg">이미지 첨부</button>
				<button type="button" id="delImg" style="display:none">이미지 삭제</button>
				</div>
				<div id="createImg"></div>
			</div>
			<div class="btn">
				<button type="submit">작성 완료</button>
				<button type="button" onclick="location.href='/viewAllBoardFree';">작성 취소</button>
			</div>
		</form>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
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

function validate(){
	
	if(freeTitle.value==''){
		freeTitle.focus();
		return false;
	} 
	alert("작성 완료되었습니다.");
	return true;
}
</script>
</body>
</html>