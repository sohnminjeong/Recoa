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
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<style>
	
	#floating{
		border-radius:50%;
		.fa-tree{
			width:50px;
			height:50px;
			 border-radius:50%;
	        border : 1px solid black;
		}
		i{
			width:50px;
			height:50px;
	        text-align: center;
	        align-content: center;
	        font-size:1.3rem;
		}
	
	}
	.fa-tree:hover{
		color:#0F5132;
		border : 1.5px dashed black;
	}
	
	.submenus{
		display:none;
		height:150px;
		width:50px;
		 border : 1.5px dashed black;
		 border-radius : 15px;
		 margin-bottom:15px;
		 
		i:hover{
			color:#B1D0EC;
		}
	}
</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="floating">
		<c:if test="${user!='anonymousUser'}">
			<ul class="submenus" id="submenu11">
				<li><a href="/viewAllNote?userCode=${user.userCode}"><i class="fa-solid fa-envelope"></i></a></li>
				<li><a href="/chat"><i class="fa-solid fa-comments"></i></a></li>
				<li><a href="/"><i class="fa-solid fa-bell"></i></a></li>
			</ul>
			<i class="fa-solid fa-tree"></i>
		</c:if>
	</div>
<script>
$('.fa-tree').mouseover(function(){
	$('.submenus').css({"display":"block"});
})

$('.submenus').mouseleave(function(){
	$(this).css({"display":"none"});
})
</script>
</body>
</html>