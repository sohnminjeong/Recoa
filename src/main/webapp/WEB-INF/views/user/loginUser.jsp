<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="/resources/css/reset.css" />
    <link rel="stylesheet" href="../../../resources/css/user/loginUser.css" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
      #header {
        position: absolute;
        z-index: 1;
        width: 100%;
      }
      #container {
        position: relative;
        z-index: 0;
      }
      p a {
        margin: 0 10px;
        font-size: 0.8rem;
      }
      p span,
      b {
        font-size: 0.8rem;
      }
      p a:hover {
        color: gray;
      }
      p b:hover {
        color: gray;
      }
    </style>
  </head>
  <body>
    <div id="header"><%@ include file="../main/header.jsp" %></div>
    <div id="container" class="container">
      <div class="row">
        <!-- 회원가입 -->
        <div class="col align-items-center flex-col sign-up" id="sign-up-head">
          <div class="form-wrapper align-items-center" id="sign-up-me">
            <div class="form sign-up" id="sign-up">
              <form
                action="/registerUser"
                method="post"
                id="registerUser"
                onsubmit="return validate()"
              >
                <div class="input-group">
                  <input
                    type="text"
                    placeholder="아이디"
                    name="userId"
                    id="userId"
                  />
                  <span id="idCheck"></span>
                </div>
                <div class="input-group">
                  <input
                    type="password"
                    placeholder="비밀번호"
                    name="userPwd"
                    id="userPwd"
                  />
                  <span id="pwdCheck"></span>
                </div>
                <div class="input-group">
                  <input
                    type="text"
                    placeholder="이름"
                    name="userRealName"
                    id="userRealName"
                  />
                  <span id="realNameCheck"></span>
                </div>
                <div class="input-group">
                  <input
                    type="text"
                    placeholder="닉네임"
                    name="userNickname"
                    id="userNickname"
                  />
                  <span id="nickNameCheck"></span>
                </div>

                <div class="input-group">
                  <input
                    type="text"
                    placeholder="핸드폰번호"
                    name="userPhone"
                    id="userPhone"
                  />
                  <span id="userPhoneCheck"></span>
                </div>
                <div class="input-group">
                  <input
                    type="text"
                    placeholder="거주 동"
                    name="userAdr"
                    id="userAdr"
                  />
                  <span id="userAdrCheck"></span>
                </div>
                <div class="input-group">
                  <input
                    type="text"
                    placeholder="거주 호수"
                    name="userAdrDetail"
                    id="userAdrDetail"
                  />
                  <span id="userAdrDetailCheck"></span>
                </div>
                <div class="input-group">
                  <input
                    type="email"
                    placeholder="이메일"
                    name="userEmail"
                    id="userEmail"
                  />
                  <span id="emailCheck"></span>
                </div>
                <button type="submit">회원가입</button>
              </form>
              <p>
                <span> 회원일 경우 > </span>
                <b onclick="toggle()" class="pointer"> 로그인 </b>
              </p>
            </div>
          </div>
        </div>

        <!-- 로그인 -->
        <div class="col align-items-center flex-col sign-in" id="sign-in-head">
          <div class="form-wrapper align-items-center">
            <!-- 로그인 폼 -->
            <div class="form sign-in" id="sign-in">
              <form action="login" method="post">
                <div class="input-group">
                  <input type="text" placeholder="아이디" name="username" />
                </div>
                <div class="input-group">
                  <input
                    type="password"
                    placeholder="비밀번호"
                    name="password"
                  />
                </div>
                <button>로그인</button>
              </form>
              <p>
                <a href="/findId">아이디 찾기</a>
                <a href="/findPwd">비밀번호 찾기</a>
              </p>
              <p>
                <span> 비회원일 경우 > </span>
                <b onclick="toggle()" class="pointer"> 회원가입 </b>
              </p>
            </div>
          </div>
        </div>
      </div>

      <div class="row content-row">
        <!-- 로그인 시 글자 -->
        <div class="col align-items-center flex-col">
          <div class="text sign-in">
            <h2>Welcome</h2>
          </div>
          <div class="img sign-in"></div>
        </div>

        <!-- 회원가입 시 글자-->
        <div class="col align-items-center flex-col">
          <div class="img sign-up"></div>

          <div class="text sign-up">
            <h2>Join with us</h2>
          </div>
        </div>
      </div>
    </div>

    <script src="../../../resources/js/user/loginUser.js"></script>
    <script src="../../../resources/js/user/registerUser.js"></script>
  </body>
</html>
