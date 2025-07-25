<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salary</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>급여 조회</h1>
	<div id="search">
		사원 검색 : <input type="text" id="empName">
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
			formData.append("empName", $("#empName").val());
			$.ajax({
				type: "post",
				url: "/showSalary",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					//console.log($("#deptName").val());
					//console.log($("#empName").val());
					$("#result").html("");
					$("#result").append("<tr><th>부서 이름</th><th>직원 이름</th><th>지급일</th><th>기본급</th><th>보너스</th><th>공제금</th><th>세금</th><th>급여 총액</th></tr>");
					for (const s of result) {
						var text = "<tr><td>" + s.deptName + "</td><td>" + s.empName + "</td><td>" + s.salaryDate + "</td><td>" 
							+ s.baseSalary + "</td><td>" + s.bonus + "</td><td>" + s.deduction + "</td><td>" + s.tax + "</td><td>" 
							+ (s.baseSalary + s.bonus - s.deduction - s.tax) + "</td></tr>"
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