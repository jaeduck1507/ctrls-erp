<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budgetRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
	td {
		position: relative;
		box-sizing: border-box;
	}

	.red {
		border-color: red;
		border-width: 2px;
	}

	table {
	  border-collapse: separate;  
	}
</style>
</head>
<body>
	<h5>[재무 관리] > [예산 등록]</h5>
	<h3>예산 등록</h3>
	<div id="register" class="filter-bar">
		<button id="add-row">열 추가</button>
		<table border="1" id="result" class="data-table">
			<tr>
				<th>부서 선택</th>
				<th>부서 번호</th>
				<th>연/분기/월</th>
				<th>예산 금액</th>
				<th>계획 상세</th>
				<th>예산 집행일</th>
				<th>삭제</th>
			</tr>
		</table>
		<button id="budget-register" disabled>예산 등록</button>
	</div>
	
	<script>
		const department = [
		<c:forEach items="${department}" var="dept" varStatus="status">
			{ deptNo: "${dept.deptNo}", deptName: "${dept.deptName}" }<c:if test="${!status.last}">,</c:if>
		</c:forEach>
		];
	</script>
	<script src="../resources/js/fm/budgetRegister.js"></script>
</body>
</html>