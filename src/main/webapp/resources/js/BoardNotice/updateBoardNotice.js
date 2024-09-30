const addImg = document.querySelector("#addImg");
	const file = document.querySelector("#file");
	
	const deleteImg = document.querySelector("#deleteImg");
	const preview = document.querySelector("#preview");
	
	const prev = document.querySelector("#images");
	addImg.addEventListener('click', ()=> file.click());
	
	// 이미지 삭제
	deleteImg.addEventListener('click', function(){
		document.querySelector("#delImages").value = "true";
		
		if(prev){
			prev.innerHTML = "";
		}
		
		preview.innerHTML = "";
		
		file.value="";
		
		preview.style.display = "block";
		prev.style.display="none";
		
	    addImg.style.display = "block";
	    deleteImg.style.display = "none";
	})
	
	// 기존 이미지가 있는 경우 삭제 시 미리보기에서 반영하기
	window.addEventListener('load', () => {
		if(prev && prev.querySelectorAll('img').length > 0){
			deleteImg.style.display="block";
		} else{
			deleteImg.style.display="none";
		}
	})
	
	function setImage(event){
		preview.innerHTML = "";
		const prevCount = prev ? prev.querySelectorAll('img').length : 0; 
		const newCount = event.target.files.length;
		
		// 3개까지 제한
		if(prevCount + newCount >= 4){
			alert("최대 이미지 첨부 갯수는 3개입니다.");
			return;
		}
		
		// 미리보기에 이미지 담기
		for(let i=0; i < newCount; i++){
			const reader = new FileReader();
			reader.onload = function(event){
				const newImgs = document.createElement('img');
				newImgs.src = event.target.result;
				preview.appendChild(newImgs);
			};
			reader.readAsDataURL(event.target.files[i]);
		}
		
		if(newCount > 0){
			preview.style.display="block";
			addImg.style.display="block";
			deleteImg.style.display="block";
		}
	}
	
	
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