
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
							   + "</td><td style='" + (leaveInfo.status == "승인"? "color:#0065F8": leaveInfo.status === "대기"? "color:#FFA62F" : "color:#7A7A73")+"'>" + leaveInfo.status 
							   + "</td><td>" + leaveInfo.empName 
							   + "</td><td>" + leaveInfo.deptName
							   + "</td><td>" + leaveInfo.jobTitle 
							   + "</td><td><a id='btn1' href='/hrm/leaveView?leaveId=" + leaveInfo.leaveId + "' class='" + (leaveInfo.status === "승인"|| leaveInfo.status === "반려" ? "disable" : "btnO") + "'>수정</a></td><td><a id='btn2' href='/hrm/leaveDelete?leaveId="+ leaveInfo.leaveId +"' class='" + (leaveInfo.status === "승인" || leaveInfo.status === "반려"? "disable" : "btnX") + "'>삭제</a></td></tr>"
				$("#result").append(text);
				}
			},
			error:function(xhr, status, error){
				Swal.fire({
					title: "사번을 입력해주세요!",
					confirmButtonText: '확인',
					width: 600,
					confirmButtonColor: "#90C67C",
					icon: "warning",
					iconColor: "green"
					});
			}
		});
	});
	$(document).on('click', 'a.btnX', function(e) {
		e.preventDefault();
		/*if (confirm("정말 삭제하시겠습니까?")) {
			location.href = $(this).attr("href");
		}*/
		
		Swal.fire({
			title: "정말 삭제하시겠습니까?",
			text: "삭제를 누르면 해당 항목이 영구적으로 삭제됩니다.",
			icon: "warning",
			iconColor: "#f1a025",
			showCancelButton: true,
			confirmButtonColor: "#48b85b",
			cancelButtonColor: "#d33",
			confirmButtonText: "삭제",
			cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				Swal.fire({
					title: "삭제 완료!",
					text: "성공적으로 삭제되었습니다.",
					icon: "success",
					timer: 3000,
					timerProgressBar: true,
					didClose: () => {
						location.href = $(this).attr("href");
					}
				});
			}
		});
	});
	
	