// 이미지 클릭 시 file upload
    const userImgUrl = document.querySelector('#userImgUrl');
    const userImg = document.querySelector('.userImg');
    userImg.addEventListener('click', () => userImgUrl.click());
   
    
	 /// 닉네임 중복확인
	 let userNicknameCheck = false;
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
    
// 선택 이미지 미리보기
function imgShow(event){
	var reader = new FileReader();
	
	reader.onload = function(event){
		userImg.setAttribute("src", event.target.result);
	};
	reader.readAsDataURL(event.target.files[0]);
}

function validate(){
	if(userNickname.value==''){
		userNickname.focus();
		return false;
	}else if(userNicknameCheck){
		userNickname.focus();
		return false;
	}
	alert("변경이 완료되었습니다.");
 return true; 
 }
    
// 이미지 삭제 
const delImg = document.querySelector("#delImg");
delImg.addEventListener('click', function(){
	
	userImg.src="resources/images/user/default_profile.png";
	delUserImgUrl.value=true;
})