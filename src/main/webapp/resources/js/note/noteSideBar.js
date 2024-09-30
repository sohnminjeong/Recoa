$('#noteBtn').click(function(){
	$('#noteWrite').css({"display":"block"});
})

const file = document.querySelector('#noteFile');
function fileRegi(event){
	if(event.target.files.length>=4){
		alert("최대 파일 첨부 갯수는 3개입니다.");
		$("#noteFile").val("");
	}
}


$('#chatBtn').click(function(){
	
	$.ajax({
		type:"post",
		url:"/insertChatRoom",
		data : {"userNumber1":senderCode, "userNumber2":receiverCode},
		
		success:function(result){
			$('.nowChatting').css({"display":"block"});
			$('.nowChatting').load("/chat?chatRoomCode="+result);
			
		}
	})
	
})
$('#registerNoteBtn').click(function(){
	$.ajax({
		type:"post",
		url:"/registerNote",
		data:$("#registerNote").serialize(),
		
		success:function(result){
			if(alarmSocket){
    			let socketMsg = "note,"+result.senderNick+","+result.receiverNick+","+result.noteTitle+","+result.noteCode;
    			alarmSocket.send(socketMsg);
       		}
			
			location.replace('/viewAllNote?userCode=${user.userCode}');
		}
	})
})