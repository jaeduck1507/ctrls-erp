<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>불량품 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>

<body>
	<h5>[품질 관리] > [불량품 조회]</h5>
		<h3>불량품 조회</h3>

<div class="filter-bar">
<form id="defectiveSearchForm">
	<!-- 불량 유형 필터 체크박스 -->
	불량 유형:
	<label><input type="checkbox" class="defectiveFilter" id="checkMaterial" value="material" checked> 부자재 불량</label>
	<label><input type="checkbox" class="defectiveFilter" id="checkColor" value="color" checked> 색상 불량</label>
	<label><input type="checkbox" class="defectiveFilter" id="checkDamage" value="damage" checked> 손상 불량</label>
</br>	
	카테고리 조회: <select id="productCategory">
	    <option value="">카테고리 선택</option>
	    <option value="상의">상의</option>
	    <option value="하의">하의</option>
	    <option value="악세사리">악세사리</option>
	    <option value="신발">신발</option>
	</select>
	
	검사일 조회 (시작일): <input type="date" id="startDate">
	(종료일): <input type="date" id="endDate"> 
	
	<button type="button" id="searchBtn">검색</button>
	<button type="button" id="resetBtn">전체보기</button>
</form>
</div>
<div class="total">
<h4 id="defectivePriceSum"></h4>
</div>
<table border="1" id="defectiveResult" class="data-table">
    <thead>
        <tr>
            <th>불량코드</th>
            <th>제품번호</th>
            <th>제품코드</th>
            <th>부자재검사 여부</th>
            <th>색상검사 여부</th>
            <th>손상검사 여부</th>
			<th>브랜드명</th>
			<th>카테고리</th>
            <th>제품명</th>
            <th>가격</th>
            <th>불량사유</th>
			<th>검사일</th>
        </tr>
    </thead>
    <tbody></tbody>
</table>

<nav>
	<ul class="pagination">
	</ul>
</nav>

<script src="../resources/js/qam/defective.js"></script>

</body>
</html>
