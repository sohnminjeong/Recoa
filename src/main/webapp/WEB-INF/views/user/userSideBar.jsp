<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<style>
	#sideBar{
		border-radius : 30px;
		width:100%;
		height:100%;
		background-color : #D4F0F0;
	}
	#sideBar>ul{
		display: flex;
	    flex-direction: column;
	    align-items: center;
	    height: 100%;
	    padding: 40px 0;
	}
	#sideBar>ul>li:nth-child(1){
		height:15%;
	}
	#sideBar>ul>li:nth-child(2){
		height:35%;
	}
	#sideBar>ul>li:nth-child(3){
		height:30%;
	}
	#sideBar>ul>li:nth-child(4){
		height:20%;
	}

	#sideBar ul li a:hover{
		color : gray;
	}
	
</style>
</head>
<body>
	<div id="sideBar">
		<ul>
			<li><a href="/myPageUser">내 정보</a></li>
			<li><i class="fa-solid fa-gear"></i>
				<ul>
					<li><a href="/updateProfile">프로필 설정</a></li>
					<li><a href="/updateUser">내정보 설정</a></li>
					<li><a href="/updateUserPwd">비밀번호 변경</a></li>
					<li><a href="/">회원 탈퇴</a></li>
				</ul>
			</li>
			<li><i class="fa-solid fa-clipboard-check"></i>
				<ul>
					<li><a href="/">내 게스트룸 예약</a></li>
					<li><a href="/">내 독서실 예약</a></li>
				</ul>
			</li>
			<li><i class="fa-solid fa-pen-to-square"></i>
				<ul>
					<li><a href="/">작성한 게시물</a></li>
				</ul>
			</li>
			
		</ul>
	</div>
</body>
</html>