const name = document.querySelector("#empName");
	const resultIName = document.querySelector("#resultName");
	name.addEventListener("input", (e) => {
	  const nameExp = /^[가-힣]{2,}$/;
	  const nEt = nameExp.test(e.target.value);
	  if (nEt) {
		$("#submit").prop("disabled", false);
	    resultName.innerHTML = "OK!";
	    resultName.style.color = "blue";
		name.style.border = "";
	  } else {
		$("#submit").prop("disabled", true);
		resultName.innerHTML = "한글 2자 이상";
	    resultName.style.color = "red";
		name.style.border = "red solid 1px";
	  }
	});
	// 전화번호 입력
	const tel = document.querySelector("#phone");
	const resultTel = document.querySelector("#resultTel");
	tel.addEventListener("input", (e) => {
	  const telExp = /^\d{3}-\d{3,4}-\d{4}$/;
	  const tEt = telExp.test(e.target.value);
	  if (tEt) {
		$("#submit").prop("disabled", false);
	    resultTel.innerHTML = "OK!";
	    resultTel.style.color = "blue";
		tel.style.border = "";

	  } else {
		$("#submit").prop("disabled", true);
		resultTel.innerHTML = "010-0000-0000 형식";
	    resultTel.style.color = "red";
		tel.style.border = "red solid 1px";

	  }
	});
	// 이메일 입력
	const email = document.querySelector("#email");
	const resultIEmail = document.querySelector("#resultEmail");
	email.addEventListener("input", (e) => {
	  const emailExp = /^[\w.-]+@[\w.-]+\.[A-Za-z]{2,}$/;
	  const eEt = emailExp.test(e.target.value);

	  if (eEt) {
		$("#submit").prop("disabled", false);
	    resultEmail.innerHTML = "OK!";
	    resultEmail.style.color = "blue";
		email.style.border = "";

	  } else {
		$("#submit").prop("disabled", true);
		resultEmail.innerHTML = "이메일 형식(@포함)";
	    resultEmail.style.color = "red";
		email.style.border = "red solid 1px";

	  }
	});
	
	$("#modifyImg").click(() => { 

		Swal.fire({
			title: "변경하시겠습니까?",
			confirmButtonText: '등록',
			confirmButtonColor: "green",
			icon: "question",
			iconColor: "green",
			showCancelButton: true,
			cancelButtonText: '취소',
			cancelButtonColor: "red"
			}).then((result) => {
				  if (result.isConfirmed) {
					    const formData = new FormData();
						formData.append("empNo",$("#empNo").val());
						formData.append("url",$("#url").val());
						formData.append("file",$("#file")[0].files[0]);
					    
					    $.ajax({
					        // 요청
					        type : "post",
					        url : "/modifyImg",
					        dataType : "json", 
					        data : formData,
							processData: false,
							enctype: "multipart/form-data",
							contentType : false,
							
					        // 응답
					        success : function(result) {
					        	let timerInterval;
								Swal.fire({
									icon: "success",
									iconColor: "green",
								  title: "성공적으로 등록했습니다!",
								  html: '<span id="aa"></span>초 후 자동으로 닫힙니다.',
								  timer: 2000,
								  timerProgressBar: true,
								  didOpen: () => {
								    Swal.showLoading();
								    const timer = Swal.getPopup().querySelector("#aa");
								    timerInterval = setInterval(() => {
										let remainSecond = parseInt(Swal.getTimerLeft() / 1000) ;
								      timer.textContent = remainSecond +1;
								    }, 100);
								  },
								  willClose: () => {
								    clearInterval(timerInterval);
								  }
								}).then((result) => {
								  /* Read more about handling dismissals below */
								  if(result.dismiss == "backdrop") {
									  location.reload();
								  }
								  if (result.dismiss === Swal.DismissReason.timer) {
									  location.reload();
								  }
								});
					        },
					        
							error:function(xhr,status,error) {
								
							}
					    });
					 
					  }
					});
	});

	$("#deleteImg").click(() => { 

		Swal.fire({
			title: "변경하시겠습니까?",
			confirmButtonText: '등록',
			confirmButtonColor: "green",
			icon: "question",
			iconColor: "green",
			showCancelButton: true,
			cancelButtonText: '취소',
			cancelButtonColor: "red"
			}).then((result) => {
				  if (result.isConfirmed) {
					    const formData = new FormData();
						formData.append("empNo",$("#empNo").val());
						formData.append("url",$("#url").val());
					    
					    $.ajax({
					        // 요청
					        type : "post",
					        url : "/deleteImg",
					        dataType : "json", 
					        data : formData,
							processData: false,
							enctype: "multipart/form-data",
							contentType : false,
							
					        // 응답
					        success : function(result) {
					        	let timerInterval;
								Swal.fire({
									icon: "success",
									iconColor: "green",
								  title: "성공적으로 등록했습니다!",
								  html: '<span id="aa"></span>초 후 자동으로 닫힙니다.',
								  timer: 2000,
								  timerProgressBar: true,
								  didOpen: () => {
								    Swal.showLoading();
								    const timer = Swal.getPopup().querySelector("#aa");
								    timerInterval = setInterval(() => {
										let remainSecond = parseInt(Swal.getTimerLeft() / 1000) ;
								      timer.textContent = remainSecond +1;
								    }, 100);
								  },
								  willClose: () => {
								    clearInterval(timerInterval);
								  }
								}).then((result) => {
								  /* Read more about handling dismissals below */
								  if(result.dismiss == "backdrop") {
									  location.reload();
								  }
								  if (result.dismiss === Swal.DismissReason.timer) {
									  location.reload();
								  }
								});
					        },
					        
							error:function(xhr,status,error) {
								
							}
					    });
					 
					  }
					});
	});