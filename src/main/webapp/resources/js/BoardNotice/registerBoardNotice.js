// 이미지 첨부하기 클릭 시 input file로 넘어가도록
	const addImg = document.querySelector("#addImg");
	const file = document.querySelector("#file");
	addImg.addEventListener('click', ()=> file.click());
	
	const deleteImg = document.querySelector("#deleteImg");
	
	// 이미지 미리보기
	const preview = document.querySelector("#preview");
	
	function setImage(event){
		
		// 3개까지 제한
		if(event.target.files.length >= 4){
			alert("최대 이미지 첨부 갯수는 3개입니다.");
			return;
		}
		
		// 미리보기에 src
		for(let i=0; i<event.target.files.length; i++){
			const reader = new FileReader();
			reader.onload = function(event){
				const newImgs = document.createElement('img');
				newImgs.src = event.target.result;
				preview.appendChild(newImgs);
			};
			reader.readAsDataURL(event.target.files[i]);
		}
	    addImg.style.display = "none"; 
	    deleteImg.style.display = "block"; 
	    preview.style.display = "block"; 
	}
	
	// 이미지 삭제
	deleteImg.addEventListener('click', function(){
		file.value="";
		while(preview.hasChildNodes()){
			preview.removeChild(preview.firstChild);
		}
		preview.style.display = "none";
	    addImg.style.display = "block";
	    deleteImg.style.display = "none";
	})
	
	// 제출 전 폼 유효 확인
	function validate(){
		if(noticeTitle.value==''){
			noticeTitle.focus();
			return false;
		} else if(noticeContent.value==''){
			noticeContent.focus();
			return false;
		}
		return true;
	}