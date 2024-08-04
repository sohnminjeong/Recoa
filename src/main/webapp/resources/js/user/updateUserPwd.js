let pwdCheck = false;
let newPwdCheck = false;
let nowAndNewCheck=false;
let newPwdDoubleCheck = false;

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

// 변경할 비밀번호와 현재 비밀번호 다르도록 조건 
$('#newUserPwd').keyup((e) =>{
	let newUserPwd=$(e.target).val(); 
	const userPwd = $('#userPwd').val();
	
	if(newUserPwd==userPwd){
		$('#newUserPwdCheck').text("현재 비밀번호와 일치합니다. 다시 작성해주세요").css("color", "gray");
		nowAndNewCheck = true;
	} else {
		$('#newUserPwdCheck').text("").css("color", "gray");
		nowAndNewCheck = false;
	}
});

// 변경할 비밀번호 재입력 일치 확인
$('#checkNewUserPwd').keyup((e) =>{
	let checkNewUserPwd=$(e.target).val(); 
	let newUserPwd = $('#newUserPwd').val();
	
	if(checkNewUserPwd==newUserPwd){
		$('#newUserPwdDoubleCheck').text("").css("color", "gray");
		newPwdDoubleCheck = false;
	} else {
		$('#newUserPwdDoubleCheck').text("변경할 비밀번호와 일치하지 않습니다.").css("color", "gray");
		newPwdDoubleCheck = true;
	}
});

function validate(){
	if(pwdCheck){
		userPwd.focus();
		return false;
	} else if(newPwdCheck){
		newUserPwd.focus();
		return false;
	} else if(nowAndNewCheck){
		newUserPwd.focus();
		return false;
	} else if(newPwdDoubleCheck){
		checkNewUserPwd.focus();
		return false;
	}
	alert("비밀번호 변경이 완료되었습니다. 재로그인 부탁드립니다.");
	return true;

}