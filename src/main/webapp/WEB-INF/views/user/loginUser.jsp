<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/user/loginUser.css" />
</head>
<body>
<div id="container" class="container">
    <!-- FORM SECTION -->
    <div class="row">
      <!-- SIGN UP -->
      <div class="col align-items-center flex-col sign-up">
        <div class="form-wrapper align-items-center">
          <div class="form sign-up">
          	<form action="/registerUser" method="post"enctype="multipart/form-data">
	            <div class="input-group">
	              <i class='bx bxs-user'></i>
	              <input type="text" placeholder="아이디" name="userId">
	            </div>
	            <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <input type="password" placeholder="비밀번호" name="userPwd">
	            </div>
	            <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <input type="text" placeholder="이름" name="userRealName">
	            </div>
	            <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <input type="text" placeholder="닉네임" name="userNickname">
	            </div>
	            <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <!--  <img src="resources/images/user/default_profile.png"/> -->
	             
	              
	              <input type="file" name="file" id="userImgUrl">
	            </div>
	            <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <input type="text" placeholder="핸드폰번호" name="userPhone">
	            </div>
	            <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <input type="text" placeholder="거주 동" name="userAdr">
	            </div>
	            <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <input type="text" placeholder="거주 호수" name="userAdrDetail">
	            </div>
	            <div class="input-group">
	              <i class='bx bx-mail-send'></i>
	              <input type="email" placeholder="이메일" name="userEmail">
	            </div>     
	           <!--  
	           <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <input type="password" placeholder="Confirm password">
	            </div>
	           -->
	            <button>
	              회원가입
	            </button>
            </form>
            <p>
              <span>
                회원일 경우 > 
                <!-- Already have an account? -->
              </span>
              <b onclick="toggle()" class="pointer">
                <!-- Sign in here -->
                로그인
              </b>
            </p>
          </div>
        </div>
      
      </div>
      <!-- END SIGN UP -->
      <!-- SIGN IN -->
      <div class="col align-items-center flex-col sign-in">
        <div class="form-wrapper align-items-center">
	      <div class="form sign-in">
		     <form action="login" method="post">
	            <div class="input-group">
	              <i class='bx bxs-user'></i>
	              <input type="text" placeholder="아이디" name="username" id="userId">
	            </div>
	            <div class="input-group">
	              <i class='bx bxs-lock-alt'></i>
	              <input type="password" placeholder="비밀번호" name="password" id="userPwd">
	            </div>
	            <button>
	              로그인
	            </button>
	            </form>
	            <p>
	              <b>
	                Forgot password?
	              </b>
	            </p>
	            <p>
	              <span>
	                <!-- Don't have an account? -->
	                비회원일 경우 > 
	              </span>
	              <b onclick="toggle()" class="pointer">
	                <!-- Sign up here -->
	                회원가입
	              </b>
	            </p>
	          </div>
          
        </div>
        <div class="form-wrapper">
    
        </div>
      </div>
      <!-- END SIGN IN -->
    </div>
    <!-- END FORM SECTION -->
    <!-- CONTENT SECTION -->
    <div class="row content-row">
      <!-- SIGN IN CONTENT -->
      <div class="col align-items-center flex-col">
        <div class="text sign-in">
          <h2>
            Welcome
          </h2>
  
        </div>
        <div class="img sign-in">
    
        </div>
      </div>
      <!-- END SIGN IN CONTENT -->
      <!-- SIGN UP CONTENT -->
      <div class="col align-items-center flex-col">
        <div class="img sign-up">
        
        </div>
        <div class="text sign-up">
          <h2>
            Join with us
          </h2>
  
        </div>
      </div>
    </div>
  </div>

	<script src="../../../resources/js/user/loginUser.js"></script>
</body>
</html>