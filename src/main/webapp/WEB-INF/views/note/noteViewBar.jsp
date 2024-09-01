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
@font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
#sideBar{
	border-radius : 30px;
	width:100%;
	height:100%;
	background-color : #e1f1fa;
}
#sideBar>ul{
	display: flex;
    flex-direction: column;
    align-items: center;
    height: 100%;
    padding-top: 20px;
    padding-bottom: 30px;
}
#sideBar a{
	font-family: 'GangwonEdu_OTFBoldA';
}
#sideBar ul li a:hover{
	color : gray;
}
</style>
</head>
<body>
<div id="sideBar">
	<ul>
		<li><a href="/viewAllNote" id="myInfo">전체 쪽지함</a></li>
		<li><a href="/" id="">받은 쪽지함</a></li>
		<li><a href="/" id="">보낸 쪽지함</a></li>
	</ul>
</div>
</body>
</html>