<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budgetUpdate</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	#budgetNo,
	#deptName,
	#periodType,
	#annualBudget,
	#plan,
	#executionDate {
	    border: 1px solid #ccc;
		outline: none;
	}
</style>
</head>
<body>
	<h5>[재무 관리] > [예산 수정]</h5>
	<h3>예산 수정</h3>
	<div class="filter-bar">
		<form action="/budgetUpdate" method="post">
			예산 번호 : <input type="text" id="budgetNo" name="budgetNo" value="${budgetInfo.budgetNo}" readonly="readonly"><br>
			부서명 : <input type="text" id="deptName" name="deptName" value="${budgetInfo.deptName}" readonly="readonly"/><br>
			연/분기/월 : <select id="periodType" name="periodType"><option value="${budgetInfo.periodType}">${budgetInfo.periodType}</option><option value="Y">연(Y)</option><option value="Q">분기(Q)</option><option value="M">월(M)</option></select><br>
			예산 금액 : <input type="number" min="0" id="annualBudget" name="annualBudget" value="${budgetInfo.annualBudget}"/><br>
			예산 계획 : <input type="text" id="plan" name="plan" value="${budgetInfo.plan}"/><br>
			예산 집행일 : <input type="date" id="executionDate" name="executionDate" value="${budgetInfo.executionDate}"/><br>
			<button type="submit" id="budget-update">수정</button>
		</form>
	</div>
	
	<script>
		const budgetCheck = /^[1-9]\d*$/;
		const annualBudget = document.querySelector("#annualBudget");
		annualBudget.addEventListener("input", (e) => {
			console.log(e.target.value);
			console.log(budgetCheck.test(e.target.value));
			
			if (budgetCheck.test(e.target.value)) {
				$("#budget-update").prop("disabled", false);
				annualBudget.style.border = "1px solid #ccc";
			} else {
				$("#budget-update").prop("disabled", true);
				annualBudget.style.border = "2px solid red"
			}
		});
		
		const dateCheck = /.+/;
		const executionDate = document.querySelector("#executionDate");
		executionDate.addEventListener("input", (e) => {
			console.log(e.target.value);
			console.log(dateCheck.test(e.target.value));
			
			if (dateCheck.test(e.target.value)) {
				$("#budget-update").prop("disabled", false);
				executionDate.style.border = "1px solid #ccc";
			} else {
				$("#budget-update").prop("disabled", true);
				executionDate.style.border = "2px solid red"
			}
		});	
	</script>
</body>
</html>