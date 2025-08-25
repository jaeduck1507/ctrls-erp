$(".btnO").click((e)=>{
			const formData = new FormData();
								formData.append("status", "승인");
								formData.append("leaveId", $(e.target).parent().parent().find("td").eq(0).text());
								//console.log($("#result tr").eq(i).find("td").eq(0).find("input").val());
			Swal.fire({
					title: "승인하시겠습니까?",
					confirmButtonText: '등록',
					confirmButtonColor: "green",
					icon: "question",
					iconColor: "green",
					showCancelButton: true,
					cancelButtonText: '취소',
					cancelButtonColor: "red"
					}).then((result) => {
						  if (result.isConfirmed) {
					//location.reload(); // 승인 버튼 누르면 자동 새로고침
					$.ajax({
						// 요청
						type : "post",
						url : "/leaveStatusUpdate",
						data : formData, 
						processData : false,
					    contentType : false,
						// 응답
						success : function(result) {
							//location.reload();
							let timerInterval;
							Swal.fire({
								icon: "success",
								iconColor: "green",
							  title: "승인되었습니다!",
							  html: '<span id="aa"></span>초 후 자동으로 닫힙니다.',
							  timer: 3000,
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
						error:function(xhr, status, error){
							
						}
					});
					}
					})
				});
				
				$(".btnX").click((e)=>{
									const formData = new FormData();
									formData.append("status", "반려");
									formData.append("leaveId", $(e.target).parent().parent().find("td").eq(0).text());
									//location.reload(); // 반려 버튼 누르면 자동 새로고침
									Swal.fire({
										title: "반려하시겠습니까?",
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
										url : "/leaveStatusUpdate",
										data : formData, 
										processData : false,
									    contentType : false,
										// 응답
										success : function(result) {
											let timerInterval;
										Swal.fire({
											icon: "success",
											iconColor: "green",
										  title: "반려되었습니다!",
										  html: '<span id="aa"></span>초 후 자동으로 닫힙니다.',
										  timer: 3000,
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
									error:function(xhr, status, error){
										
									}
								});
								}
								})
							});