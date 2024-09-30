

// mouse event
$('.fa-tree').mouseover(function(){
	$('.submenus').css({"display":"block"});
})

$('.submenus').mouseleave(function(){
	$(this).css({"display":"none"});
})
$('.fa-xmark').click(function(){
	$('div#socketAlert').css('display','none');
})