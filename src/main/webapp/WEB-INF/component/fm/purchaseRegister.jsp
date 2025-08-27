<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PurchaseRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="../resources/css/fm/fmRegister.css"/>
</head>
<body>
	<h5>[재무 관리] > [매입 일괄 등록]</h5>
	<h3>매입 일괄 등록</h3>
	<div id="brandList" class="filter-bar">
		<select id="brand">
			<option value="0" disabled selected> 선택</option>
			<c:forEach items="${brandList}" var="brand">
				<option value="${brand.brandCode}">${brand.brandName}</option>
			</c:forEach>
		</select>
		<button id="selectBrand">거래처 선택</button>
	</div>
	
	<div id="test" class="filter-bar">
		
	</div>
	
	<script src="../resources/js/fm/purchaseRegister.js"></script>
</body>
</html>