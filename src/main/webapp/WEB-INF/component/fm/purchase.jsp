<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Purchase</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[재무 관리] > [매입 내역 조회]</h5>
	<h3>매입 내역 조회</h3>
	<div id="search" class="filter-bar">
		<select id="brandName">
			<option value="all">브랜드</option>
			<c:forEach items="${brandList}" var="brand">
				<option value="${brand.brandName}">${brand.brandName}</option>
			</c:forEach>
		</select>
		<select id="productCategory">
			<option value="all">카테고리</option>
			<c:forEach items="${categoryList}" var="category">
				<option value="${category}">${category}</option>
			</c:forEach>
		</select>
		제품명 검색: <input type="text" id="productName">
		
		조회 시작일: <input type="date" id="startDate">
		조회 종료일: <input type="date" id="endDate">
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
	
	<script src="../resources/js/fm/purchase.js"></script>
</body>
</html>