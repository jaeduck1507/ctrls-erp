<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budgetUpdate</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="../resources/css/fm/budgetUpdate.css"/>
</head>
<body>
	<h5>[재무 관리] > [예산 수정]</h5>
	<h3>예산 수정</h3>
	<form action="/budgetUpdate" method="post" id="budgetUpdateForm" class="filter-bar">
		<div class="box">
			<table>
				<tr>
					<th><i class="fi fi-rr-input-numeric"></i>&nbsp;&nbsp;예산 번호</th>
					<td><input type="text" id="budgetNo" name="budgetNo" value="${budgetInfo.budgetNo}" readonly="readonly"></td>
				</tr>
				<tr>
					<th><i class="fi fi-rr-briefcase"></i>&nbsp;&nbsp;부서명</th>
					<td><input type="text" id="deptName" name="deptName" value="${budgetInfo.deptName}" readonly="readonly"/></td>
				</tr>
				<tr>
					<th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;연/분기/월</th>
					<td><select id="periodType" name="periodType"><option value="${budgetInfo.periodType}">${budgetInfo.periodType}</option><option value="Y">연(Y)</option><option value="Q">분기(Q)</option><option value="M">월(M)</option></select></td>
				</tr>
				<tr>
					<th><i class="fi fi-rr-dollar"></i>&nbsp;&nbsp;예산 금액</th>
					<td><input type="number" min="0" id="annualBudget" name="annualBudget" value="${budgetInfo.annualBudget}"/></td>
					<td><p id="resultBudget">숫자만 입력</p></td>
				</tr>
				<tr>
					<th><i class="fi fi-rr-coins"></i>&nbsp;&nbsp;예산 계획</th>
					<td><input type="text" id="plan" name="plan" value="${budgetInfo.plan}"/></td>
				</tr>
				<tr>
					<th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;예산 집행일</th>
					<td><input type="date" id="executionDate" name="executionDate" value="${budgetInfo.executionDate}"/></td>
					<td><p id="resultDate">날짜 선택 필수</p></td>
				</tr>
			</table>
		</div>
		
		<div>
			<button type="button" id="budget-update">수정</button>
			<button type="button" onclick="location.href='/fm/budget'">취소</button>
		</div>
	</form>
	
	<script src="../resources/js/fm/budgetUpdate.js"></script>
</body>
</html>