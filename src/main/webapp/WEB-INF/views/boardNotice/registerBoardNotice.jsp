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
	flex-direction: column;
	align-items:center;
	justify-content: center;
}

h1{
	font-size: 2rem;
	
}
</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
	
	<div id="content">
		<h1>공지 작성</h1>
		<form action="/registerNotice" method="post" enctype="multipart/form-data" onsubmit="return validate()">
			<div id="input">
				<input type="text" name="noticeTitle" id="noticeTitle" placeholder="제목">
				<textarea name="noticeContent" id="noticeContent" placeholder="내용"></textarea>
			</div>
			<input type="file" name="files" multiple="multiple" id="file" style="display: none;" onchange="setImage(event)"/>
			<input type="hidden" name="userCode" value="${user.userCode}" readonly/>
			
			<!-- 사진이 추가되지 않았을 경우 -->
			<div id="button-container">
				<button type="button" id="addImg">이미지 첨부</button>
				<button type="button" id="deleteImg" style="display:none;">이미지 삭제</button>
			</div>
			<!-- 미리보기 보일 곳 -->
			<div id="preview"></div>
			<div id="buttons">
				<button type="submit" id="submit">등록하기</button>
				<button type="button" onclick="location.href='/boardNoticeList';">작성 취소</button>
			</div>
		</form>
	</div>
	<script>
	
	// 이미지 첨부하기 클릭 시 input file로 넘어가도록
	const addImg = document.querySelector("#addImg");
	const file = document.querySelector("#file");
	addImg.addEventListener('click', ()=> file.click());
	
	const deleteImg = document.querySelector("#deleteImg");
	
	// 이미지 미리보기
	const preview = document.querySelector("#preview");
	
	function setImage(event){
		
		// 3개까지 제한
		if(event.target.files.length >= 4){
			alert("최대 이미지 첨부 갯수는 3개입니다.");
			return;
		}
		
		// 미리보기에 src
		for(let i=0; i<event.target.files.length; i++){
			const reader = new FileReader();
			reader.onload = function(event){
				const newImgs = document.createElement('img');
				newImgs.src = event.target.result;
				preview.appendChild(newImgs);
			};
			reader.readAsDataURL(event.target.files[i]);
		}
		
	    addImg.style.display = "none"; 
	    deleteImg.style.display = "block"; 
	    preview.style.display = "block"; 
	}
	
	// 이미지 삭제
	deleteImg.addEventListener('click', function(){
		file.value="";
		while(preview.hasChildNodes()){
			preview.removeChild(preview.firstChild);
		}
		preview.style.display = "block";
	    addImg.style.display = "block";
	    deleteImg.style.display = "none";
	})
	
	// 제출 전 폼 유효 확인
	function validate(){
		if(noticeTitle.value==''){
			noticeTitle.focus();
			return false;
		} else if(noticeContent.value==''){
			noticeContent.focus();
			return false;
		}
		return true;
	}
	</script>
</body>
</html>