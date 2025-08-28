$(".btnO").click((e)=>{
			const formData = new FormData();
								formData.append("status", "승인");
								formData.append("leaveId", $(e.target).parent().parent().find("td").eq(0).text());
								formData.append("startDate", $(e.target).parent().parent().find("td").eq(3).text());
								formData.append("endDate", $(e.target).parent().parent().find("td").eq(4).text());
								formData.append("empNo", $(e.target).parent().parent().find("td").eq(6).text());
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
				   					title: "휴가 승인 완료",
				   					icon: "success",
				   					timer: 3000,
				   					timerProgressBar: true,
				   					didClose: () => {
				   						location.href = $(this).attr("href");
				   					}
				   				}).then(() => location.reload());
							
							
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
							   					title: "휴가 반려 완료",
							   					icon: "success",
							   					timer: 3000,
							   					timerProgressBar: true,
							   					didClose: () => {
							   						location.href = $(this).attr("href");
							   					}
							   				}).then(() => location.reload());
										
										
									},
									error:function(xhr, status, error){
										
									}
								});
								}
								})
							});