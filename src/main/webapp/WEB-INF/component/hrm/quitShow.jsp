<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퇴사자정보조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h5>[인적자원관리] > [퇴사자정보조회]</h5>
					<h3>퇴사자 정보 조회</h3>
	<div id="search" class="filter-bar">
		<input type="text" id="quitName" placeholder="사원명 입력">
		<button id="btn">검색</button>
	</div>
	<div>
		<table border="1" id="result" class="data-table"></table>
	</div>
	<nav>
		<ul class="pagination">
		</ul>
	</nav>
	
<script src="../resources/js/hrm/quitShow.js"></script>
</body>
</html>