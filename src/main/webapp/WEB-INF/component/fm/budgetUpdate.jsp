<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budgetUpdate</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h5>[재무 관리] > [예산 수정]</h5>
	<h3>예산 수정</h3>
	<div class="filter-bar">
		<form action="/budgetUpdate" method="post">
			예산 번호 : <input type="text" name="budgetNo" value="${budgetInfo.budgetNo}" readonly="readonly"><br>
			부서명 : <input type="text" name="deptName" value="${budgetInfo.deptName}" readonly="readonly"/><br>
			연/분기/월 : <select name="periodType"><option value="${budgetInfo.periodType}">${budgetInfo.periodType}</option><option value="Y">연(Y)</option><option value="Q">분기(Q)</option><option value="M">월(M)</option></select><br>
			예산 금액 : <input type="number" min="0" name="annualBudget" value="${budgetInfo.annualBudget}"/><br>
			예산 계획 : <input type="text" name="plan" value="${budgetInfo.plan}"/><br>
			예산 집행일 : <input type="date" name="executionDate" value="${budgetInfo.executionDate}"/><br>
			<button type="submit">수정</button>
		</form>
	</div>
	
	
</body>
</html>