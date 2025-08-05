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
	<h1>예산 수정</h1>
	<form action="/budgetUpdate" method="post">
		예산 번호 : <input type="text" name="budgetNo" value="${budgetInfo.budgetNo}" readonly="readonly"><br>
		부서명 : <input type="text" name="deptName" value="${budgetInfo.deptName}" readonly="readonly"/><br>
		연/분기/월 : <input type="text" name="periodType" value="${budgetInfo.periodType}"/><br>
		예산 금액 : <input type="number" name="annualBudget" value="${budgetInfo.annualBudget}"/><br>
		계획 : <input type="text" name="plan" value="${budgetInfo.plan}"/><br>
		예산 집행일 : <input type="date" name="executionDate" value="${budgetInfo.executionDate}"/><br>
		<button type="submit">수정</button>
	</form>
	
</body>
</html>