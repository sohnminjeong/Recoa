<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<link href="../../resources/css/boardNotice/viewBoardNotice.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>

</style>

</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
<div id="container">
	<div id="topBar">
		<h3>${notice.noticeTitle}</h3>
		<div id="buttons">
		<c:choose>
			<c:when test="${user == 'anonymousUser' || user.userCode != notice.userCode}">
				<button type="button" onclick="location.href='/boardNoticeList'">목록</button>
			</c:when>
			<c:otherwise>
				<button type="button" onclick="location.href='/boardNoticeList'">목록</button>
				<button type="button" onclick="location.href='/updateNotice?noticeCode=${notice.noticeCode}'">수정</button>
				<button type="button" onclick="location.href='/deleteNotice?noticeCode=${notice.noticeCode}'">삭제</button>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
    <div id="desc">
    	<div id="writer">
    		<c:choose>
				<c:when test="${notice.user.userImgUrl==null}">
					<img src="resources/images/user/default_profile.png" class="userImg"/>
				</c:when>
				<c:otherwise>
					<img src="/recoaImg/user/${notice.user.userImgUrl}" class="userImg"/>
				</c:otherwise>
			</c:choose>
    		<div id="writerdesc">
	    		<span id="writerAdr">${notice.user.userAdmin}</span>
				<span id="writerNickname">${notice.user.userNickname}
				<i class="fa-solid fa-caret-right"></i>
				</span>
    		</div>
    		<div id="noteJsp" style="display : none">
				<jsp:include page="../note/noteSideBar.jsp" flush="true">
					<jsp:param value="${notice.user.userNickname}" name="param1"/>
					<jsp:param value="${notice.noticeCode}" name="param2"/>
					<jsp:param value="${notice.user.userCode}" name="param3"/>
				</jsp:include>
			</div>
    	</div>
    	<div id="noticedesc">
    		<p><fmt:formatDate value="${notice.noticeWritedate}" pattern="yy-MM-dd HH:mm"/></p>&nbsp;
			<p><i class="fa-solid fa-eye"></i>${notice.noticeView}</p>&nbsp;
			
			<c:choose>
				<c:when test="${user=='anonymousUser'}">
					<i class="fa-regular fa-bookmark" id="bookmarkIcon"></i>
				</c:when>
				<c:when test="${isBookmarked == 0}">
					<i class="fa-regular fa-bookmark" id="bookmarkIcon"></i>
				</c:when>
				<c:otherwise>
					<i class="fa-solid fa-bookmark" id="bookmarkIcon"></i>
				</c:otherwise>
			</c:choose>
			<p>${notice.bookmarkCount}</p>
    	</div>
    </div>
    <div id="noticeContent">
    	<p>${notice.noticeContent}</p>
    	<div id="images">
    		<c:forEach items="${images}" var="img" varStatus="status">
    			<img src="/recoaImg/boardNotice/${img.noticeImgUrl}"/>
    		</c:forEach>
    	</div>
    </div>
    
    </div>
   <div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
</div>
<script>
$(document).ready(function() {
    $("#bookmarkIcon").click(function() {
        var noticeCode = ${notice.noticeCode};
        $.post("/updateBookmark", { noticeCode: noticeCode }, function(data) {
        	if (data === "added") {
                $("#bookmarkIcon").removeClass("far").addClass("fas");
                location.reload(); // 페이지 새로고침
            } else if (data === "deleted") {
                $("#bookmarkIcon").removeClass("fas").addClass("far");
                alert("북마크가 삭제되었습니다.");
                location.reload(); // 페이지 새로고침
            } else {
                alert("로그인이 필요합니다.");
                window.location.href = "/login"; // 로그인 페이지로 이동
            }
        });
    });
});

$('.fa-caret-right').click(function(){
	$('#noteJsp').css({"display":"block"});
})
</script>
</body>
</html>