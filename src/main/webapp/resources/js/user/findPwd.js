const resultBox = document.getElementById('resultBox');
const findPwdCheck = document.getElementById('findPwdCheck');


$("#findPwdBtn").click(() => {
	
	$.ajax({
		type: "post",
		url: "/findPwd",
		data: $("#findPwdCheck").serialize(),

		success: function (result) {
			findPwdCheck.style.display="none";
			resultBox.style.display="block";
			if(result.message==""){
				$("#resultPwd").text("조회결과가 없습니다.").css("color", "black");
			} else{
				$("#resultPwd").text(result.message);
			}
				
		},
		error: function(){
		}
	})
})