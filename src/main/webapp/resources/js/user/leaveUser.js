let pwdDoubleCheck = false;
//변경할 비밀번호 재입력 일치 확인
$('#userPwdCheck').keyup((e) =>{
	let userPwdCheck=$(e.target).val(); 
	let userPwd = $('#userPwd').val();
	
	if(userPwdCheck==userPwd){
		pwdDoubleCheck = false;
	} else {
		pwdDoubleCheck = true;
	}
});

function validate(){
	if(userPwd.value==''){
		userPwd.focus();
		return false;
	} else if(userPwdCheck.value==''){
		userPwdCheck.focus();
		return false;
	} else if(pwdDoubleCheck){
		$('#userPwdDoubleCheck').text("현재 비밀번호와 일치하지 않습니다.").css("color", "gray");
		userPwdCheck.focus();
		return false;
	}
		return true;
	
}