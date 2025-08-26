<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>휴가 누적 사용일 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link rel="stylesheet" href="../resources/css/leaveDays.css" />
  </head>
  <body>
	<h5>[근태 관리] > [휴가 누적 사용일, 남은 휴가일 조회]</h5>
	<h3>휴가 누적 사용일, 남은 휴가일 조회</h3>
	<div class="filter-bar">
		사번 : <input type="text" id="empNo">
		<button id="btn">조회</button>
	</div>
	<div class="box">
		<table border="1" id="result"></table>
	</div>

	<script src="../resources/js/hrm/leaveDays.js"></script>
  </body>
  </html>