<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budget</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>예산 조회</h1>
	<div>
		<button id="btn">조회</button>
	</div>
	
	<div>	
		<table border="1" id="result">
				
		</table>
	</div>
	
	<script>
		$("#btn").click(() => {
			$.ajax({
				type: "get",
				url: "/showBudget",
				success: function(result) {
					$("#result").append("<tr><th>예산 번호</th><th>연/분기/월</th><th>적용 기간</th><th>예산 금액</th><th>계획</th><th>생성일시</th><th>부서 번호</th></tr>");
					for (const b of result) {
						var text = "<tr><td>"  + b.budgetNo + "</td><td>" + b.periodType + "</td><td>" + b.periodValue + "</td><td>" 
								+ b.annualBudget + "</td><td>" + b.plan + "</td><td>" + b.createdAt + "</td><td>" + b.deptNo + "</td>"
						$("#result").append(text);
					}
				},
				error: function(xhr, status, error) {
					
				}
			});
		});
	</script>
</body>
</html>