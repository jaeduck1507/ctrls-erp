$("#showBtn").click(() =>{
			const yearMonth = $("#yearMonth").val();
			const today = new Date();
			const year = today.getFullYear();
			const month = String(today.getMonth() + 1).padStart(2, "0"); 
			console.log(month);
			
			if(Number(yearMonth.split("-")[0]) > year || (Number(yearMonth.split("-")[0]) == year && Number(yearMonth.split("-")[1]) > Number(month) ) || !(yearMonth)) {
				Swal.fire({
					title: "날짜를 확인해주세요!",
					confirmButtonText: '확인',
					confirmButtonColor: "#90C67C",
					icon: "warning",
					iconColor: "green"
					});
			} else {
				const obj = {};
				obj.yearMonth = yearMonth;
				$.ajax({
		            // 요청
		            type : "post",
		            url : "/showMyAttendance",
		            dataType : "json", 
	                data : JSON.stringify(obj),
					processData: false,
					contentType: 'application/json; charset=UTF-8',
					
		            // 응답
		            success : function(result) {
						$("#result").html("");
		            	$("#result").append("<tr><th>사원번호</th><th>출근일자</th><th>출근시각</th><th>퇴근시간</th><th>상태</th></tr>");
	                	for(const log of result) {
						var text = "<tr><td>"+ log.empNo +"</td><td>"+log.workDate+"</td><td>"+(log.checkIn==null?"":log.checkIn)+"</td><td>"+(log.checkOut==null?"":log.checkOut)+"</td><td>"+log.status+"</td></tr>"
						$("#result").append(text);
	                	
	                	}
		            	
		            	
		            },
		            
					error:function(xhr,status,error) {
						
					}
		        });
			}
			
	    });