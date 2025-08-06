<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>휴가 조회</h1>

	<div id="search">
		사번 <input type="text" id="empNo">
		상태
		<select name="status" id="status">
			
			<option value="all">전체</option>
			<option value="wait">대기</option>
			<option value="approve">승인</option>
			<option value="back">반려</option>
		   
		</select>
		<button id="btn">조회</button>
	</div>
	<div>
		<table border="1" id="result"></table>
	</div>
	
	<script>
		
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
								   + "</td><td><a id='btn1' href='/hrm/leaveView?leaveId=" + leaveInfo.leaveId + "'>수정</a></td><td><a id='btn2' href='/hrm/leaveDelete?leaveId="+ leaveInfo.leaveId +"'>삭제</a></td></tr>"
					$("#result").append(text);
					}
				},
				error:function(xhr, status, error){
					
				}
			})
		})
		
	</script>
</body>
</html>