let idCheck = false;
let idDupCheck = false;
let pwdCheck = false;
let userNicknameCheck = false;
let userPhoneCheck = false;
let userPhoneDupCheck=false;
let emailDupCheck = false;
let emailCheck = false;

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
$('#userPhone').keyup((e) =>{
	let userPhone=$(e.target).val(); 
	const regExp = /^01([0,1])-?([0-9]{3,4})-?([0-9]{4})$/;
	if(regExp.test(userPhone)){
		$('#userPhoneCheck').text("").css("color", "gray");
		userPhoneCheck = false;
	} else {
		$('#userPhoneCheck').text("-포함하여 작성해주세요").css("color", "gray");
		userPhoneCheck = true;
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
				userPhoneDupCheck = true;
			} else if(!result&&!userPhoneCheck) {
				$('#userPhoneCheck').text("").css("color", "gray");
				userPhoneDupCheck = false;
			}
		}
	})
})

// 이메일 정규표현식
$('#userEmail').keyup((e) =>{
	let userEmail=$(e.target).val(); 
	const regExp = /^\w+@\w+\.\w+$/;
	if(regExp.test(userEmail)){
		$('#emailCheck').text("").css("color", "gray");
		emailCheck = false;
	} else {
		$('#emailCheck').text("이메일 형식에 맞춰서 입력하세요.").css("color", "gray");
		emailCheck = true;
	}
});

// 이메일 중복확인
$('#userEmail').keyup(() => {
	const userEmail = $('#userEmail').val();
	$.ajax({
		type: "post",
		url: "/emailCheck",
		data: "userEmail=" + userEmail,

		success: function (result) {
			if (result) {
				$('#emailCheck').text("중복된 이메일입니다").css("color", "gray");
				emailDupCheck = true;
			} else if(!result&&!emailCheck) {
				$('#emailCheck').text("").css("color", "gray");
				emailDupCheck = false;
			}
		}
	})
})

