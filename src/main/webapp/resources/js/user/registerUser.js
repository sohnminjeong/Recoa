let idCheck = false;
let idDupCheck = false;
let pwdCheck = false;
let userNicknameCheck = false;
let userPhoneCheck = false;

// 아이디 정규표현식
$('#userId').keyup((e) =>{
	let userId=$(e.target).val(); 
	const regExp = /^[A-Za-z]+[A-Za-z0-9]{3,11}$/;
	if(regExp.test(userId)){
		$('#idCheck').text("").css("color", "gray");
		idCheck = false;
	} else {
		$('#idCheck').text("영문자, 숫자 포함하여 총 4~12자로 입력하세요.").css("color", "gray");
		idCheck = true;
	}
});

// 아이디 중복확인			
$('#userId').keyup(() => {
	const userId = $('#userId').val();
	$.ajax({
		type: "post",
		url: "/idCheck",
		data: "userId=" + userId,

		success: function (result) {
			if (result) {
				$('#idCheck').text("중복된 아이디입니다").css("color", "gray");
				idDupCheck = true;
			} else if(!result&&!idCheck) {
				$('#idCheck').text("").css("color", "gray");
				idDupCheck = false;
			}
		}
	})
})

// 비밀번호 정규표현식 
$('#userPwd').keyup((e) =>{
	let userPwd=$(e.target).val(); 
	const regExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
	if(regExp.test(userPwd)){
		$('#pwdCheck').text("").css("color", "gray");
		pwdCheck = false;
	} else {
		$('#pwdCheck').text("영문자, 숫자, 특수문자 포함하여 총 8~15자로 입력하세요.").css("color", "gray");
		pwdCheck = true;
	}
});

// 닉네임 중복확인
$('#userNickname').keyup(() => {
	const userNickname = $('#userNickname').val();
	$.ajax({
		type: "post",
		url: "/nickNameCheck",
		data: "userNickname=" + userNickname,

		success: function (result) {
			if (result) {
				$('#nickNameCheck').text("중복된 닉네임입니다").css("color", "gray");
				userNicknameCheck = true;
			} else {
				$('#nickNameCheck').text("").css("color", "gray");
				userNicknameCheck = false;
			}
		}
	})
})

// 핸드폰번호 정규표현식
$('#userId').keyup((e) =>{
	let userId=$(e.target).val(); 
	const regExp = /^[A-Za-z]+[A-Za-z0-9]{3,11}$/;
	if(regExp.test(userId)){
		$('#idCheck').text("").css("color", "gray");
		idCheck = false;
	} else {
		$('#idCheck').text("영문자, 숫자 포함하여 총 4~12자로 입력하세요.").css("color", "gray");
		idCheck = true;
	}
});

// 핸드폰번호 중복확인
$('#userPhone').keyup(() => {
	const userPhone = $('#userPhone').val();
	$.ajax({
		type: "post",
		url: "/phoneCheck",
		data: "userPhone=" + userPhone,

		success: function (result) {
			if (result) {
				$('#userPhoneCheck').text("중복된 핸드폰번호입니다").css("color", "gray");
				idDupCheck = true;
			} else if(!result&&!idCheck) {
				$('#userPhoneCheck').text("").css("color", "gray");
				idDupCheck = false;
			}
		}
	})
})
