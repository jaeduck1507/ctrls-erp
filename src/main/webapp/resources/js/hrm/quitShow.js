$("#btn").click(()=>{
			
			const formData = new FormData();
			formData.append("empName", $('#quitName').val());
			$.ajax({
				// 요청
				type : "post", 
				url : "/quitShow", 
				data : formData,
				processData : false,
				contentType : false,
				// 응답
				success : function(result) {
					//$("#result").text("");
					$("#result").empty();
					$("#result").append("<tr><th>이름</th><th>퇴사일</th><th>퇴직금</th><th>퇴직금지급날짜</th></tr>");
					for(const quitter of result) {
					var text = "<tr><td>"+ quitter.empName +"</td><td>" +quitter.quitDate +"</td><td>"+quitter.quitPay+"</td><td>"+quitter.quitPayDate+"</td></tr>";
					$("#result").append(text);
					}
				},
				
				error:function(xhr, status, error){
					
				}
			})
		})