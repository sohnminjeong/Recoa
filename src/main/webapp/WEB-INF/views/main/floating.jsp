<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<style>
@font-face {
    font-family: 'SDMiSaeng';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SDMiSaeng.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}	
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
#socketAlert{
	border:2px dashed gray;
	border-radius:5px;
	padding:10px;
	margin-top : 5px;
	font-family: 'SDMiSaeng';
	font-size:1.3rem;
	a{
		text-decoration : underline;
		
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
				<li><a href="/viewListChat?userCode=${user.userCode}"><i class="fa-solid fa-comments"></i></a></li>
				<li><a href="/"><i class="fa-solid fa-bell"></i></a></li>
			</ul>
			<i class="fa-solid fa-tree"></i>
		</c:if>
		<div id="socketAlert" style="display : none"></div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
var alarmSocket=null;
$(document).ready(function(){
	if(${user!=null}){
		connectWs();
	}
})
function connectWs(){
	var ws = new SockJS("/alarm");
	alarmSocket = ws;
	
	ws.onopen=function(){
		console.log('open');
	}
	ws.onmessage = function(event){
		let socketAlert = $('div#socketAlert');
		socketAlert.html(event.data);
		socketAlert.css('display','block');
		setTimeout(function(){
			socketAlert.css('display','none');
		}, 10000);
	}
	
	ws.onclose=function(){
		console.log('close');
	}
}
</script>
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