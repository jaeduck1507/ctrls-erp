<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>transRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="../resources/css/fm/fmRegister.css"/>
</head>
<body>
	<h5>[재무 관리] > [기타 지출 내역 입력]</h5>
	<h3>기타 지출 내역 입력</h3>
	<div id="register" class="filter-bar">
		<button id="add-row">열 추가</button>
		<table border="1" id="result" class="data-table">
			<tr>
				<th>부서 선택</th>
				<th>부서 코드</th>
				<th>수입/지출</th>
				<th>분류</th>
				<th>금액</th>
				<th>상세내역</th>
				<th>발생일자</th>
				<th>삭제</th>
			</tr>
		</table>
		<button id="trans-register">등록</button>
	</div>
	
	<script>
		const department = [
		<c:forEach items="${department}" var="dept" varStatus="status">
			{ deptNo: "${dept.deptNo}", deptName: "${dept.deptName}" }<c:if test="${!status.last}">,</c:if>
		</c:forEach>
		];
	</script>
	<script src="../resources/js/fm/transRegister.js"></script>
</body>
</html>