<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 조회 및 신청</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/myLeavePage.css"/>
</head>
<body>
	<h5>[마이페이지] > [휴가 조회 및 신청]</h5>
	<h3>휴가 조회 및 신청</h3>
	<div class="box">
		<!-- &nbsp; : span에서 띄어쓰기 적용-->
		<span>올해 받은 휴가일수&nbsp;&nbsp;<b>12일</b>&nbsp;&nbsp;</span>
		<span id="result1"></span>
	</div>
	
		<div class="box2">
		<h4>휴가 신청</h4>

	   <div class="filter-bar">
	      <input type="hidden" class="empNo" value="${user.empNo}">
		  휴가 신청일 <input type="date" id="currentDate" disabled>
		  휴가 유형 <select id="select">
				       <option disabled>유형선택</option>
					   <option value="연차" selected>연차</option>
					   <option value="병가">병가</option>
					   <option value="경조사">경조사</option>
					   <option value="기타">기타</option>
			      </select>	  
		  휴가 시작일 <input type="date" id="startDate" class="leaveDate">
		  휴가 종료일 <input type="date" id="endDate" class="leaveDate">
		  사유 <input type="text" id="reason" value="휴가" placeholder="사유 입력"/>
		  <button id="btn2">휴가 등록</button>
		  </div>

		  </div>
		  <div class="box2">
		  		<h4>휴가 처리 현황</h4>
		     <div class="filter-bar">
		  	
		  	  휴가 처리 상태 <select name="status" id="status">
		  	   			<option value="all">전체</option>
		  	   			<option value="wait">대기</option>
		  	   			<option value="approve">승인</option>
		  	   			<option value="back">반려</option>
		  	   		</select>
		  	 	<input type="hidden" id="empNoSearch" value="${user.empNo}">
		  		<button id="btn1">조회</button></br>
		  		</div>
		  		<div>
		   		<table border="1" id="result2" class="data-table"></table>
		  		</div>
		  		</div>
	 

	<script>
		// 조회 버튼 클릭 시 정보 출력
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
						  var text = "휴가 누적 사용일수&nbsp;&nbsp;<b>" + leaveTotalDays.totalDays + "일</b>&nbsp;&nbsp;&nbsp;&nbsp; "
					             + "남은 휴가일수&nbsp;&nbsp;<b>" + (12-leaveTotalDays.totalDays)  + "일</b>&nbsp;&nbsp;&nbsp;&nbsp;";
				       } else {
							var text = "휴가 누적 사용일수 : <b>0일</b>&nbsp;&nbsp;&nbsp;&nbsp; "
						             + "남은 휴가일수 : <b>12일</b>&nbsp;&nbsp;&nbsp;&nbsp;";
						   
					} 
					$("#result1").append(text);
				}
				// 휴가 전체 조회
			$.ajax({
				// 요청
				type : "post",
				url : "/leaveInfo",
				data : formData, 
				processData : false,
			    contentType : false,
				// 응답
				success : function(result) {
					$("#result2").empty();
					$("#result2").append("<tr><th>신청번호</th><th>신청날짜</th><th>유형</th><th>시작일</th><th>종료일</th><th>이유</th><th>상태</th><th>수정</th><th>삭제</th></tr>");
					for(const leaveInfo of result) {
						var text = "<tr><td>" + leaveInfo.leaveId
							       + "</td><td>" + leaveInfo.requestDate 
							       + "</td><td>" + leaveInfo.leaveType 
								   + "</td><td>" + leaveInfo.startDate 
								   + "</td><td>" + leaveInfo.endDate 
								   + "</td><td>" + leaveInfo.reason
								   + "</td><td>" + leaveInfo.status 
								   + "</td><td><a id='btn1' href='/myLeaveView?leaveId=" + leaveInfo.leaveId + "' class='btnO'>수정</a></td><td><a id='btn2' href='/myLeaveDelete?leaveId="+ leaveInfo.leaveId +"' class='btnX'>삭제</a></td></tr>";
					$("#result2").append(text);
					}
				// 휴가 처리 상태로 조회
				// 처리상태 조회			
				$("#btn1").click(()=>{
					const formData = new FormData();
					    formData.append("empNo", $('#empNoSearch').val());
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
								$("#result2").empty();
								$("#result2").append("<tr><th>신청번호</th><th>신청날짜</th><th>유형</th><th>시작일</th><th>종료일</th><th>이유</th><th>상태</th><th>수정</th><th>삭제</th></tr>");
								for(const leaveInfo of result) {
									var text = "<tr><td>" + leaveInfo.leaveId
										       + "</td><td>" + leaveInfo.requestDate 
										       + "</td><td>" + leaveInfo.leaveType 
											   + "</td><td>" + leaveInfo.startDate 
											   + "</td><td>" + leaveInfo.endDate 
											   + "</td><td>" + leaveInfo.reason
											   + "</td><td>" + leaveInfo.status 
											   + "</td><td><a id='btn1' href='/hrm/leaveView?leaveId=" + leaveInfo.leaveId + "' class='btnO'>수정</a></td><td><a id='btn2' href='/hrm/leaveDelete?leaveId="+ leaveInfo.leaveId +"' class='btnX'>삭제</a></td></tr>";
								$("#result2").append(text);
								
								}
							},
							error:function(xhr, status, error){
								
							}
						});
						});
						},
						error:function(xhr, status, error){
							
						}
					});
			},
			error:function(xhr, status, error){
					
				}
		});
	});
	            
	
		// 신청날짜 현재 날짜로 고정 
		 const today = new Date();
	     const year = today.getFullYear();
	     const month = String(today.getMonth() + 1).padStart(2, "0");
	     const day = String(today.getDate()).padStart(2, "0");
		 const todayStr = year+"-"+month+"-"+day;
		$("#currentDate").val(todayStr);
		
		// 휴가시작일, 종료일 신청날짜 다음날로 고정(다음날부터 신청가능하도록)
	   const tomorrow = new Date();
	   tomorrow.setDate(tomorrow.getDate() + 1);
	   const tomorrowStr = tomorrow.toISOString().substring(0, 10);
	   $(".leaveDate").val(tomorrowStr);
	   
	   // 과거시간, 주말, 공휴일 선택 제한
   	   // Q. 더 간단한 방법, 그리고 앞으로의 공휴일을 계속 제한할 방법은?
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
 	   const startDateInput = document.getElementById('#startDate');
 	   const endDateInput = document.getElementById('#endDate');
	   
	   leaveDateInputs.forEach(function(input){
			 input.setAttribute('min', tomorrowStr); // 과거 날짜 선택 제한
			 input.addEventListener('input', function(){
				const selectedDate = new Date(this.value); // 사용자가 선택한 날짜
		        const day = selectedDate.getDay(); // 사용자가 선택한 날짜 요일로 변환
		        const weekend = (day === 0 || day === 6); // 0: 일, 6: 토 주말
		        const holiday = holidays.includes(this.value); // 공휴일
				
				if(weekend || holiday){
					alert("주말 및 공휴일 선택불가");
					this.value = tomorrowStr; // 날짜 기본값(신청날짜 다음날)으로 초기화
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

	   $.ajax({
			// 요청
			type : "post",
			url : "/leaveAdd",
			data : JSON.stringify([{
				"empNo" : empNo,
				"requestDate" : currentDate, 
				"leaveType" : select,
				"startDate" : startDate,
				"endDate" : endDate,
				"reason" : reason,
		   }]),
		   contentType: false,
		   contentType: 'application/json; charset=UTF-8', // formData에서는 false였으나 여기서는 contentType을 지정해줘야함
	       // 응답
		   success : function(response) {
				alert("신청완료"); // 휴가 등록 버튼을 누르면
				location.reload(); // 새로고침
	      },
	       error:function(xhr,status,error) {
		   }
       });
	});

	

	</script>
</body>
</html>