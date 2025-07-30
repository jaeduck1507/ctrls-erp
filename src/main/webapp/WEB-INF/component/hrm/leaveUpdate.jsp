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
	<h1>휴가 정보 수정</h1>
	<div id="search">
			사번 <input type="text" id="empNo">
			<button id="btn">조회</button>
		</div>
		<div>
			<table border="1" id="result"></table>
		</div>
		
		<script>
			// 조회 버튼을 클릭하면 휴가 정보가 테이블 형태로 나오도록
			$("#btn").click(()=>{
				const formData = new FormData();
				formData.append("empNo", $('#empNo').val());
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
						$("#result").append("<tr><th>신청번호</th><th>신청자</th><th>신청날짜</th><th>유형</th><th>시작일</th><th>종료일</th><th>이유</th><th>상태</th><th>수정하기</th></tr>");
						for(const leaveInfo of result) {
							var text = "<tr><td>" + leaveInfo.leaveId
								       + "</td><td>" + leaveInfo.empName 
								       + "</td><td>" + leaveInfo.requestDate 
								       + "</td><td>" + leaveInfo.leaveType 
									   + "</td><td>" + leaveInfo.startDate 
									   + "</td><td>" + leaveInfo.endDate 
									   + "</td><td>" + leaveInfo.reason
									   + "</td><td>" + leaveInfo.status 
									   + "</td><td><button id='btn2'>수정하기</button>"
									   + "</td></tr>"
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