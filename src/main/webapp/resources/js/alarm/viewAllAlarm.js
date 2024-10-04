$(".beforeCheck").on("click", function(event){
	var url = this.id;
	var name = url.split("?")[1].split("=")[0];
	var code = url.split("=")[1].split("&")[0];
	var alarmCode = url.split("=")[2];
	
	if(name=='freeCode'){
		$.ajax({
			type:"post",
			url:"/alarmCheck",
			data : {"code":code, "alarmCode":alarmCode},
			
			success:function(result){
				if(result){
					location.href=url;
				} else{
					location.href='/errorBoardFree';
				}
			}
		})
	}
	if(name=='noteCode'){
		$.ajax({
			type:"post",
			url:"/alarmNoteCheck",
			data : {"code":code, "alarmCode":alarmCode},
			
			success:function(result){
				if(result){
					location.href=url;
				} else{
					location.href='/errorNote';
				}
			}
		})
	}
})