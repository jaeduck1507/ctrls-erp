<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원정보조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<div class="container">
	<h1>수당 조회</h1>
	<div id = "search">
	이름 : <input type="text" id="empName">
		<select id="deptName">
			<option value="-1">부서 선택</option>
			<c:forEach items="${department}" var="emp">
				<option value="${emp.deptNo}">${emp.deptName}</option>
			</c:forEach>
		</select>
		<select id="jobTitle">
			<option value="-1">직무 선택</option>
			<c:forEach items="${jobPosition}" var="emp">
				<option value="${emp.jobNo}">${emp.jobTitle}</option>
			</c:forEach>
		</select>
		조회 월 선택 : <input type="month" id="date">
		<button id = "btn">검색</button>
	</div>
	<div>
	
	<table border="1" id = "result" >
	</table>
	</div>
	
	</div>
	
	<script>
		$("#btn").click(() =>{
			const empName = $("#empName").val();
			const deptNo = $("#deptName").val();
			const jobNo = $("#jobTitle").val();
			const date = $("#date").val();
			const obj = {};
			obj.empName = empName;
			obj.deptNo = deptNo;
			obj.jobNo = jobNo;
			obj.date = date;
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/showBonusPayment",
	            dataType : "json", 
                data : JSON.stringify(obj),
				processData: false,
				contentType: 'application/json; charset=UTF-8',
				
	            // 응답
	            success : function(result) {
					
					$("#result").html("");
	            	$("#result").append("<tr><th>이름</th><th>부서</th><th>직급</th><th>수당 금액</th><th>수당 종류</th><th>지급 날짜</th></tr>");
                	for(const bonus of result) {
					var text = "<tr><td>"+ bonus.empName +"</td><td>"+bonus.deptName+"</td><td>"+bonus.jobTitle+"</td><td>"+bonus.payment+"</td><td>"+bonus.bonusName+"</td><td>"+bonus.payDate+"</td></tr>"
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