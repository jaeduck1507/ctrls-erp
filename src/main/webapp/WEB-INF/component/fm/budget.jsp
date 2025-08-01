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
	<div id="search">
		<select id="deptName">
			<option value="dept">부서 선택</option>
			<c:forEach items="${department}" var="dept">
				<option value="${dept.deptName}">${dept.deptName}</option>
			</c:forEach>
		</select>
		<button id="btn">조회</button>
	</div>
	
	<div>	
		<table border="1" id="result">
				
		</table>
	</div>
	
	<script>
		$("#btn").click(() => {
			const formData = new FormData();
			formData.append("deptName", $("#deptName").val());
			$.ajax({
				type: "post",
				url: "/showBudget",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					//console.log($("#deptName").val());
					$("#result").html("");
					$("#result").append("<tr><th>예산 코드</th><th>부서명</th><th>예산 금액</th><th>계획</th><th>예산 집행일</th><th>수정</th></tr>");
					for (const b of result) {
						var text = "<tr><td>" + b.periodValue + "</td><td>" + b.deptName + "</td><td>" 
							+ b.annualBudget + "</td><td>" + b.plan + "</td><td>" + b.executionDate + "</td></tr>"
						$("#result").append(text);
						$("#result tr").eq(-1).append('<td><a href="/fm/budgetUpdate?budgetNo=' + b.budgetNo + '">수정</a></td>')
					}
				},
				error: function(xhr, status, error) {
					
				}
			});
		});
		
	</script>
</body>
</html>