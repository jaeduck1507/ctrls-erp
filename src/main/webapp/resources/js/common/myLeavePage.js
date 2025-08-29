			$(document).ready(()=>{
				const formData = new FormData();
				formData.append("empNo", $('#empNoSearch').val());
			  // 휴가 누적 사용일수, 남은 휴가일수
		      $.ajax({
					// 요청
					type : "post",
					url : "/leaveTotalDays",
					data : formData, 
					processData : false,
				    contentType : false,
					// 응답
					success : function(result) {
						
						  for(const leaveTotalDays of result) {
							if(leaveTotalDays && leaveTotalDays.empNo !== null) {
							  var text = "<i class='fi fi-rr-calendar-check'></i>&nbsp;&nbsp;휴가 누적 사용일수&nbsp;&nbsp;<b>" + leaveTotalDays.totalDays + "일</b>&nbsp;&nbsp;&nbsp;&nbsp; "
						             + "<i class='fi fi-rr-calendar'></i>&nbsp;&nbsp;남은 휴가일수&nbsp;&nbsp;<b>" + (12-leaveTotalDays.totalDays)  + "일</b>&nbsp;&nbsp;&nbsp;&nbsp;";
					       } else {
								var text = "<i class='fi fi-rr-calendar-check'></i>&nbsp;&nbsp;휴가 누적 사용일수 : <b>0일</b>&nbsp;&nbsp;&nbsp;&nbsp; "
							             + "<i class='fi fi-rr-calendar'></i>&nbsp;&nbsp;남은 휴가일수 : <b>12일</b>&nbsp;&nbsp;&nbsp;&nbsp;";
							   
						} 
						$("#result1").append(text);
					}
				},
				error:function(xhr, status, error){
						
					}
			});
		});
		const $status = $("#status");
		const $table = $("#result2");
		const $pagination = $(".pagination");
		
		let currentPage = 1;
		let currentLimit = 5;
		let currentStatus = "all"; // 처리 상태 기본 "전체" 
		

		  function Pagination(result) {
		    $table.html("");
		    $table.append(
		      "<tr>" +
		        "<th>신청번호</th>" +
		        "<th>신청날짜</th>" +
		        "<th>유형</th>" +
		        "<th>시작일</th>" +
		        "<th>종료일</th>" +
		        "<th>이유</th>" +
		        "<th>상태</th>" +
		        "<th>수정</th>" +
		        "<th>삭제</th>" +
		      "</tr>"
		    );

		    // 2) 목록 행 추가
		    if (result.list && result.list.length > 0) {
		      for (const row of result.list) {
				
		        const tr =
		          "<tr>" +
		            "<td>" + row.leaveId    + "</td>" +
		            "<td>" + row.requestDate+ "</td>" +
		            "<td>" + row.leaveType  + "</td>" +
		            "<td>" + row.startDate  + "</td>" +
		            "<td>" + row.endDate    + "</td>" +
		            "<td>" + row.reason     + "</td>" +
		            "<td style='" + (row.status == "승인"? "color:#0065F8": row.status === "대기"? "color:#FFA62F" : "color:#7A7A73")+"'>" + row.status + "</td>" +
		            "<td><a href='/myLeaveView?leaveId=" + row.leaveId + "' class='" + (row.status === "승인" || row.status === "반려"? "disable" : "btnO") + "'>수정</a></td>" +
		            "<td><a href='/myLeaveDelete?leaveId="+ row.leaveId +"' class='" + (row.status === "승인" || row.status === "반려" ? "disable" : "btnX") + "'>삭제</a></td>" +
		          "</tr>";
		        $table.append(tr);
		      }
		    } else {
		      // 데이터 없을 때 안내
		      $table.append("<tr><td colspan='9' style='text-align:center'>데이터가 없습니다.</td></tr>");
		    }

		    $pagination.html("");

		    // 이전 버튼
		    const prevDisabled = result.prev ? "" : " disabled";
		    $pagination.append(
		      "<li class='page-item" + prevDisabled + "'>" +
		        "<a class='page-link' href='#' data-page='" + (result.startPage - 1) + "'>Previous</a>" +
		      "</li>"
		    );

		    // 페이지 번호 버튼
		    for (let i = result.startPage; i <= result.endPage; i++) {
		      const active = (i === result.page) ? " active" : "";
		      $pagination.append(
		        "<li class='page-item" + active + "'>" +
		          "<a class='page-link' href='#' data-page='" + i + "'>" + i + "</a>" +
		        "</li>"
		      );
		    }

		    // 다음 버튼
		    const nextDisabled = result.next ? "" : " disabled";
		    $pagination.append(
		      "<li class='page-item" + nextDisabled + "'>" +
		        "<a class='page-link' href='#' data-page='" + (result.endPage + 1) + "'>Next</a>" +
		      "</li>"
		    );
		  }

		  function leaveInfoPage(page = 1, status = "all") {
		    // 현재 상태 저장
		    currentPage = page;
		    currentStatus = status;

		    $.ajax({
		      type: "get",               
		      url: "/leaveInfo",
		      data: {
		        page: page,              // 현재 페이지
		        limit: currentLimit,     // 한 페이지 개수
		        status: status           
		      },
		      success: function(result) {
		        Pagination(result);
		      },
		      error: function(xhr) {
		        
		      }
		    });
		  }

		  //상태 셀렉트 변경 시 1페이지부터 다시 조회
		  $status.on("change", function() {
		    leaveInfoPage(1, $(this).val()); // 항상 1페이지로
		  });

		  // 페이지 버튼 클릭
		  $pagination.on("click", "a.page-link", function(e) {
		    e.preventDefault();
		    const page = parseInt($(this).data("page"), 10);
		      leaveInfoPage(page, currentStatus);
		  });

		  $(document).ready(function() {
		    // 페이지 진입 시 "전체" 상태로 1페이지 조회
		    leaveInfoPage(1, "all");
			
		  });
		  
		
	            
	// 휴가 신청
	    // 승인된 휴가 가져오기
		
		// 신청날짜 현재 날짜로 고정 
		 const today = new Date();
	     const year = today.getFullYear();
	     const month = String(today.getMonth() + 1).padStart(2, "0");
	     const day = String(today.getDate()).padStart(2, "0");
		 const todayStr = year+"-"+month+"-"+day;
		$("#currentDate").val(todayStr);
		
		// 휴가시작일, 종료일 신청날짜 다음날로 고정(다음날부터 신청가능하도록)
		// 내일부터 신청 가능
		let tomorrow = new Date();
		tomorrow.setDate(today.getDate() + 1);

		// 내일이 주말이면 다음 월요일로 이동
		let dayOfWeek = tomorrow.getDay(); // 0=일, 6=토
		if (dayOfWeek === 6) { 
		  // 토요일이면 +2일 → 월요일
		  tomorrow.setDate(tomorrow.getDate() + 2);
		} else if (dayOfWeek === 0) { 
		  // 일요일이면 +1일 → 월요일
		  tomorrow.setDate(tomorrow.getDate() + 1);
		}
	     const nextYear = tomorrow.getFullYear();
	     const nextMonth = String(tomorrow.getMonth() + 1).padStart(2, "0");
	     const nextDay = String(tomorrow.getDate()).padStart(2, "0");
		 const nextStr = nextYear+"-"+nextMonth+"-"+nextDay;
		$(".leaveDate").val(nextStr);
	   
	   // 과거시간, 주말, 공휴일 선택 제한
   	   const holidays = [// 제한할 공휴일 목록
   	     "2025-08-15", // 광복절
   	     "2025-10-03", // 개천절
   		 "2025-10-06", // 추석
   		 "2025-10-07", // 추석연휴
   		 "2025-10-08", // 대체 휴일
   		 "2025-10-09", // 한글날
   		 "2025-12-25", // 크리스마스
   		 "2026-01-01"  // 신정
   	   ];
	   
	   const leaveDateInputs = document.querySelectorAll('.leaveDate');
 	   const startDateInput = document.getElementById('startDate');
 	   const endDateInput = document.getElementById('endDate');
	   
	   leaveDateInputs.forEach(function(input){
			 input.setAttribute('min', nextStr); // 과거 날짜 선택 제한
			 
			 input.addEventListener('input', function(){
				const selectedDate = new Date(this.value); // 사용자가 선택한 날짜
		        const day = selectedDate.getDay(); // 사용자가 선택한 날짜 요일로 변환
		        const weekend = (day === 0 || day === 6); // 0: 일, 6: 토 주말
		        const holiday = holidays.includes(this.value); // 공휴일
				
				
				   
				if(weekend || holiday){
					Swal.fire({
						title: "다른 날짜를 선택해주세요.",
						text: "주말 및 공휴일은 선택이 불가합니다.",
						confirmButtonText: '확인',
						width: 600,
						confirmButtonColor: "#90C67C",
						icon: "warning"
						});
					this.value = nextStr; // 날짜 기본값(신청날짜 다음날)으로 초기화
					endDateInput.value = startDateInput.value;
					return;
				 }
				 //console.log("휴가 시작일 : " + startDateInput.value);
	 		     //console.log("휴가 종료일 : " + endDateInput.value);
	 		 
	 		     // 휴가 종료일은 사용자가 선택한 휴가 시작일부터 가능하도록 제어
	 		     endDateInput.setAttribute('min', startDateInput.value);
	 		     // 사용자가 휴가 시작일 변경하면 휴가 종료일 가능일로 자동변경
	 		     $("#endDate").val(this.value);
			
			 });
			 
	   });
			  
	$("#btn2").click(() => { // 휴가 제출 버튼
  	   	  const empNo = $(".empNo").val();
		  const currentDate = $("#currentDate").val();
		  const select = $("#select").val();
		  const startDate = $("#startDate").val();
		  const endDate = $("#endDate").val();
		  const reason = $("#reason").val();

		  //console.log(empNo);
		  //console.log(currentDate);
		  //console.log(select);
		  //console.log(startDate);
		  //console.log(endDate);
		  //console.log(reason);

		  Swal.fire({
				title: "휴가를 신청 하시겠습니까?",
				confirmButtonText: '신청',
				confirmButtonColor: "green",
				icon: "question",
				iconColor: "green",
				showCancelButton: true,
				cancelButtonText: '취소',
				cancelButtonColor: "red"
		}).then((result) => {
			  if (result.isConfirmed) {
				// 사용자가 등록을 눌렀을 경우에만 서버요청
	        $.ajax({
			// 요청
			type : "post",
			url : "/myLeaveAdd",
			data : JSON.stringify([{
				"empNo" : empNo,
				"requestDate" : currentDate, 
				"leaveType" : select,
				"startDate" : startDate,
				"endDate" : endDate,
				"reason" : reason,
		   }]),
		   contentType: 'application/json; charset=UTF-8', // formData에서는 false였으나 여기서는 contentType을 지정해줘야함
	       // 응답
		    success: function(response) {
		                       if (response === "success") {
								Swal.fire({
					   					title: "휴가 신청 완료!",
					   					text: "성공적으로 신청되었습니다.",
					   					icon: "success",
					   					timer: 3000,
					   					timerProgressBar: true,
					   					didClose: () => {
					   						location.href = $(this).attr("href");
					   					}
					   				}).then(() => location.reload());
		                       } else if (response === "overlap") {
		                           Swal.fire({
		                               title: "다른 날짜를 선택해주세요.",
		                               text: "이미 신청 또는 승인된 휴가일 입니다.",
		                               confirmButtonText: '확인',
		                               width: 600,
		                               confirmButtonColor: "#90C67C",
		                               icon: "warning"
		                           });
		                       } else if (response === "exceed") {
		                           Swal.fire({
		                               title: "휴가일수를 확인해주세요.",
		                               text: "남은 휴가일수를 초과했습니다.",
		                               confirmButtonText: '확인',
		                               width: 600,
		                               confirmButtonColor: "#90C67C",
		                               icon: "warning"
		                           });
		                       }
		                   },
		                   error: function(xhr, status, error) {
		                       console.error(error);
							   Swal.fire({
	                               title: "휴가 날짜를 선택해주세요!",
	                               confirmButtonText: '확인',
	                               width: 600,
	                               confirmButtonColor: "#90C67C",
	                               icon: "warning"
	                           });
		                   }
		               });
		           }
		           // 취소를 누르면 서버 호출 없음 → 저장 안 됨
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
			
			
