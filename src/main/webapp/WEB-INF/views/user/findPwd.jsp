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
		display:flex;
		flex-direction:column;
	}
	#resultBox div{
		margin-top : 20px;
	}
	#px{
		font-size:0.8rem;
		color:red;
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
					<form action="findPwd" method="post" id="findPwdCheck" name="findPwdCheck">
						<div class="input-group">
							<input type="text" placeholder="아이디" name="userId" id="userId">
						</div>
						<div class="input-group">
							<input type="text" placeholder="이름" name="userRealName" id="userRealName">
						</div>
						<div class="input-group">
							<input type="email" placeholder="이메일" name="userEmail" id="userEmail">
						</div>
						<button type="button" id="findPwdBtn">비밀번호 찾기</button>
					</form>
					<!-- 아이디 찾기 결과 박스 -->
			        <div id="resultBox" style="display:none">
			        <span>[임시 비밀번호]</span>
			        <div>
			        	<span id="resultPwd"></span><br>
			        	<span id="px">*계정 보안을 위해 로그인하여 비밀번호를 변경해주세요.</span>
			        </div>
			        
			        
					</div>
					 <p>
					     <a href="/loginUser">로그인</a>
					     <a href="/findId">아이디 찾기</a>
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
const resultBox = document.getElementById('resultBox');
const findPwdCheck = document.getElementById('findPwdCheck');


$("#findPwdBtn").click(() => {
	
	$.ajax({
		type: "post",
		url: "/findPwd",
		data: $("#findPwdCheck").serialize(),

		success: function (result) {
			findPwdCheck.style.display="none";
			resultBox.style.display="block";
			if(result.message==""){
				$("#resultPwd").text("조회결과가 없습니다.").css("color", "black");
			} else{
				$("#resultPwd").text(result.message);
			}
				
		},
		error: function(){
		}
	})
})

</script>
</body>
</html>