function checkAtt() { // 출퇴근 현황 ajax로 보기
		$.ajax({ 
	        url: '/showAttendanceOneAtToday',
	        method: 'post',
	        success: function(response) {
	            console.log(response.checkIn);
	            console.log(response.checkOut);
	            // console.log('데이터 성공적으로 받아옴:', response);
	            if(!response) {
					// 출근 X 퇴근 X
					console.log("출근 X 퇴근 X");
					$("#start_work").prop('disabled', false);
					$("#finish_work").prop('disabled', true);
	            } else {
					if(response.status == "휴가") {
						$("#status").text("휴가");
						$("#start_work").prop('disabled', true);
						$("#finish_work").prop('disabled', true);
						
					}
					else if(response.checkOut != null) {
		            	console.log("출근 O 퇴근 O");
						$("#start_work").prop('disabled', true);
						$("#finish_work").prop('disabled', true);
						$("#checkIn").text(response.checkIn);
						$("#checkOut").text(response.checkOut);
		            }
		            else if(response.checkIn != null) {
		            	console.log("출근 O 퇴근 X");
						$("#start_work").prop('disabled', true);
						$("#finish_work").prop('disabled', false);
						$("#checkIn").text(response.checkIn);
		            } 
	            }
	        },
	        error: function(error) {
	        }
	    });
	}
	
	
	$("#start_work").click(() =>{
		const checkIn = $("#checkTime").val();
		const obj = {};
		obj.checkIn = checkIn;
		$.ajax({
            type : "post",
            url : "/startWorking",
            dataType : "json", 
            data : JSON.stringify(obj),
			processData: false,
			contentType: 'application/json; charset=UTF-8',
			
            success : function(result) {
            	Swal.fire({
        			title: "출근 완료 (출근시간 : "+ checkIn +")",
        			confirmButtonText: '확인',
        			width: 600,
        			confirmButtonColor: "#90C67C",
        			icon: "warning",
        			iconColor: "green"
        			});
            	
            	checkAtt(); // 출퇴근 현황 비동기 처리로 업데이트
            	
            	
            },
            
			error:function(xhr,status,error) {
				
			}
        });
    });
	
	$("#finish_work").click(() =>{
		const checkOut = $("#checkTime").val();
		const obj = {};
		obj.checkOut = checkOut;
		$.ajax({
            type : "post",
            url : "/finishWorking",
            dataType : "json", 
            data : JSON.stringify(obj),
			processData: false,
			contentType: 'application/json; charset=UTF-8',
			
            success : function(result) {

            	Swal.fire({
        			title: "퇴근 완료 (퇴근시간 : "+ checkOut +")",
        			confirmButtonText: '확인',
        			width: 600,
        			confirmButtonColor: "#90C67C",
        			icon: "warning",
        			iconColor: "green"
        			});
            	checkAtt(); // 출퇴근 현황 비동기 처리로 업데이트
            	
            },
            
			error:function(xhr,status,error) {
				
			}
        });
    });
	
	function isOver10(num) { // 시 분 초에 0 패딩
		  return num < 10 ? '0' + num : num;
		}
	
	const nowtime = () => { // 실시간 시간 받아오기
		  const day = ["일", "월", "화", "수", "목", "금", "토"]; // now.getDay()로 인덱스 지정
		  const now = new Date(); // 현재 시각
		  

		  
		  
		  
		  
		  // 초기 화면 표시
		  // 초기 화면 : 현재 시간 및 남은 시간
		  ymd.textContent = now.getFullYear() + "년 " + (now.getMonth() + 1) + "월 " + now.getDate() + "일 (" + day[now.getDay()] + ")";
		  timer.textContent = isOver10(now.getHours()) + ":" + isOver10(now.getMinutes()) + ":" + isOver10(now.getSeconds());

		 
		};
		
	setInterval(() => { // 1초에 한번씩 업데이트
	nowtime(); 
	}
	, 1000);
	
	
	nowtime(); // 처음에 바로 실시간 시간 받아오기
	checkAtt(); // 처음에 바로 출퇴근 현황 보여주기