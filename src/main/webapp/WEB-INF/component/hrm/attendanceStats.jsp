<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출근/퇴근 통계</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h5>[근태 관리] > [출근/퇴근 통계]</h5>
	<h3>출근/퇴근 통계</h3>
	<div class="filter-bar">
	<select id = "empNo">
	<!-- 일단 로그인 정보가 없으므로 select로 대체 -->
		<option value="-1">사원 선택</option>
		<c:forEach items="${empInfo}" var="emp">
			<option value="${emp.empNo}">${emp.empNo}/${emp.empName}/${emp.jobTitle}/${emp.deptName}</option>
		</c:forEach>		
	
	</select>
	월별 조회 : <input type="month" id="yearMonth">
	<button id="showBtn">조회</button>
	</div>
	<table border="1" id = "result" class="data-table"></table>
	<script>
		$("#showBtn").click(() =>{
			const empNo = $("#empNo").val();
			const yearMonth = $("#yearMonth").val();
			const obj = {};
			obj.empNo = empNo;
			obj.yearMonth = yearMonth;
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/attendanceStats",
	            dataType : "json", 
                data : JSON.stringify(obj),
				processData: false,
				contentType: 'application/json; charset=UTF-8',
				
	            // 응답
	            success : function(result) {
					
					$("#result").html("");
	            	$("#result").append("<tr><th>월</th><th>총일수</th><th>출근일수</th><th>지각일수</th><th>조퇴일수</th><th>결근일수</th><th>휴가일수</th></tr>");
                	
					var text = "<tr><td>"+ result.month +"월</td><td>"+result.totalCount+"일</td><td>"+ result.workCount +"일</td><td>"+ result.lateCount +"일</td><td>"+result.leaveEarlyCount+"일</td><td>"
					+result.absenceCount+"일</td><td>" + result.leaveCount+"일</td></tr>"
					$("#result").append(text);
                	
                	
	            	
	            	
	            },
	            
				error:function(xhr,status,error) {
					
				}
	        });
	    });
		
		
	</script>
</body>
</html>