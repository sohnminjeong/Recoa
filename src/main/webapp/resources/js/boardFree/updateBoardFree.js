const selectImg = document.querySelector('#selectImg');
const file = document.querySelector('#file');
const delImg = document.querySelector("#delImg");
const createImg = document.querySelector("#createImg");
const addImg = document.querySelector("#addImg");
const delImgBtn=document.querySelector("#delImgBtn");

addImg.addEventListener('click', ()=>file.click());
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
	
	createImg.style.display="block";
	delImg.style.display="block";
	addImg.style.display="none";
}


delImg.addEventListener('click', function(){
	file.value="";
	delImgBtn.value=true;
	while ( createImg.hasChildNodes() )
	{
		createImg.removeChild( createImg.firstChild );       
	}  
	createImg.style.display="none";
	
	delImg.style.display="none";
	addImg.style.display="none";
	
})

function validate(){
	if(freeTitle.value==''){
		freeTitle.focus();
		return false;
	} 
	alert("수정 완료되었습니다.");
	return true;
}