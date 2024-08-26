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
	#header{
		position:absolute;
		z-index:1;
		width:100%;
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
	#content>#userSideBar{
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
	#container>form{
		width:90%;
		border : 2px solid black;
		border-radius : 30px;
		height:100%;
		 display: flex;
	    align-items: center;
	    padding: 40px 0px;
	    justify-content: center;
	   
	}

	form input{
		width : 200px;
		height:40px;
		border-radius:7px;
		font-family: 'GangwonEdu_OTFBoldA';
		font-size : 1.1rem;
		margin-bottom:5px;
	}
	#left, #right{
		width: 100%;
	    height: 100%;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    justify-content: space-around;
	}
	#left div, #right div{
		display: flex;
	    flex-direction: column;
	    width: 100%;
	    align-items: center;
	}
	form span{
		font-family: 'GangwonEdu_OTFBoldA';
		font-size : 1.1rem;
	}
	div#btn{
		margin-top:25px;
		width:300px;
		display:flex;
		flex-direction:row;
		justify-content:space-evenly;
	}
	button{
		font-size : 1rem;
		font-family: 'GangwonEdu_OTFBoldA';
		border-radius:10px;
		padding-top:6px;
		border:none;
		width:105px; 
		height:35px;
		cursor:pointer;
		
	}
	button:hover{
		border : 1px solid black;
	}
	#pwdCheck{
		display:flex;
		flex-direction:column;
		justify-content : space-evenly;
		height:70%;
	}
	#afterPwdCheck{
		display:none;
		height:100%;
		width:100%;
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
	<div id="userSideBar">
		<%@ include file="../user/userSideBar.jsp" %>
	</div>
	<div id="container">
		<h3>내 정보 설정</h3>
		<form action="/updateUser" method="post"  enctype="multipart/form-data" onsubmit="return validate()">
			<div id="pwdCheck">
				<span>[정보 수정 위한 비밀번호 확인]</span>
				<input type="hidden" name="userId" id="userId" value="${user.userId}">
				<input type="password" name="userPwd" id="userPwd" placeholder="비밀번호 입력">
				<button type="button" id="pwdCheckBtn">비밀번호 확인</button>
			</div>
			<div id="afterPwdCheck">
				<div id="left">
					<div>
						<span>이름</span> 
						<input type="text" name="userRealName" id="userRealName" value="${user.userRealName}">	
						<span id="realNameCheck"></span>
					</div>
					<div>
						<span>핸드폰번호</span> 
						<input type="text" name="userPhone" id="userPhone" value="${user.userPhone}">
						<span id="userPhoneCheck"></span>
					</div>
					
					<div>
						<span>이메일</span> 
						<input type="text" name="userEmail" id="userEmail" value="${user.userEmail}">
						<span id="emailCheck"></span>
					</div>
				</div>
				<div id="right">
					<div>
						<span>거주동</span>  
						<input type="text" name="userAdr" id="userAdr" value="${user.userAdr}">
						<span id="userAdrCheck"></span>
					</div>
		
					<div>
						<span>거주호수</span>  
						<input type="text" name="userAdrDetail" id="userAdrDetail" value="${user.userAdrDetail}">
						 <span id="userAdrDetailCheck"></span>
					</div>
					<div id="btn">
						<button type="submit">정보 변경 완료</button>
						<button type="button" onclick="location.href='/myPageUser';">정보 변경 취소</button>
					</div>
				</div>	
			</div>
		</form>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script>
let PwdCheck = false;
//정보 변경 위한 기존 비밀번호 확인 			
$('#pwdCheckBtn').click(() => {
	const userPwd = $('#userPwd').val();
	const userId = $('#userId').val();
	
	$.ajax({
		type: "post",
		url: "/selectUserPwd",
		data: {"userId":userId, "userPwd":userPwd},

		success: function (result) {
			if (result) {
				// 비밀번호 일치하지 않는 경우 
				alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				location.replace("/myPageUser");
				pwdCheck = true;
			} else {
				// 비밀번호 일치한 경우
				$('#pwdCheck').css({'display':'none'});
				$('#afterPwdCheck').css({'display':'flex'});
				pwdCheck = false;
			}
		}
	})
})

let nameCheck = false;
let userPhoneCheck = false;
let userPhoneDupCheck=false;
let adrCheck = false;
let adrDetailCheck = false;
let emailDupCheck = false;
let emailCheck = false;

//이름 정규표현식
$('#userRealName').keyup((e) => {
	let userRealName = $('#userRealName').val();
	
	const regExp = /^[가-힣]{2,}$/;
	
	if(regExp.test(userRealName) || userRealName === ""){
		$('#realNameCheck').text("").css("color", "gray");
		nameCheck = false;
	} else {
		$('#realNameCheck').text("한글로만 이루어진 2글자 이상의 이름을 입력하세요.").css("color", "gray");
		nameCheck = true;
	}
});
//핸드폰번호 정규표현식
$('#userPhone').keyup((e) =>{
	let userPhone=$(e.target).val(); 
	const regExp = /^01([0,1])-?([0-9]{3,4})-?([0-9]{4})$/;
	if(regExp.test(userPhone)){
		$('#userPhoneCheck').text("").css("color", "gray");
		userPhoneCheck = false;
	} else {
		$('#userPhoneCheck').text("하이픈(-) 포함하여 작성해주세요").css("color", "gray");
		userPhoneCheck = true;
	}
});

// 핸드폰번호 중복확인
$('#userPhone').keyup(() => {
	const userPhone = $('#userPhone').val();
	$.ajax({
		type: "post",
		url: "/phoneCheck",
		data: "userPhone=" + userPhone,

		success: function (result) {
			if (result) {
				$('#userPhoneCheck').text("중복된 핸드폰번호입니다").css("color", "gray");
				userPhoneDupCheck = true;
			} else if(!result&&!userPhoneCheck) {
				$('#userPhoneCheck').text("").css("color", "gray");
				userPhoneDupCheck = false;
			}
		}
	})
})

// 거주 동 정규표현식
$('#userAdr').keyup((e) =>{
	let userAdr=$(e.target).val(); 
	const regExp = /^(10[1-9]|110|20[1-9]|210|30[1-9]|310)$/;
	if(regExp.test(userAdr)){
		$('#userAdrCheck').text("").css("color", "gray");
		adrCheck = false;
	} else {
		$('#userAdrCheck').text("거주하고 있는 동의 숫자만 작성해주세요.").css("color", "gray");
		adrCheck = true;
	}
});


// 거주 호수 정규표현식
$('#userAdrDetail').keyup((e) =>{
	let userAdrDetail=$(e.target).val(); 
	const regExp = /^(0?[1-9]|1[0-9]|2[0-5])0[1-4]$/;
	if(regExp.test(userAdrDetail)){
		$('#userAdrDetailCheck').text("").css("color", "gray");
		adrDetailCheck = false;
	} else {
		$('#userAdrDetailCheck').text("거주하고 있는 호수의 숫자만 작성해주세요.").css("color", "gray");
		adrDetailCheck = true;
	}
});

// 이메일 정규표현식
$('#userEmail').keyup((e) =>{
	let userEmail=$(e.target).val(); 
	const regExp = /^\w+@\w+\.\w+$/;
	if(regExp.test(userEmail)){
		$('#emailCheck').text("").css("color", "gray");
		emailCheck = false;
	} else {
		$('#emailCheck').text("이메일 형식에 맞춰서 입력하세요.").css("color", "gray");
		emailCheck = true;
	}
});

// 이메일 중복확인
$('#userEmail').keyup(() => {
	const userEmail = $('#userEmail').val();
	$.ajax({
		type: "post",
		url: "/emailCheck",
		data: "userEmail=" + userEmail,

		success: function (result) {
			if (result) {
				$('#emailCheck').text("중복된 이메일입니다").css("color", "gray");
				emailDupCheck = true;
			} else if(!result&&!emailCheck) {
				$('#emailCheck').text("").css("color", "gray");
				emailDupCheck = false;
			}
		}
	})
})

function validate(){

	if(nameCheck){
		userRealName.focus();
		return false;
	}else if(userRealName.value==''){
		userRealName.focus();
		return false;
	}else if(userPhone.value==''){
		userPhone.focus();
		return false;
	}else if(userPhoneCheck){
		userPhone.focus();
		return false;
	}else if(userPhoneDupCheck){
		userPhone.focus();
		return false;
	}else if(userAdr.value==''){
		userAdr.focus();
		return false;
	}else if(adrCheck){
		userAdr.focus();
		return false;
	}else if(userAdrDetail.value==''){
		userAdrDetail.focus();
		return false;
	}else if(adrDetailCheck){
		userAdrDetail.focus();
		return false;
	}else if(emailCheck){
		userEmail.focus();
		return false;
	}else if(emailDupCheck){
		userEmail.focus();
		return false;
	}else if(userEmail.value==''){
		userEmail.focus();
		return false;
	}
	 alert("정보 변경 완료하였습니다.");
	 return true; 
}

</script>
</body>
</html>