$("#menu1").click(function(){
	if($("#underBar1").hasClass("hide")){
		$("#underBar1").removeClass("hide");
		$("#underBar1").addClass("active");
	} else{
		$("#underBar1").removeClass("active");
		$("#underBar1").addClass("hide");
	}

});
$("#menu2").click(function(){
	
	if($("#underBar2").hasClass("hide")){
		$("#underBar2").removeClass("hide");
		$("#underBar2").addClass("active");
	} else{
		$("#underBar2").removeClass("active");
		$("#underBar2").addClass("hide");
	}
});
$("#menu3").click(function(){
	if($("#underBar3").hasClass("hide")){
		$("#underBar3").removeClass("hide");
		$("#underBar3").addClass("active");
	} else{
		$("#underBar3").removeClass("active");
		$("#underBar3").addClass("hide");
	}
});