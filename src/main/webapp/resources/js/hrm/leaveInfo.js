
	$("#btn").click(()=>{
		const formData = new FormData();
		formData.append("empNo", $('#empNo').val());
		formData.append("status", $('#status').val());
		
		$.ajax({
			// 요청
			type : "post",
			url : "/leaveInfo",
			data : formData, 
			processData : false,
		    contentType : false,
			// 응답
			success : function(result) {
				$("#result").empty();
				$("#result").append("<tr><th>신청번호</th><th>신청날짜</th><th>유형</th><th>시작일</th><th>종료일</th><th>이유</th><th>상태</th><th>사원명</th><th>부서</th><th>직급</th><th>수정</th><th>삭제</th></tr>");
				for(const leaveInfo of result) {
					var text = "<tr><td>" + leaveInfo.leaveId
						       + "</td><td>" + leaveInfo.requestDate 
						       + "</td><td>" + leaveInfo.leaveType 
							   + "</td><td>" + leaveInfo.startDate 
							   + "</td><td>" + leaveInfo.endDate 
							   + "</td><td>" + leaveInfo.reason
							   + "</td><td>" + leaveInfo.status 
							   + "</td><td>" + leaveInfo.empName 
							   + "</td><td>" + leaveInfo.deptName
							   + "</td><td>" + leaveInfo.jobTitle 
							   + "</td><td><a id='btn1' href='/hrm/leaveView?leaveId=" + leaveInfo.leaveId + "' class='btnO'>수정</a></td><td><a id='btn2' href='/hrm/leaveDelete?leaveId="+ leaveInfo.leaveId +"' class='btnX'>삭제</a></td></tr>"
				$("#result").append(text);
				}
			},
			error:function(xhr, status, error){
				
			}
		})
	})
	