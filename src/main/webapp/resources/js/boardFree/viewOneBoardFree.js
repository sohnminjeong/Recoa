$('#freeLike').click(function() {
    if ( $(this).hasClass('click') ) {
        $(this).removeClass('click')
        $(this).addClass('clickNon')
        $('#likeCheck').val("0")
    } else {
        $(this).addClass('click')
        $(this).removeClass('clickNon')  
        $('#likeCheck').val("1")
    }
});


$('#freeLike').click(function(){
	var userCode = $('#userCode').val();
	var freeCode = $('#freeCode').val();
	var likeCheck = $('#likeCheck').val();
	$.ajax({
		type:"post",
		url:"/updateFreeLike",
		data:{"userCode":userCode, "freeCode":freeCode, "likeCheck":likeCheck},
		
		success: function (result) {
				$("#countLike").text(result);
		}
	})
	
})

$('.fa-sort-down').click(function(){
	$('#viewComments').css({"display":"block"});
	$(this).css({"display":"none"});
	$('.fa-sort-up').css({"display":"block"});
})
$('.fa-sort-up').click(function(){
	$('#viewComments').css({"display":"none"});	
	$(this).css({"display":"none"});
	$('.fa-sort-down').css({"display":"block"});
})

$('#updateCommentBtn').click(function(){
	$('#updateComment').css({"display":"block"});
	$('#existingComment').css({"display":"none"});
	$('#bottomBtn').css({"display":"none"});
	
})

function validate(){
	if(updateCommentContent.value==''){
		updateCommentContent.focus();
		return false;
	}
	alert("댓글 수정 완료");
	return true;
	
}

$('.fa-caret-right').click(function(){
	if($('#noteJsp').hasClass("noView")){
		$('#noteJsp').removeClass("noView");
		$('#noteJsp').addClass("yesView");
	}else{
		$('#noteJsp').removeClass("yesView");
		$('#noteJsp').addClass("noView");
	}
})
