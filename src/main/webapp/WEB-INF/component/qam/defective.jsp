<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>불량품 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link rel="stylesheet" href="../resources/css/basic.css"/>
</head>

<body>
	<h5>[품질 관리] > [불량품 조회]</h5>
	<h3>불량품 조회</h3>

<div class="filter-bar">
<form id="defectiveSearchForm">
	<div>
		<!-- 불량 유형 필터 체크박스 -->
		불량 유형:
		<label><input type="checkbox" class="defectiveFilter" id="checkMaterial" value="material" checked> 부자재 불량</label>
		<label><input type="checkbox" class="defectiveFilter" id="checkColor" value="color" checked> 색상 불량</label>
		<label><input type="checkbox" class="defectiveFilter" id="checkDamage" value="damage" checked> 손상 불량</label>
	</div>
	</br>	
	<div>
		카테고리 조회: 
		<select id="productCategory">
			<option value="">카테고리 선택</option>
			<c:forEach items="${categoryList}" var="category">
				<option value="${category}">${category}</option>
			</c:forEach>
		</select>
	</div>
	<div>
		검사일 조회 (시작일): <input type="date" id="startDate">
		(종료일): <input type="date" id="endDate"> 
		
		<button type="button" id="searchBtn">검색</button>
		<button type="button" id="resetBtn">전체보기</button>
	</div>
</form>
</div>

<div class="total">
	<h4 id="defectivePriceSum"></h4>
</div>

<table border="1" id="defectiveResult" class="data-table">
    <thead>
        <tr>
            <th>불량코드</th>
            <th>상품번호</th>
            <th>제품코드</th>
            <th>부자재검사</th>
            <th>색상검사</th>
            <th>손상검사</th>
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
