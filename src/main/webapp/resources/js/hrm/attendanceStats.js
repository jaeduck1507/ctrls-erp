$("#showBtn").click(() =>{
			const empNo = $("#empNo").val();
			const yearMonth = $("#yearMonth").val();
			const today = new Date();
			const year = today.getFullYear();
			const month = String(today.getMonth() + 1).padStart(2, "0");
			if(empNo == -1 ||  !yearMonth) {
				Swal.fire({
					title: "정보를 입력해주세요",
					confirmButtonText: '확인',
					width: 500,
					confirmButtonColor: "#90C67C",
					icon: "warning",
					iconColor: "green"
					});
			} else if(Number(yearMonth.split("-")[0]) > year || (Number(yearMonth.split("-")[0]) == year && Number(yearMonth.split("-")[1]) > Number(month) ) || !(yearMonth)) {
				Swal.fire({
					title: "날짜를 확인해주세요!",
					confirmButtonText: '확인',
					confirmButtonColor: "#90C67C",
					icon: "warning",
					iconColor: "green"
					});
			}
			else {
				const obj = {};
				obj.empNo = empNo;
				obj.yearMonth = yearMonth;
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/attendanceStats",
	            dataType : "json", 
                data : JSON.stringify(obj),
				processData: false,
				contentType: 'application/json; charset=UTF-8',
				
	            // 응답
	            success : function(result) {
					
					$("#result").html("");
	            	$("#result").append("<tr><th>월</th><th>총일수</th><th>출근일수</th><th>지각일수</th><th>조퇴일수</th><th>결근일수</th><th>휴가일수</th></tr>");
                	
					var text = "<tr><td>"+ result.month +"월</td><td>"+result.totalCount+"일</td><td>"+ result.workCount +"일</td><td>"+ result.lateCount +"일</td><td>"+result.leaveEarlyCount+"일</td><td>"
					+result.absenceCount+"일</td><td>" + result.leaveCount+"일</td></tr>"
					$("#result").append(text);
                	
                	
	            	
	            	
	            },
	            
				error:function(xhr,status,error) {
					
				}
	        });
			}
	    });