function addRow() { // 열 추가 함수
		           $("#result").append('<tr></tr>'); // 기본 열 추가
		           for(var i = 0; i < 6; i++) { // 열에 데이터 추가  0 : 사번, 1: 신청날짜(현재날짜로 고정) 2: 휴가 유형, 5 : 사유 나머지 : 날짜 데이터 
		               if(i == 0) $("#result tr").eq(-1).append('<td><input type="text" class="empNo" placeholder="사번 입력"></td>');
		               else if(i == 1) $("#result tr").eq(-1).append('<td><input type="date" class="currentDate" disabled></td>');
					   else if(i == 2) $("#result tr").eq(-1).append('<td><select><option disabled selected>유형선택</option><option value="연차" selected>연차</option><option value="병가">병가</option><option value="경조사">경조사</option><option value="기타">기타</option></select></td>');
					   else if(i == 3) $("#result tr").eq(-1).append('<td><input type="date" id="startDate" class="leaveDate"></td>');
					   else if(i == 4) $("#result tr").eq(-1).append('<td><input type="date" id="endDate" class="leaveDate"></td>');
					   else if(i == 5) $("#result tr").eq(-1).append('<td><input type="text" value="휴가"></td>');
		           }
				   // 열 삭제 버튼 추가 (클래스 btn4)
		           $("#result tr").eq(-1).append('<td><button class="btn4">열 삭제</button></td>'); 
				   // 현재 날짜로 고정 
				     const today = new Date();
				     const year = today.getFullYear();
				     const month = String(today.getMonth() + 1).padStart(2, "0");
				     const day = String(today.getDate()).padStart(2, "0");
					 const todayStr = year+"-"+month+"-"+day;
					 console.log(todayStr);
					 $("#result tr").eq(-1).find(".currentDate").val(todayStr);

				   //$("#result tr").eq(-1).find(".currentDate").val(new Date().toISOString().substring(0, 10));
				   // 입력한 사번으로 고정
				   //const empNoInput = document.querySelector('.empNo');
				   //$("#result tr").eq(-1).find(".empNo").val(empNoInput.value);

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

				   $("#result tr").eq(-1).find(".leaveDate").val(nextStr);
				   
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
				   const startDateInput = document.querySelector('#startDate');
				   const endDateInput = document.querySelector('#endDate');
				   leaveDateInputs.forEach(function(input){
				     input.setAttribute('min', nextStr); // 과거 날짜 선택 제한
					 
				     input.addEventListener('input', function(){
				       const selectedDate = new Date(this.value); // 사용자가 선택한 날짜
				       const day = selectedDate.getDay(); // 사용자가 선택한 날짜 요일로 변환
				       const weekend = (day === 0 || day === 6); // 0: 일, 6: 토 주말
				       const holiday = holidays.includes(this.value); // 공휴일

				       if(weekend || holiday){
				         //alert("주말 및 공휴일 선택불가");
						 Swal.fire({
	 						title: "다른 날짜를 선택해주세요.",
							text: "주말 및 공휴일은 선택이 불가합니다. ",
	 						confirmButtonText: '확인',
	 						width: 600,
	 						confirmButtonColor: "#90C67C",
	 						icon: "warning",
	 						
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
					   $("#result tr").eq(-1).find("#endDate").val(this.value);
				     });			 
				   });
		       };

			   // 삭제 버튼
		       $(document).on("click", ".btn4", function() { // 나중에 생성된 태그 경우 인식이 안되므로 $(document).on을 이용해 인식시켜야함, 클래스로 지정시 클릭한 버튼의 클래스의 이벤트를 따름
		           if($("#result tr").length > 2) $(this).parent().parent().remove(); // this : 현재 태크(button) 부모의 부모는 button -> td -> tr 즉 tr을 삭제(조건은 하나의 열은 남겨둬야되서 걸어둠)
		       });

		       addRow(); // 처음 열은 자동으로 추가

			   // 열 추가 버튼 클릭시 열 추가 함수 addRow 함수 실행
		       $("#btn2").click(() => { 
		           
		           addRow();
		       });
			   
			   $("#btn").click((e) => { // 제출 버튼
				
			               const table = $("#result tr"); // 테이블 정보 획득
			               const liList = []; // 객체를 담을 배열
			               const formData = new FormData();
						   let valid = true;
						   
			           	
			               for(var i = 1; i < table.length; i++){ // i가 1부터 시작하는 이유는 첫번째 열은 th(열의 설명)부분이라 데이터가 아님
			                   const obj ={}; // 직원 하나당 하나의 객체로 생성
							   const empNoVal = $("#result tr").eq(i).find("td").eq(0).find("input").val().trim();

							           if (!empNoVal) { // 사번이 비어있으면
										Swal.fire({
											title: "사번을 입력해주세요!",
											confirmButtonText: '확인',
											width: 600,
											confirmButtonColor: "#90C67C",
											icon: "warning",
											iconColor: "green"
											});
							               valid = false;
							               break; // 더 이상 진행 안 하고 반복문 종료
							           }
			                   for(var j = 0; j <6; j++) { // 객체에 데이터 삽입
			                   	if(j === 0)  obj.empNo = empNoVal; // result의 i번째 tr의 j번째 td 데이터(사원이름,직무이름 등)을 객체에 저장 
			                   	if(j === 1)  obj.requestDate=$("#result tr").eq(i).find("td").eq(j).find("input").val();
			                   	if(j === 2)  obj.leaveType=$("#result tr").eq(i).find("td").eq(j).find("select").val();
			                   	if(j === 3)  obj.startDate=$("#result tr").eq(i).find("td").eq(j).find("input").val();
			                   	if(j === 4)  obj.endDate=$("#result tr").eq(i).find("td").eq(j).find("input").val();
			                   	if(j === 5)  obj.reason=$("#result tr").eq(i).find("td").eq(j).find("input").val();
			                   	if(j === 6)  obj.delete=$("#result tr").eq(i).find("td").eq(j).find("button").val();
			                   }
			                   liList.push(obj); // 정보 저장한 객체를 배열에 삽입  
			               }
						   
						   
			               //console.log(JSON.stringify(liList));
			               $.ajax({
			                   // 요청
			                   type : "post",
			                   url : "/leaveAdd",
			                   dataType : "json", // dataType 지정해줘야 자바에서 인식
			                   data : JSON.stringify(liList), // json문자열로 변환해서 전송
			   				processData: false,
			   				contentType: 'application/json; charset=UTF-8', // formData에서는 false였으나 여기서는 contentType을 지정해줘야함
			                   // 응답
			                   success : function(result) {
								Swal.fire({
					   					title: "휴가를 등록 하시겠습니까?",
					   					confirmButtonText: '등록',
					   					confirmButtonColor: "green",
					   					icon: "question",
					   					iconColor: "green",
					   					showCancelButton: true,
					   					cancelButtonText: '취소',
					   					cancelButtonColor: "red"
					   					}).then((result) => {
					   						  if (result.isConfirmed) {
								Swal.fire({
											icon: "success",
											iconColor: "green",
										  title: "등록 되었습니다!",
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
										}
									});
										
									},
									error:function(xhr, status, error){
										
									}
								});
								
							});