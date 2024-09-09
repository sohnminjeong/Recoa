<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<link href="../../resources/css/boardNotice/updateNotice.css" rel="stylesheet" type="text/css">

</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="header">
	<%@ include file="../main/header.jsp" %>
	</div>
	
	<div id="content">
		<h1>공지 수정</h1>
		<form action="/updateBoardNotice" method="post" enctype="multipart/form-data" onsubmit="return validate()">
			<input type="hidden" name="delImages" id="delImages" value="false"/>
			<div id="input">
				<input type="text" name="noticeTitle" id="noticeTitle" value="${notice.noticeTitle}" placeholder="제목">
				<textarea name="noticeContent" id="noticeContent"  placeholder="내용">${notice.noticeContent}</textarea>
			</div>
			<input type="file" name="files" multiple="multiple" id="file" style="display: none;" onchange="setImage(event)"/>
			<input type="hidden" name="userCode" value="${user.userCode}" readonly/>
			<input type="hidden" name="noticeCode" value="${notice.noticeCode}" readonly/>
			
			<div id="button-container">
				 <div id="images">
			        <c:if test="${images != null}">
			            <c:forEach items="${images}" var="img" varStatus="status">
			                <img src="/recoaImg/boardNotice/${img.noticeImgUrl}"/>
			            </c:forEach>
			        </c:if>
			    </div>
			        <div id="preview"></div>
			    <div id="imgButtons">
			        <button type="button" id="addImg">이미지 추가</button>
			        <button type="button" id="deleteImg" style="display: none;">이미지 삭제</button> <!-- Always in DOM -->
    			</div> 	
			</div>
			
			<div id="buttons">
				<button type="submit" id="submit">수정하기</button>
				<button type="button" onclick="location.href='/viewNotice?noticeCode=${notice.noticeCode}'">수정 취소</button>
			</div>
		</form>
	</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script>
	const addImg = document.querySelector("#addImg");
	const file = document.querySelector("#file");
	
	const deleteImg = document.querySelector("#deleteImg");
	const preview = document.querySelector("#preview");
	
	const prev = document.querySelector("#images");
	addImg.addEventListener('click', ()=> file.click());
	
	// 이미지 삭제
	deleteImg.addEventListener('click', function(){
		document.querySelector("#delImages").value = "true";
		
		if(prev){
			prev.innerHTML = "";
		}
		
		preview.innerHTML = "";
		
		file.value="";
		
		preview.style.display = "block";
		prev.style.display="none";
		
	    addImg.style.display = "block";
	    deleteImg.style.display = "none";
	})
	
	// 기존 이미지가 있는 경우 삭제 시 미리보기에서 반영하기
	window.addEventListener('load', () => {
		if(prev && prev.querySelectorAll('img').length > 0){
			deleteImg.style.display="block";
		} else{
			deleteImg.style.display="none";
		}
	})
	
	function setImage(event){
		
		preview.innerHTML = "";
		
		const prevCount = prev ? prev.querySelectorAll('img').length : 0; 
		console.log("이전 개수 : " + prevCount);
		
		const newCount = event.target.files.length;
		console.log("추가 개수 : " + newCount);
		
		// 3개까지 제한
		if(prevCount + newCount >= 4){
			alert("최대 이미지 첨부 갯수는 3개입니다.");
			return;
		}
		
		// 미리보기에 이미지 담기
		for(let i=0; i < newCount; i++){
			const reader = new FileReader();
			reader.onload = function(event){
				const newImgs = document.createElement('img');
				newImgs.src = event.target.result;
				preview.appendChild(newImgs);
			};
			reader.readAsDataURL(event.target.files[i]);
		}
		
		if(newCount > 0){
			console.log("파일 추가해여");
			console.log(event.target.value);
			console.log(preview.style.display);
			
			preview.style.display="block";
			console.log(preview.style.display);
			addImg.style.display="block";
			deleteImg.style.display="block";
		}
		
	}
	
	
	
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