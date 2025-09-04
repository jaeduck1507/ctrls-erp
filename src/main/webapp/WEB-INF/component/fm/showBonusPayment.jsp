<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보너스 수당 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[재무 관리] > [수당 조회]</h5>
	<h3>수당 조회</h3>
	<div id = "search" class="filter-bar">
		<input type="text" id="empName" placeholder="사원 검색">
		<select id="deptName">
			<option value="-1">부서 선택</option>
			<c:forEach items="${department}" var="emp">
				<option value="${emp.deptNo}">${emp.deptName}</option>
			</c:forEach>
		</select>
		<select id="jobTitle">
			<option value="-1">직급 선택</option>
			<c:forEach items="${jobPosition}" var="emp">
				<option value="${emp.jobNo}">${emp.jobTitle}</option>
			</c:forEach>
		</select>
		조회 월 선택 : <input type="month" id="date">
		<button id ="btn">검색</button>
	</div>
	
	<div>
		<table border="1" id = "result" class="data-table">
		</table>
	</div>

	<div>
		<nav>
			<ul class="pagination">
			</ul>
		</nav>
	</div>
	
	<script src="../resources/js/fm/showBonusPayment.js"></script>
</body>
</html>