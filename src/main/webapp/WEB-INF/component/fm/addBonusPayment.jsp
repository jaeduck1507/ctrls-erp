<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bonusRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="../resources/css/fm/fmRegister.css"/>
</head>
<body>
	<h5>[재무 관리] > [보너스 수당 등록]</h5>
	<h3>보너스 수당 등록</h3>
	<div id="register" class="filter-bar">
		<button id="add-row">열 추가</button>
		<table border="1" id="result" class="data-table">
			<tr>
				<th>사원 선택</th>
				<th>수당 유형</th>
				<th>수당 금액</th>
				<th>수당 지급일</th>
				<th>삭제</th>
			</tr>
		</table>
		<button id="bonus-register">보너스 등록</button>
	</div>
	
	<script>
		const empInfo = [
		<c:forEach items="${empInfo}" var="emp" varStatus="status">
			{ empNo: "${emp.empNo}", empName: "${emp.empName}", deptName: "${emp.deptName}", jobTitle: "${emp.jobTitle}" }<c:if test="${!status.last}">,</c:if>
		</c:forEach>
		];
		
		const bonus = [
		<c:forEach items="${bonus}" var="bn" varStatus="status">
			{ bonusNo: "${bn.bonusNo}", bonusName: "${bn.bonusName}" }<c:if test="${!status.last}">,</c:if>
		</c:forEach>
		];
	</script>
	<script src="../resources/js/fm/addBonusPayment.js"></script>
</body>
</html>