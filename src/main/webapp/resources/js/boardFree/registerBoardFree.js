const selectImg = document.querySelector('#selectImg');
const file = document.querySelector('#file');
const delImg = document.querySelector("#delImg");
const createImg = document.querySelector("#createImg");

selectImg.addEventListener('click', ()=>file.click());

function imgShow(event){
	if(event.target.files.length>=4){
		alert("최대 이미지 첨부 갯수는 3개입니다.");
		return;
	}
	
	for(let i=0; i<event.target.files.length; i++){
		const reader = new  FileReader();
		reader.onload=function(event){
			const newImgs = document.createElement('img');
			newImgs.src = event.target.result;
			createImg.appendChild(newImgs);	
		};
		reader.readAsDataURL(event.target.files[i]);
	}
	selectImg.style.display="none";
	createImg.style.display="block";
	delImg.style.display="block";
}


delImg.addEventListener('click', function(){
	file.value="";
	while ( createImg.hasChildNodes() )
	{
		createImg.removeChild( createImg.firstChild );       
	}  
	createImg.style.display="none";
	selectImg.style.display="block";
	delImg.style.display="none";
	
})

function validate(){
	
	if(freeTitle.value==''){
		freeTitle.focus();
		return false;
	} 
	alert("작성 완료되었습니다.");
	return true;
}