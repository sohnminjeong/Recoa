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
<style>
@font-face {
    font-family: 'GangwonEdu_OTFBoldA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEdu_OTFBoldA.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'SDMiSaeng';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SDMiSaeng.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
#header{
	position:absolute;
	z-index:1;
	width:100%;
	border-bottom:1px solid black;
}
#content{
	position:relative;
	z-index:0;
	height:100vh;
	padding-top:10vh;
	margin:0 50px;
}
#content #container{
	display:flex;
	flex-direction:column;
	align-items:center;
	width:100%;
	height:100%;
	padding-top:5%;
}
#containerHead{

	display:flex;
	justify-content:space-between;
	width:70%;
	height:5%;
	border-bottom : 1px dashed black;
	padding-bottom:15px;
	
	h3{
		font-family: 'GangwonEdu_OTFBoldA';
		font-size:1.4rem;
	}
	
	#btn button{
		border-radius:3px;
		border:none;
		font-family: 'SDMiSaeng';
		font-size:1rem;
	}
	#btn button:hover{
		background-color : black;
		color : white;
	}
}

#containerContents{
	width:70%;
	height:75%;
	font-family: 'GangwonEdu_OTFBoldA';
	border-bottom : 1px dashed black;
	padding-bottom:20px;
}
#topContents{
	width:100%;
	margin-top: 10px;
	margin-bottom:20px;
    display: flex;
    justify-content: space-between;
    color:gray;
    #writer{
    	display:flex;
    	
    	img{
    		border-radius:50%;
    		width:30px;
    		height:30px;
    		margin-right:10px;
    	}
    	#writerDetail{
    		display:flex;
    		flex-direction:column;
    	}
    }
    #writerRight i{
    	font-size:0.7rem;
    	font-wieght:light;
    }
    #writerRight #freeLike:hover{
    	cursor:pointer;
    	color : red;
    }
}
#bottomContents{
	#text{
		font-size:1.3rem;
	}
	#img{
		margin-top:30px;
		height:200px;
		img{
			width:200px;
			height:200px;
			margin:0 10px;
		}
	}

}
.click{
	color:red;
}
.clickNon{
	color : gray;
}
/*------------------------- 댓글 ----------------------------*/
#containerComments{
	width:55%;
	height:20%;
	margin-top:20px;
	display: flex;
    flex-direction: column;
    align-items: center;
	
	#writeComment{
		border:1px solid gray;
		border-radius : 10px;
		width: 75%;
		height : 50%;
		padding: 5px 10px;
		display: flex;
    	flex-direction: column;
		
		span{
			font-family: 'GangwonEdu_OTFBoldA';
			height: 35%;
			align-content: center;
		}
		
		form{
			display: flex;
   			height: 65%;
   			
			#freeCommentContent{
				border:none;
				width:100%;
				 font-family: 'SDMiSaeng';
				 font-size:1.2rem;
			}
			
			button{
				font-family: 'SDMiSaeng';
                font-size: 1rem;
                width: 8%;
                border: none;
                border-radius: 5px;
			}
		}
	}
	#viewCommentsBtn{
		width: 75%;
	    margin-top: 10px;
	    display: flex;
	    justify-content: right;
		
		span{
			font-family: 'SDMiSaeng';
            font-size: 1.2rem;
            margin-right:5px;
		}
	}
	
	#viewComments{
		
		width:75%;
		margin-top:10px;
		
		#commented{
			border-bottom: 0.5px dashed gray;
			padding-bottom:10px;
			margin-top:10px;
			
			#commentedTop{
				display:flex;
				justify-content: space-between;
				
				#commentDate{
					font-family: 'GangwonEdu_OTFBoldA';
    				font-size: 0.8rem;
				}
			}
			#commentedBottom{
				display:flex;
				justify-content: space-between;
				
				#bottomInfo{
					width:80%;
					input{
						width: 75%;
					    margin-left: 10px;
					    border-radius: 3px;
					}
				}
				
				span{
					font-size:0.9rem;
					font-family: 'GangwonEdu_OTFBoldA';
					margin-left: 10px;	
				}
				#bottomBtn{
					display:flex;
					
					button{
						font-family: 'SDMiSaeng';
		                font-size: 1rem;
		               	margin: 0 3px;
		                border: none;
		                border-radius: 5px;
					}
					button:hover{
						border:0.3px dashed black;
					}
				}
				#updateComment{
					form{
						display:flex;
					}
					input{
						font-family: 'SDMiSaeng';
						border: 1px solid black;
					}
					
					button{
						font-family: 'SDMiSaeng';
		                font-size: 1rem;
		               	margin: 0 3px;
		                border: none;
		                border-radius: 5px;
		                width:15%;
					}
					button:hover{
						border:0.3px dashed black;
					}
				}
			}
			
			#commentedWriter{
				display:flex;
				font-family: 'GangwonEdu_OTFBoldA';
				font-size:0.8rem;
				margin-bottom: 5px;
				img{
					border-radius:50%;
		    		width:23px;
		    		height:23px;
		    		margin-right:5px;
		    		border : 0.3px solid black;
				}
				#commentedWriterDetail{
					display:flex;
					flex-direction:column;
				}
			}
		
		}
	}
	
	
}
.fa-sort-down:hover{
	cursor:pointer;
}
.fa-sort-up:hover{
	cursor:pointer;
}

#commentPaging{
	margin-bottom : 20px;
	
	.pagination{
		display:flex;
		justify-content:center;
	}	
}
#userFloating{
	position: fixed;
    z-index: 1;
    bottom: 6%;
    right: 4%;
}
.fa-caret-right:hover{
	color : green;
}
.noView{
	display:none;
}
.yseView{
	display:block;
}
#registerBoardFreeCommentBtn:hover{
	cursor:pointer;
}
</style>
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
<script>

$('#freeLike').click(function() {
    if ( $(this).hasClass('click') ) {
        $(this).removeClass('click')
        $(this).addClass('clickNon')
        $('#likeCheck').val("0")
    } else {
        $(this).addClass('click')
        $(this).removeClass('clickNon')  
        $('#likeCheck').val("1")
    }
});


$('#freeLike').click(function(){
	var userCode = $('#userCode').val();
	var freeCode = $('#freeCode').val();
	var likeCheck = $('#likeCheck').val();
	$.ajax({
		type:"post",
		url:"/updateFreeLike",
		data:{"userCode":userCode, "freeCode":freeCode, "likeCheck":likeCheck},
		
		success: function (result) {
				$("#countLike").text(result);
		}
	})
	
})

$('.fa-sort-down').click(function(){
	$('#viewComments').css({"display":"block"});
	$(this).css({"display":"none"});
	$('.fa-sort-up').css({"display":"block"});
})
$('.fa-sort-up').click(function(){
	$('#viewComments').css({"display":"none"});	
	$(this).css({"display":"none"});
	$('.fa-sort-down').css({"display":"block"});
})

$('#updateCommentBtn').click(function(){
	$('#updateComment').css({"display":"block"});
	$('#existingComment').css({"display":"none"});
	$('#bottomBtn').css({"display":"none"});
	
})

function validate(){
	if(updateCommentContent.value==''){
		updateCommentContent.focus();
		return false;
	}
	alert("댓글 수정 완료");
	return true;
	
}

$('.fa-caret-right').click(function(){
	if($('#noteJsp').hasClass("noView")){
		$('#noteJsp').removeClass("noView");
		$('#noteJsp').addClass("yesView");
	}else{
		$('#noteJsp').removeClass("yesView");
		$('#noteJsp').addClass("noView");
	}
})
$("#registerBoardFreeCommentBtn").click(()=>{
	$.ajax({
		type:"post",
		url:"/registerBoardFreeComment",
		data: $("#registerBoardFreeComment").serialize(),
		
		success:function(result){
			if(socket){
    			let socketMsg = "reply,"+result.userNickname+","+'${vo.user.userNickname}'+","+'${vo.freeTitle}'+","+'${vo.freeCode}';
    			socket.send(socketMsg);
       		}
			$("#freeCommentContent").val("");
		}
	})	
})

</script>
</body>
</html>