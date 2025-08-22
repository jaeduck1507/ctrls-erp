<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budgetUpdate</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/modifyMyInfo.css"/>
<style>
	#budgetNo,
	#deptName,
	#periodType,
	#annualBudget,
	#plan,
	#executionDate {
	    border: 1px #ccc;
		outline: none;
	}
</style>
</head>
<body>
	<h5>[재무 관리] > [예산 수정]</h5>
	<h3>예산 수정</h3>
	<!--
	<div class="filter-bar">
		<form action="/budgetUpdate" method="post">
			예산 번호 : <input type="text" id="budgetNo" name="budgetNo" value="${budgetInfo.budgetNo}" readonly="readonly">
			부서명 : <input type="text" id="deptName" name="deptName" value="${budgetInfo.deptName}" readonly="readonly"/>
			연/분기/월 : <select id="periodType" name="periodType"><option value="${budgetInfo.periodType}">${budgetInfo.periodType}</option><option value="Y">연(Y)</option><option value="Q">분기(Q)</option><option value="M">월(M)</option></select>
			예산 금액 : <input type="number" min="0" id="annualBudget" name="annualBudget" value="${budgetInfo.annualBudget}"/>
			예산 계획 : <input type="text" id="plan" name="plan" value="${budgetInfo.plan}"/>
			예산 집행일 : <input type="date" id="executionDate" name="executionDate" value="${budgetInfo.executionDate}"/>
			<button type="submit" id="budget-update">수정</button>
			<a href="/fm/budget" class="btnO">목록</a>
		</form>
	</div>
	-->
	<form action="/budgetUpdate" method="post" class="filter-bar">
		<div class="box">
			<table>
				<tr>
					<th>예산 번호</th>
					<td><input type="text" id="budgetNo" name="budgetNo" value="${budgetInfo.budgetNo}" readonly="readonly"></td>
				</tr>
				<tr>
					<th>부서명</th>
					<td><input type="text" id="deptName" name="deptName" value="${budgetInfo.deptName}" readonly="readonly"/></td>
				</tr>
				<tr>
					<th>연/분기/월</th>
					<td><select id="periodType" name="periodType"><option value="${budgetInfo.periodType}">${budgetInfo.periodType}</option><option value="Y">연(Y)</option><option value="Q">분기(Q)</option><option value="M">월(M)</option></select></td>
				</tr>
				<tr>
					<th>예산 금액</th>
					<td><input type="number" min="0" id="annualBudget" name="annualBudget" value="${budgetInfo.annualBudget}"/></td>
					<td><p id="resultBudget">숫자만 입력</p></td>
				</tr>
				<tr>
					<th>예산 계획</th>
					<td><input type="text" id="plan" name="plan" value="${budgetInfo.plan}"/></td>
				</tr>
				<tr>
					<th>예산 집행일</th>
					<td><input type="date" id="executionDate" name="executionDate" value="${budgetInfo.executionDate}"/></td>
					<td><p id="resultDate">날짜 선택 필수</p></td>
				</tr>
			</table>
		</div>
		
		<div>
			<button type="submit" id="budget-update">수정</button>
			<button onclick="location.href='/fm/budget'">취소</button>
		</div>
	</form>
	
	<script>
		const budgetCheck = /^[1-9]\d*$/;
		const annualBudget = document.querySelector("#annualBudget");
		annualBudget.addEventListener("input", (e) => {
			console.log(e.target.value);
			console.log(budgetCheck.test(e.target.value));
			
			if (budgetCheck.test(e.target.value)) {
				$("#budget-update").prop("disabled", false);
				resultBudget.innerHTML = "OK!";
				resultBudget.style.color = "green";
				annualBudget.style.border = "1px #ccc";
			} else {
				$("#budget-update").prop("disabled", true);
				resultBudget.innerHTML = "숫자만 입력";
				resultBudget.style.color = "red";
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
				resultDate.innerHTML = "OK!";
				resultDate.style.color = "green";
				executionDate.style.border = "1px #ccc";
			} else {
				$("#budget-update").prop("disabled", true);
				resultDate.innerHTML = "날짜 입력 필수";
				resultDate.style.color = "red";
				executionDate.style.border = "2px solid red"
			}
		});
		
		$("#budget-update").click(() => {
			alert("수정되었습니다!");
		});
	</script>
</body>
</html>