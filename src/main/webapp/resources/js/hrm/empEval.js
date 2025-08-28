$("#btn").click(() => {
		
		const pr = {};
		
		pr.empNo = $("#empNo").val();
		pr.evaluatorEmpNo = $("#emp").val();
		pr.attitudeScore = $('input[name="attitudeScore"]:checked').val();
		pr.achieveScore = $('input[name="achieveScore"]:checked').val();
		pr.comments = $("#comments").val();
		console.log(pr);
		if(pr.evaluatorEmpNo == -1) {
			Swal.fire({
				title: "평가할 사원을 선택해주세요!!",
				confirmButtonText: '확인',
				width: 600,
				confirmButtonColor: "#90C67C",
				icon: "warning",
				iconColor: "green"
				});
		} else{
			Swal.fire({
				title: "등록하시겠습니까?",
				text: $("#emp option:selected").text().split(" / ")[0] + " 사원님의 평가를 작성하였습니다." ,
				confirmButtonText: '등록',
				confirmButtonColor: "green",
				icon: "question",
				iconColor: "green",
				showCancelButton: true,
				cancelButtonText: '취소',
				cancelButtonColor: "red"
				}).then((result) => {
					  if (result.isConfirmed) {
						  $.ajax({
					            // 요청
					            type : "post",
					            url : "/empEval",
					            dataType : "json",
					            data : JSON.stringify(pr),
								contentType : 'application/json',
					            // 응답
					            success : function(result) {
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
		}
		/*
		$.ajax({
            // 요청
            type : "post",
            url : "/empEval",
            dataType : "json",
            data : JSON.stringify(pr),
			processData: false,
			contentType : 'application/json; charset=UTF-8',
            // 응답
            success : function(result) {
				//$("#result").text("");
            	
            	
            	
            },
            
			error:function(xhr,status,error) {
				
			}
        });
		*/
		// location.reload();
	});