const userRealName = document.getElementById('userRealName');
const userEmail = document.getElementById('userEmail');
const resultBox = document.getElementById('resultBox');
const findIdCheck = document.getElementById('findIdCheck');


$("#findIdBtn").click(() => {
	
	$.ajax({
		type: "post",
		url: "/findId",
		data: $("#findIdCheck").serialize(),

		success: function (result) {
			findIdCheck.style.display="none";
			resultBox.style.display="block";
			if(result.message==""){
				$("#resultId").text("조회결과가 없습니다.").css("color", "black");
			} else{
				$("#resultId").text(result.message);
			}
				
		},
		error: function(){
		}
	})
})