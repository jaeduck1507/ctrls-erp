<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budget</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[재무 관리] > [예산 조회]</h5>
	<h3>예산 조회</h3>
	<div id="search" class="filter-bar">
		<select id="deptName">
			<option value="all">부서 선택</option>
			<c:forEach items="${department}" var="dept">
				<option value="${dept.deptName}">${dept.deptName}</option>
			</c:forEach>
		</select>
		<input type="month" id="yearMonth"/>
		<button id="btn">조회</button>
	</div>
	
	<div>	
		<table border="1" id="result" class="data-table">
			
		</table>
	</div>
	
	<div>
		<nav>
			<ul class="pagination">
				
			</ul>
		</nav>
	</div>
	
	<script src="../resources/js/fm/budget.js"></script>
</body>
</html>