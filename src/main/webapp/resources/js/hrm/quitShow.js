const pagingDto ={};
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
					
					if (!result.quitterList || result.quitterList.length === 0) {
							alert("조회된 결과가 없습니다");
							location.reload();
						}
					$("#result").empty();
					$("#result").append("<tr><th>이름</th><th>퇴사일</th><th>퇴직금</th><th>퇴직금지급날짜</th></tr>");
					for(const quitter of result.quitterList) {
					var text = "<tr><td>"+ quitter.empName +"</td><td>" +quitter.quitDate +"</td><td>"+quitter.quitPay+"</td><td>"+quitter.quitPayDate+"</td></tr>";
					$("#result").append(text);
                	}
					// 페이징 생성
                	$(".pagination").html('');
                	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
                	for(var i =result.startPage; i<=result.endPage; i++) {
                		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
                	}
                	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
                
				},
				
				error:function(xhr, status, error){
					
				}
			})
		});
		
		$(document).on('click', 'a.page-link', function(e) {
			e.preventDefault();
			const formData = new FormData();
			formData.append("empName", $('#quitName').val());
			formData.append("page",$(this).attr('href'));
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
					for(const quitter of result.quitterList) {
					var text = "<tr><td>"+ quitter.empName +"</td><td>" +quitter.quitDate +"</td><td>"+quitter.quitPay+"</td><td>"+quitter.quitPayDate+"</td></tr>";
					$("#result").append(text);
			    	}
					// 페이징 생성
			    	$(".pagination").html('');
			    	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
			    	for(var i =result.startPage; i<=result.endPage; i++) {
			    		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
			    	}
			    	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
			    
				},
				
				error:function(xhr, status, error){
					
				}
			})			
		});