<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출근/퇴근 기록</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<div>
	<select id = "empNo">
	<!-- 일단 로그인 정보가 없으므로 select로 대체 -->
		<option value="-1">사원 선택</option>
		<c:forEach items="${empInfo}" var="emp">
			<option value="${emp.empNo}">${emp.empNo}/${emp.empName}/${emp.jobTitle}/${emp.deptName}</option>
		</c:forEach>		
	
	</select>
	날짜 : <input type="date" id="workDate">
	출근 : <input type="time" id = "checkIn">
	퇴근 : <input type="time" id = "checkOut">
	</div>
	<button id="start_work">출근</button>
	<button id="finish_work">퇴근</button>
	<script>
		$("#start_work").click(() =>{
			const empNo = $("#empNo").val();
			const checkIn = $("#checkIn").val();
			const workDate = $("#workDate").val();
			const obj = {};
			obj.empNo = empNo;
			obj.checkIn = checkIn;
			obj.workDate = workDate;
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/startWork",
	            dataType : "json", 
                data : JSON.stringify(obj),
				processData: false,
				contentType: 'application/json; charset=UTF-8',
				
	            // 응답
	            success : function(result) {
					
	            	
	            	
	            },
	            
				error:function(xhr,status,error) {
					
				}
	        });
	    });
		
		$("#finish_work").click(() =>{
			const empNo = $("#empNo").val();
			const checkOut = $("#checkOut").val();
			const workDate = $("#workDate").val();
			const obj = {};
			obj.empNo = empNo;
			obj.checkOut = checkOut;
			obj.workDate = workDate;
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/finishWork",
	            dataType : "json", 
                data : JSON.stringify(obj),
				processData: false,
				contentType: 'application/json; charset=UTF-8',
				
	            // 응답
	            success : function(result) {
					
	            	
	            	
	            },
	            
				error:function(xhr,status,error) {
					
				}
	        });
	    });
	</script>
</body>
</html>