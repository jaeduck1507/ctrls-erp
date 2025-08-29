<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 결과 목록</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" href="../resources/css/basic.css"/>
</head>
<body>
	<h5>[품질 관리] > [품질검사 결과 목록]</h5>
	<h3>품질검사 결과 목록</h3>
	<div class="filter-bar">
<!--<h3>(QC 1차 완료된 제품들만 조회, 미완료 제품들은 신규 검사 등록에서 select후 QC)</h3>-->

<!-- QC 등록 버튼 -->
<a href="/qam/qcForm">신규 검사 등록</a> <br>

<form id = "searchForm">
		제품 조회: <select id ="productName">
					<option value="">제품 선택</option>
				</select>
		카테고리 조회: <select id="productCategory">
					    <option value="">카테고리 선택</option>
					    <option value="상의">상의</option>
					    <option value="하의">하의</option>
					    <option value="악세사리">악세사리</option>
					    <option value="신발">신발</option>
					</select>
					<br>
		검사자 사번: <select id="empNo">
			        <option value="">사번 선택</option>
			        <c:forEach var="e" items="${empList}">
			            <option value="${e.empNo}">
			                [${e.empNo}] ${e.empName}
			            </option>
			        </c:forEach>
		    	</select>
		생산일 조회 (시작일): <input type="date" id="startDate">
		(종료일): <input type="date" id="endDate">
		<button type="submit" class="btnO">조회</button> <!-- button type 지정 안할 시 default => submit -->
		<button type="button" id="resetBtn">전체보기</button>
</form>
</div>
<!-- 테이블 -->
<table border="1" id="qcResult" class="data-table">
    <tr>
        <th>제품번호</th>
		<th>qc코드</th>
        <th>생산일</th>
        <th>제품코드</th>
		<th>브랜드명</th>
        <th>색상</th>
        <th>제품명</th>
        <th>판매가</th>
		<th>단가</th>
		<th>카테고리</th>
		<th>부자재검사</th>
		<th>색상검사</th>
		<th>손상검사</th>
		<th>검사 설명</th>
        <th>검사일</th>
		<th>검사자</th>
        <th>수정</th>
    </tr>
</table>

<nav>
    <ul class="pagination">
		<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/qam/qc?page=${paging.startPage - 1}&productName=${productName}&productCategory=${productCategory}&empNo=${empNo}&startDate=${startDate}&endDate=${endDate}">Previous</a></li>			
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
					<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/qam/qc?page=${paging.startPage - 1}&productName=${productName}&productCategory=${productCategory}&empNo=${empNo}&startDate=${startDate}&endDate=${endDate}">${page}</a></li>
				</c:forEach>
		<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/qam/qc?page=${paging.startPage - 1}&productName=${productName}&productCategory=${productCategory}&empNo=${empNo}&startDate=${startDate}&endDate=${endDate}">Next</a></li>
    </ul>
</nav>

<script src="../resources/js/qam/qc.js"></script>

</body>
</html>
