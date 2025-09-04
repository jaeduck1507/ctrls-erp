<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>saleRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[재무 관리] > [매출 등록]</h5>
	<h3>매출 등록</h3>
	<div id="register" class="filter-bar">
		날짜 : <input type="date" id="saleDate"/>
		<button id="search">조회</button>
		<button id="sale-register" disabled>매출 등록</button>
	</div>	
	
	<h5 id="total"></h5>
	
	<div>	
		<table border="1" id="result" class="data-table">
			
		</table>
	</div>
	
	<script src="../resources/js/fm/saleRegister.js"></script>
</body>
</html>