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
<link rel="stylesheet" href="../../../resources/css/main/floating.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="floating">
		<c:if test="${user!='anonymousUser'}">
			<ul class="submenus" id="submenu11">
				<li><a href="/viewAllNote?userCode=${user.userCode}"><i class="fa-solid fa-envelope"></i></a></li>
				<li><a href="/viewListChat?userCode=${user.userCode}"><i class="fa-solid fa-comments"></i></a></li>
				<li><a href="/viewAllAlarm?userCode=${user.userCode}"><i class="fa-solid fa-bell"></i></a></li>
			</ul>
			<i class="fa-solid fa-tree"></i>
		</c:if>
		<div id="socketAlert" style="display : none">
			<div id="alarmContent"></div>
			<i class="fa-solid fa-xmark"></i>
		</div>
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
		$('#alarmContent').append(event.data+'<br/>');
		socketAlert.css('display','flex');
		setTimeout(function(){
			socketAlert.css('display','none');
		}, 20000);
	}
	
	ws.onclose=function(){
		console.log('close');
	}
}
</script>
<script src="../../../resources/js/main/floating.js"></script>
</body>
</html>