<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/reset.css" />
<link rel="stylesheet" href="../../../resources/css/user/loginUser.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	#header{
		position:absolute;
		z-index:1;
		width:100%;
	}
	#container{
		position:relative;
		z-index:0;
	}
	p a{
		margin : 0 10px;
		font-size: 0.8rem;
	}
	p span, b{
	font-size: 0.8rem;
	}
	p a:hover{
		color : gray;
	}
	p b:hover{
		color : gray;
	}
	.form-wrapper span{
		font-size: 1.2rem;
		 font-family: 'GangwonEdu_OTFBoldA';
	}
	#resultBox{
		margin: 20px 0;
	}
</style>
</head>
<body>
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div> 
<div id="container" class="container">
    <div class="row">
      <!-- 회원가입 -->
      <div class="col align-items-center flex-col sign-up" id="sign-up-head"></div>
      <!-- 로그인 -->
	     <div class="col align-items-center flex-col sign-in" id="sign-in-head">
	       <div class="form-wrapper align-items-center" >
		        <div class="form sign-in" id="findId">
					<form action="findId" method="post" id="findIdCheck" name="findIdCheck">
						<div class="input-group">
							<input type="text" placeholder="이름" name="userRealName" id="userRealName">
						</div>
						<div class="input-group">
							<input type="email" placeholder="이메일" name="userEmail" id="userEmail">
						</div>
						<button type="button" id="findIdBtn">아이디 찾기</button>
					</form>
					<!-- 아이디 찾기 결과 박스 -->
			        <div id="resultBox" style="display:none">
			        <span id="resultId"></span>
					</div>
					 <p>
					     <a href="/loginUser">로그인</a>
					     <a href="/findPwd">비밀번호 찾기</a>
				  	</p>
				</div>   
  
	       </div> 
	     </div> 
	
    </div>
	 <div class="row content-row">
	      <!-- 로그인 시 글자 -->
	      <div class="col align-items-center flex-col">
	        <div class="text sign-in">
	          <h2>
	            Welcome
	          </h2>
	        </div>
	        <div class="img sign-in"></div>    
	      </div>   
	    </div>
</div>
<script src="../../../resources/js/user/loginUser.js"></script>
<script>
const userRealName = document.getElementById('userRealName');
const userEmail = document.getElementById('userEmail');
const resultBox = document.getElementById('resultBox');
const findIdCheck = document.getElementById('findIdCheck');


$("#findIdBtn").click(() => {
	
	$.ajax({
		type: "post",
		url: "/findId",
		data: $("#findIdCheck").serialize(),

		success: function (result) {
			findIdCheck.style.display="none";
			resultBox.style.display="block";
			if(result.message==""){
				$("#resultId").text("조회결과가 없습니다.").css("color", "black");
			} else{
				$("#resultId").text(result.message);
			}
				
		},
		error: function(){
		}
	})
})

</script>
</body>
</html>