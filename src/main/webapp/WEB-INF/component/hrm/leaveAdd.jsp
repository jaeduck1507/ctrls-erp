<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원정보조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[근태 관리] > [휴가 신청]</h5>
	<h3>휴가 신청</h3>
	<div id = "test" class="filter-bar">
	        <button id = "btn2">열 추가</button>
	        <!-- <button id = "btn3">removeRowTest</button> -->
	        <table border="1" id = "result" class="data-table">
	            <tr>
	                <th>사번</th>
	                <th>신청날짜</th>
					<th>휴가 유형</th>
	                <th>휴가 시작일</th>
	                <th>휴가 종료일</th>
	                <th>사유</th>
					<th>삭제</th>
	            </tr>
			</table>

			<button id="btn">휴가 등록</button>
	 </div>
	<script src="../resources/js/hrm/leaveAdd.js"></script>
	</body>
	</html>
