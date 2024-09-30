<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../../resources/css/reset.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/cbb1359000.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="../../../resources/css/boardFree/viewOneBoardFree.css" />
</head>
<body>
<sec:authentication property="principal" var="user" />
<div id="header">
	<%@ include file="../main/header.jsp" %>
</div>
<div id="content">
	<div id="container">
		<div id="containerHead">
			<h3>${vo.freeTitle}</h3>
			<div id="btn">
			<c:choose>
				<c:when test="${user=='anonymousUser'||user.userCode!=vo.userCode}">	
					<button type="button" onclick="location.href='/viewAllBoardFree'">목록</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="location.href='/updateBoardFree?freeCode=${vo.freeCode}'">수정</button>
					<button type="button" onclick="location.href='/deleteBoardFree?freeCode=${vo.freeCode}'">삭제</button>
					<button type="button" onclick="location.href='/viewAllBoardFree'">목록</button>
				</c:otherwise>
			</c:choose>	
			</div>
		</div>
		<div id="containerContents">
			<div id="topContents">
				<div id="writer">
					<c:choose>
						<c:when test="${vo.user.userImgUrl==null}">
							<img src="resources/images/user/default_profile.png" class="userImg"/>
						</c:when>
						<c:otherwise>
							<img src="/recoaImg/user/${vo.user.userImgUrl}" class="userImg"/>
						</c:otherwise>
					</c:choose>
					<div id="writerDetail">
						<span id="writerAdr">${vo.user.userAdr}동</span>
						<span id="writerNickname">${vo.user.userNickname}
							<i class="fa-solid fa-caret-right"></i>
						</span>
					</div>
					<div id="noteJsp" class="noView">
						<jsp:include page="../note/noteSideBar.jsp" flush="true">
							<jsp:param value="${vo.user.userNickname}" name="param1"/>
							<jsp:param value="${vo.freeCode}" name="param2"/>
							<jsp:param value="${vo.user.userCode}" name="param3"/>
						</jsp:include>
					</div>
					
					
				</div>	
				<div id="writerRight">
					<fmt:formatDate value="${vo.freeWritedate}" pattern="yy-MM-dd HH:mm"/>&nbsp;
					<i class="fa-solid fa-eye">${vo.freeView}</i>&nbsp;
					<c:choose>
						<c:when test="${user=='anonymousUser'}">
							<i class="fa-solid fa-heart"></i>
						</c:when>
						<c:when test="${like==true}">
							<i class="fa-solid fa-heart click" id="freeLike"></i>
						</c:when>
						<c:otherwise>
							<i class="fa-solid fa-heart" id="freeLike"></i>
						</c:otherwise>
					</c:choose>
					<span id="countLike">${countLike}</span>
					<input type="hidden" value="${vo.likeCheck}" id="likeCheck" name="likeCheck"/>
				</div>
				
			</div>
			<div id="bottomContents">
				<span id="text">${vo.freeContent}</span>
				<div id="img">
					<c:forEach items="${imgList}" var="img" varStatus="status">
						<img src="/recoaImg/boardFree/${img.freeImgUrl}"/>
					</c:forEach>
					
				</div>
			</div>
		</div>
		<div id="containerComments">
			<div id="writeComment">
				<c:choose>
					<c:when test="${user=='anonymousUser'}">
						<span>비회원의 경우, 로그인 후 댓글 입력 부탁드립니다.</span>
					</c:when>
					<c:otherwise>
						<span>${user.userNickname}</span>	
						<form action="/registerBoardFreeComment" method="post" id="registerBoardFreeComment">
							<input type="hidden" name="freeCode" value="${vo.freeCode}" id="freeCode"/>
							<input type="hidden" name="userCode" value="${user.userCode}" id="userCode"/>
							<input type="text" placeholder="댓글을 남겨보세요" name="freeCommentContent" id="freeCommentContent">
							<button type="button" id="registerBoardFreeCommentBtn">등록</button>
						</form>
					</c:otherwise>
				</c:choose>
			</div>
			<div id="viewCommentsBtn">
				<span>댓글 보기</span>
				<i class="fa-solid fa-sort-down"></i>
				<i class="fa-solid fa-sort-up" style="display:none"></i>
			</div>

			<div id="viewComments" style="display:none">
				<c:forEach items="${commentList}" var="comment" varStatus="status">
					<c:if test="${comment.commentParentCode==null}">
						<div id="commented">
							<div id="commentedTop">
								<div id="commentedWriter">
									<c:choose>
										<c:when test="${comment.user.userImgUrl==null}">
											<img src="resources/images/user/default_profile.png" class="userImg"/>
										</c:when>
										<c:otherwise>
											<img src="/recoaImg/user/${comment.user.userImgUrl}" class="userImg"/>
										</c:otherwise>
									</c:choose>
									<div id="commentedWriterDetail">
										<span>${comment.user.userAdr}동</span>
										<span>${comment.user.userNickname}</span>
									</div>
								</div>
								<div id="commentDate">
									<fmt:formatDate value="${comment.freeCommentWritedate}" pattern="yy-MM-dd HH:mm"/>
								</div>
							</div>
							<div id="commentedBottom">
								<c:choose>
									<c:when test="${user!='anonymousUser'&&comment.user.userNickname==user.userNickname}">
										<div id="bottomInfo">
											<!-- 기존 댓글 보기 -->
											<span id="existingComment">${comment.freeCommentContent}</span>	
								
											
											<!-- 댓글 수정 폼-->
											<div id="updateComment" style="display:none">
												<form action="/updateBoardFreeComment" method="post" onsubmit="return validate()">
													<input type="hidden" name="freeCommentCode" value="${comment.freeCommentCode}"/>
													<input type="text" value="${comment.freeCommentContent}" name="freeCommentContent" id="updateCommentContent">
													<button type="submit">수정 완료</button>
													<button type="button" onclick="location.href='/viewOneBoardFree?freeCode=${comment.freeCode}'">수정 취소</button>
												</form>
											</div>
											
											
										</div>
									</c:when>
									<c:otherwise>
										<span>${comment.freeCommentContent}</span>
									
									</c:otherwise>
								</c:choose>

								<!-- 회원이자 댓글쓴이일경우 : 댓글 수정, 삭제 버튼 -->
								<div id="bottomBtn">
									<c:if test="${user!='anonymousUser'&& comment.user.userId==user.userId}">
										<button type="button" id="updateCommentBtn">수정</button>
										<button type="button" id="deleteCommentBtn" onclick="location.href='/deleteBoardFreeComment?freeCommentCode=${comment.freeCommentCode}&freeCode=${comment.freeCode}'">삭제</button>
									</c:if>
								</div>				
							</div>
						</div>
					</c:if>
				</c:forEach>
				<nav id="commentPaging">
					<ul class="pagination">
						<li class="page-item ${commentPaging.prev ? '' : 'disabled'}">
							<c:choose>
								<c:when test="${commentPaging.startPage==1}">
									<a class="page-link" href="/viewOneBoardFree?page=${commentPaging.startPage=1}&freeCode=${vo.freeCode}">
										<i class="fa-solid fa-chevron-left"></i>
									</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="/viewOneBoardFree?page=${commentPaging.startPage - 1}&freeCode=${vo.freeCode}">
										<i class="fa-solid fa-chevron-left"></i>
									</a>
								</c:otherwise>
							</c:choose>
						</li>
						
						<c:forEach begin="${commentPaging.startPage}" end="${commentPaging.endPage}" var="page">
							<li class="page-item">
							
								<a class="page-link ${commentPaging.page== page ? 'active' : ''} " href="/viewOneBoardFree?page=${page}&freeCode=${vo.freeCode}">
								${page}
								</a>
							</li>		
						</c:forEach>
					
						<li class="page-item ${commentPaging.next ? '' : 'disabled'}">
							<c:choose>
								<c:when test="${commentPaging.endPage<100}">
									<a class="page-link" href="/viewOneBoardFree?page=${commentPaging.endPage}&freeCode=${vo.freeCode}">
										<i class="fa-solid fa-chevron-right"></i>
									</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="/viewOneBoardFree?page=${commentPaging.endPage + 1}&freeCode=${vo.freeCode}">
										<i class="fa-solid fa-chevron-right"></i>
									</a>
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>
<div id="userFloating">
	<%@ include file="../main/floating.jsp" %>
</div>
<script src="../../../resources/js/boardFree/viewOneBoardFree.js"></script>
<script>
$("#registerBoardFreeCommentBtn").click(()=>{
	$.ajax({
		type:"post",
		url:"/registerBoardFreeComment",
		data: $("#registerBoardFreeComment").serialize(),
		
		success:function(result){
			if(alarmSocket){
    			let socketMsg = "reply,"+result.userNickname+","+'${vo.user.userNickname}'+","+'${vo.freeTitle}'+","+'${vo.freeCode}';
    			alarmSocket.send(socketMsg);
       		}
			
			location.replace('/viewOneBoardFree?freeCode='+${vo.freeCode}); 
		}
	})	
})
</script>
</body>
</html>