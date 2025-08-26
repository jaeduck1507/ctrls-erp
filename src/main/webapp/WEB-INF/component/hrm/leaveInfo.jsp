<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[근태 관리] > [휴가 조회]</h5>
	<h3>휴가 조회</h3>

	<div id="search" class="filter-bar">
		
		휴가 처리 상태
		<select name="status" id="status">
			<option value="all">전체</option>
			<option value="wait">대기</option>
			<option value="approve">승인</option>
			<option value="back">반려</option>
		</select>
		<input type="text" id="empNo" placeholder="사번 입력">
		<button id="btn">조회</button>
	</div>
	<div>
		<table border="1" id="result" class="data-table"></table>
	</div>
	
	<script src="../resources/js/hrm/leaveInfo.js"></script>

</body>
</html>