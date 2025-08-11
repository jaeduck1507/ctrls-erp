<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 출근/퇴근 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<div>
	월별 조회 : <input type="month" id="yearMonth">
	<button id="showBtn">조회</button>
	</div>
	<table border="1" id = "result" ></table>
	<script>
		$("#showBtn").click(() =>{
			const yearMonth = $("#yearMonth").val();
			const obj = {};
			obj.yearMonth = yearMonth;
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/showMyAttendance",
	            dataType : "json", 
                data : JSON.stringify(obj),
				processData: false,
				contentType: 'application/json; charset=UTF-8',
				
	            // 응답
	            success : function(result) {
					$("#result").html("");
	            	$("#result").append("<tr><th>사원번호</th><th>출근일자</th><th>출근시각</th><th>퇴근시간</th><th>상태</th></tr>");
                	for(const log of result) {
					var text = "<tr><td>"+ log.empNo +"</td><td>"+log.workDate+"</td><td>"+(log.checkIn==null?"":log.checkIn)+"</td><td>"+(log.checkOut==null?"":log.checkOut)+"</td><td>"+log.status+"</td></tr>"
					$("#result").append(text);
                	
                	}
	            	
	            	
	            },
	            
				error:function(xhr,status,error) {
					
				}
	        });
	    });
		
		
	</script>
</body>
</html>