<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>판매완료 제품 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!--		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>-->
</head>

<body>
<h5>[품질 관리] > [판매완료 제품 조회]</h5>
<h3>판매완료 제품 조회</h3>
<div class="filter-bar">
<form id="saleSearchForm">
	카테고리 조회:
	<select id="productCategory">
	    <option value="">카테고리 선택</option>
	    <option value="상의">상의</option>
	    <option value="하의">하의</option>
	    <option value="악세사리">악세사리</option>
	    <option value="신발">신발</option>
	</select>
	판매일 조회 (시작일): <input type="date" id="startDate">
	(종료일): <input type="date" id="endDate"> 
	
	<button type="button" id="searchBtn">조회</button>
	<button type="button" id="resetBtn">전체보기</button>
</form>
</div>

<div class="total">
	<h4 id="salePriceSum">
			<!-- 총 가격 출력 영역 -->
	</h4>
</div>
	
<table border="1" id="saleResult" class="data-table">
    <tr>
		<th>판매코드</th>
        <th>제품번호</th>
        <th>제품코드</th>
		<th>브랜드명</th>
		<th>카테고리</th>
		<th>제품명</th>
        <th>가격</th>
		<th>판매날짜</th>
	</tr>
</table>

<nav>
	<ul class="pagination">
	</ul>
</nav>

<script src="../resources/js/qam/saleDone.js"></script>

</body>
</html>
