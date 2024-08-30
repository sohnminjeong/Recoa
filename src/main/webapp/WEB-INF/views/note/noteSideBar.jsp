<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%String param1=request.getParameter("param1"); %>
<%String param2=request.getParameter("param2"); %>
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
#noteSideBar{
	width: 80px;
    height: 35px;
    border: 1px solid black;
    border-radius: 10px;
    align-content: center;
    text-align: center;
    font-size: 0.8rem;
    margin-left: 7px;
	
	span:hover{
		color : black;
	}
}

#noteWrite{
	width: 50%;
    height: 60%;
    border: 1px solid black;
    border-radius: 10px;
    position: fixed;
    left: 25%;
    box-shadow: rgba(0, 0, 0, 0.5) 0 0 0 9999px;
    background-color: black;
    color: white;
    padding: 10px;
    font-family: 'SDMiSaeng';
}
#noteWriteInner{
	display: flex;
    flex-direction: column;
    height: 100%;
    h3{
    	height: 15%;
        font-size: 1.4rem;
        align-content: center;
        border-bottom: 1px dashed white;
        width: 30%;
    }
    form{
    	height: 85%;
        display: flex;
        flex-direction: column;
        
        
        #person{
        	display: flex;
            justify-content: space-around;
            height: 15%;
            align-items: center;
            font-family: 'SDMiSaeng';
    		font-size: 1rem;
    		
    		input{
    			font-family: 'SDMiSaeng';
    			font-size: 1rem;
    		}
        }
        #innerContents{
        	height: 70%;
		    display: flex;
		    flex-direction: column;
		   	font-family: 'SDMiSaeng';
		   
		    #noteTitle{
		    	height: 15%;
   				 margin-bottom: 10px;
   				 font-family: 'SDMiSaeng';
                font-size: 1.3rem;
		    }
		    #noteContent{
		    	height: 75%;
    			margin-bottom: 10px;
    			font-family: 'SDMiSaeng';
                font-size: 1.4rem;
		    }
		    #file{
		    	margin-bottom:10px;
		    	font-family: 'SDMiSaeng';
                font-size: 0.8rem;
		    }
        }
        #innerBtn{
        	height: 15%;
		    display: flex;
		    justify-content: center;
		    
		    button{
		    	height: 75%;
    			margin: 0 5px;
    			font-family: 'SDMiSaeng';
   				font-size: 1rem;
		    }
        }
        
    }
}
</style>
</head>
<body>
<sec:authentication property="principal" var="user" />
	<div id="noteSideBar">
		<span id="noteBtn">쪽지 보내기</span><br>
		<span>채팅 하기</span>
	</div>
	<div id="noteWrite" style="display:none">
		<div id="noteWriteInner">
			<h3>쪽지 보내기</h3>
			<form action="/registerNote" method="post" enctype="multipart/form-data">
				<div id="person">
					<div>
						<span>보내는 사람</span>
						<input type="text" id="senderNick" name="senderNick" value="${user.userNickname}">
					</div>
					<div>
						<span>받는 사람</span>
						<input type="text" id="receiverNick" name="receiverNick" value="<%=param1%>">
					</div>
				</div>
				<div id="innerContents">
					<input type="text" id="noteTitle" name="noteTitle" placeholder="제목"> 
					<textarea placeholder="내용" name="noteContent" id="noteContent"></textarea>
					<input type="file" id="file" name="file" multiple="multiple" onchange="fileRegi(event)" >
				</div>
				<div id="innerBtn">
					<button>쪽지 전송</button>
					<button type="button" onclick="location.href='/viewOneBoardFree?freeCode=<%=param2%>'">쪽지 취소</button>
				</div>
				
			</form>
		</div>
	</div>
	<script>
	$('#noteBtn').click(function(){
		$('#noteWrite').css({"display":"block"});
	})
	
	const file = document.querySelector('#file');
	function fileRegi(event){
		if(event.target.files.length>=4){
			alert("최대 파일 첨부 갯수는 3개입니다.");
			$("#file").val("");
		}
	}
	</script>
</body>
</html>