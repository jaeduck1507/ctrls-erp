<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>판매대기 제품 리스트</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>

<body>
	<h5>[품질 관리] > [판매대기 제품 리스트]</h5>
	<h3>판매대기 제품 리스트</h3>
	<div class="filter-bar">


<button id = "sellRegister">판매 등록</button> 
<button id = "selectCurrentTable">현재 페이지 전체 선택</button> 
<button id = "selectAlldata">모든 페이지 전체 선택</button> 
<button id = "selectCancelCurrentTable">현재 페이지 전체 선택 취소</button> 
<button id = "selectCancelAlldata">모든 페이지 전체 선택 취소</button> 
</div>
<table border="1" id="saleReady" class="data-table"> <!-- saleReady 테이블 -->
    
</table>
<nav>
	<ul class="pagination">
	</ul>
</nav>

<script src="../resources/js/qam/saleReady.js"></script>

</body>
</html>
