let pwdCheck = false;
let newPwdCheck = false;

// 기존 비밀번호 확인 			
$('#userPwd').keyup(() => {
	const userPwd = $('#userPwd').val();
	const userId = $('#userId').val();
	
	$.ajax({
		type: "post",
		url: "/selectUserPwd",
		data: {"userId":userId, "userPwd":userPwd},

		success: function (result) {
			if (result) {
				$('#userPwdCheck').text("기존 비밀번호와 일치하지 않습니다").css("color", "gray");
				pwdCheck = true;
			} else {
				$('#userPwdCheck').text("").css("color", "gray");
				pwdCheck = false;
			}
		}
	})
})

// 비밀번호 정규표현식 
$('#newUserPwd').keyup((e) =>{
	let newUserPwd=$(e.target).val(); 
	const regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
	if(regExp.test(newUserPwd)){
		$('#newUserPwdCheck').text("").css("color", "gray");
		newPwdCheck = false;
	} else {
		$('#newUserPwdCheck').text("영문자, 숫자, 특수문자 포함하여 총 8~15자로 입력하세요.").css("color", "gray");
		newPwdCheck = true;
	}
});