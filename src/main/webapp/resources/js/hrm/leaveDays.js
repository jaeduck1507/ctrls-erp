// 조회 버튼 클릭 시 정보 출력
		$("#btn").click(()=>{
			
			const formData = new FormData();
			formData.append("empNo", $('#empNo').val());
			
			
			$("#result").empty();
			// 사원 정보 조회
			$.ajax({
				// 요청
				type : "post",
				url : "/leaveDays",
				data : formData, 
				processData : false,
			    contentType : false,
				// 응답
				success : function(result) {
					$('.box').css('background-color', '#F5F5F5');
					for(const leaveDays of result) {
						var text = "<tr><th><i class='fi fi-rr-id-badge'></i>&nbsp;&nbsp;사번</th><td><b>" + leaveDays.empNo
							       + "</td><tr><th><i class='fi fi-rr-letter-case'></i>&nbsp;&nbsp;사원명</th><td><b>" + leaveDays.empName
							       + "<b></td><tr><th><i class='fi fi-rr-briefcase'></i>&nbsp;&nbsp;&nbsp;&nbsp;부서</th><td><b>" + leaveDays.deptName 
								   + "<b></td><tr><th><i class='fi fi-rr-sitemap'></i>&nbsp;&nbsp;직급</th><td><b>" + leaveDays.jobTitle 
					               + "<b></td><tr><th><i class='fi fi-rr-umbrella-beach'>&nbsp;&nbsp;</i>올해 받은 휴가일수</th><td><b>12일<b></td>";
					$("#result").append(text);
					}
					// 휴가 누적 사용일 수,  첫번째 ajax요청 다음에 실행되도록
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
							  var text = "<tr><th><i class='fi fi-rr-calendar-check'></i>&nbsp;&nbsp;휴가 누적 사용일수</th><td><b>" + leaveTotalDays.totalDays + "일<b></td></tr>"
						             + "<tr><th><i class='fi fi-rr-calendar'>&nbsp;&nbsp;</i>남은 휴가일수</th><td><b>" + (12-leaveTotalDays.totalDays)  + "일<b></td></tr>";
					       } else {
								var text = "<tr><th><i class='fi fi-rr-calendar-check'></i>&nbsp;&nbsp;</i>휴가 누적 사용일수</th><td><b>0일<b></td></tr>"
							             + "<tr><th><i class='fi fi-rr-calendar'>&nbsp;&nbsp;</i>남은 휴가일수</th><td><b>12일<b></td></tr>";
							   
						} 
						$("#result").append(text);
					}
				},
				error:function(xhr, status, error){
						
					}
					});
				},
				error:function(xhr, status, error){
					//alert("사번입력!");
					Swal.fire({
						title: "사번을 입력해주세요!",
						confirmButtonText: '확인',
						width: 600,
						confirmButtonColor: "#90C67C",
						icon: "warning",
						iconColor: "green"
						});
				}
			})
		});

			