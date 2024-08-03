let pwdCheck = false;

// 기존 비밀번호 확인 			
$('#userPwd').keyup(() => {
	const userPwd = $('#userPwd').val();
	$.ajax({
		type: "post",
		url: "/selectUserPwd",
		data: "userPwd=" + userPwd,

		success: function (result) {
			if (result) {
				$('#userPwdCheck').text("기존 아이디와 일치하지 않습니다").css("color", "gray");
				pwdCheck = true;
			} else {
				$('#userPwdCheck').text("").css("color", "gray");
				pwdCheck = false;
			}
		}
	})
})