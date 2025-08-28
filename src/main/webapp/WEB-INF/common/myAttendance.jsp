<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 출근/퇴근 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[마이페이지] > [출근 현황]</h5>
	<h3>출근 현황</h3>
	<div class="filter-bar">
	월별 조회 : <input type="month" id="yearMonth">
	<button id="showBtn">조회</button>
	</div>
	<table border="1" id = "result" class="data-table" ></table>
	
	<script src="../resources/js/common/myAttendance.js"></script>
</body>
</html>