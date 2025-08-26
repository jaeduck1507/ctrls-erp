
		// 휴가시작일, 종료일 신청날짜 다음날로 고정(다음날부터 신청가능하도록)
	   const tomorrow = new Date();
	   tomorrow.setDate(tomorrow.getDate() + 1);
	   const tomorrowStr = tomorrow.toISOString().substring(0, 10);
		
		// 과거시간, 주말, 공휴일 선택 제한
	   const holidays = [// 막을 공휴일 목록
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
	   const endDateInput = document.querySelector('#endDate');

	   leaveDateInputs.forEach(function(input){
	     input.setAttribute('min', tomorrowStr); // 과거 날짜 선택 제한

	     input.addEventListener('input', function(){
	       const selectedDate = new Date(this.value); // 사용자가 선택한 날짜
	       const day = selectedDate.getDay(); // 사용자가 선택한 날짜 요일로 변환
	       const isWeekend = (day === 0 || day === 6); // 0: 일, 6: 토 주말
	       const isHoliday = holidays.includes(this.value); // 공휴일

	       if(isWeekend || isHoliday){
			Swal.fire({
				title: "주말 및 공휴일은 선택이 불가합니다. 다른 날짜를 선택해주세요.",
				confirmButtonText: '확인',
				width: 600,
				confirmButtonColor: "#90C67C",
				icon: "check",
				iconColor: "green"
				});
	         this.value = tomorrowStr; // 날짜 초기화
	         return;
	       }
		   // 휴가 종료일은 휴가 시작일부터 가능하도록 제어
		   endDateInput.setAttribute('min', this.value);
	     });
	   });