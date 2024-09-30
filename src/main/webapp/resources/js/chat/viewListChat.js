$('.chat_content').on("click",function(event){
	var chatRoomCode = this.id.split("chatContent")[1];
	$('#chatBox').load("/chat?chatRoomCode="+chatRoomCode);
	
})