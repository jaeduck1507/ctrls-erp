<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출근/퇴근 기록</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[근태 관리] > [출근/퇴근 기록]</h5>
	<h3>출근/퇴근 기록</h3>
	<div class="filter-bar">
		<select id="empNo">
			<!-- 일단 로그인 정보가 없으므로 select로 대체 -->
			<option value="-1">사원 선택</option>
			<c:forEach items="${empInfo}" var="emp">
				<option value="${emp.empNo}">${emp.empNo}/${emp.empName}/${emp.jobTitle}/${emp.deptName}</option>
			</c:forEach>

		</select> 날짜 : <input type="date" id="workDate">
	</div>
	<div class="filter-bar">
		<button id="setAttendance">출근으로 변경</button>
	</div>
	<script src="../resources/js/hrm/attendanceRecord.js"></script>
</body>
</html>