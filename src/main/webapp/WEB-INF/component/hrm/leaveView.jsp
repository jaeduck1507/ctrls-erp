<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 정보 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<div class="container">
		<form action="/leaveUpdate" method="post">
			<h1>휴가 수정</h1>
		<table border="1">
				<tr>
					
				<th>신청번호</th>
				<th>신청날짜</th>
				<th>유형</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>이유</th>
				<th>사번</th>
				<th>신청자</th>
				<th>상태</th>
				</tr>
					
				<c:forEach items="${leaveInfoList}" var="item">
				<tr>
				    <td>${item.leaveId}<input type="hidden" name="leaveId" value="${item.leaveId}"></td>
					<td>${item.requestDate}<input type="hidden" name="requestDate" value="${item.requestDate}"></td>
					<!--휴가 신청 시 유형이 고정되도록, 하지만 다시 선택할 수 있도록 ${item.leaveType eq '연차' ? 'selected' : ''} 추가-->
					<td><select name="leaveType"><option disabled selected>유형선택</option><option value="연차" ${item.leaveType eq '연차' ? 'selected' : ''}>연차</option><option value="병가" ${item.leaveType eq '병가' ? 'selected' : ''}>병가</option><option value="경조사" ${item.leaveType eq '경조사' ? 'selected' : ''}>경조사</option><option value="기타" ${item.leaveType eq '기타' ? 'selected' : ''}>기타</option></select></td>
					<td><input type="date" name="startDate" value="${item.startDate}" class="leaveDate"></td>
					<td><input type="date" name="endDate" value="${item.endDate}" class="leaveDate" id="endDate"></td>
					<td><input type="title" name="reason" value="${item.reason}"></td>
					<td>${item.empNo}<input type="hidden" name="leaveId" value="${item.empNo}"></td>
					<td>${item.empName}<input type="hidden" name="leaveId" value="${item.empName}"></td>
					<td>${item.status}<input type="hidden" name="leaveId" value="${item.status}"></td>
				</tr>
				</c:forEach>
		</table>
		<button type="submit" id="update">수정</button>
		</form>

		<script>
			
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
		         alert("주말 및 공휴일 선택불가");
		         this.value = tomorrowStr; // 날짜 초기화
		         return;
		       }
			   // 휴가 종료일은 휴가 시작일부터 가능하도록 제어
			   endDateInput.setAttribute('min', this.value);
		     });
		   });
		</script>
</body>
</html>