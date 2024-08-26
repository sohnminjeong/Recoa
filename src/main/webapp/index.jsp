<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="/resources/css/reset.css" />
    <title>Insert title here</title>
    <link rel="stylesheet" href="/resources/css/reset.css" />
    <script
      src="https://kit.fontawesome.com/cbb1359000.js"
      crossorigin="anonymous"
    ></script>
    <style>
      #header {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 1;
      }

      #section1,
      #section2,
      #section3 {
        position: relative;
        z-index: 0;
        height: 100vh;
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
    <div id="header"><%@ include file="WEB-INF/views/main/header.jsp" %></div>
    <div id="section1">
      <%@ include file="WEB-INF/views/main/section1.jsp" %>
    </div>
    <div id="section2">
      <%@ include file="WEB-INF/views/main/section2.jsp" %>
    </div>
    <div id="section3">
      <%@ include file="WEB-INF/views/main/section3.jsp" %>
    </div>
    <div id="userFloating">
		<%@ include file="WEB-INF/views/main/floating.jsp" %>
	</div>
  </body>
</html>
