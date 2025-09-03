<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>브랜드 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
<h5>[품질 관리] > [브랜드 조회]</h5>
	<h3>브랜드 조회</h3>
<div class="filter-bar">
	<a href="/brandForm">브랜드 신규 등록</a>
</div>
<form id="searchBrand"></form>

<table border="1" id="result" class="data-table">
	<tr>
		<th>브랜드코드</th>
		<th>브랜드명</th>
		<th>전화번호</th>
		<th>계좌번호</th>
		<th>사용 은행</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	
	<c:forEach items="${brandList}" var="b">
		<tr>
		    <td>${b.brandCode}</td>
		    <td>${b.brandName}</td>
		    <td>${b.brandPhone}</td>
		    <td>${b.brandAccount}</td>
		    <td>${b.brandBank}</td>
		    <td><a href='/brandFormUpdate?brandCode=${b.brandCode}' class="btnO">수정</a></td>
		    <td><a href='/deleteBrand?brandCode=${b.brandCode}' class="btnX">삭제</a></td>
		</tr>
	</c:forEach>
</table>

<nav>
	<ul class="pagination">
		<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/qam/brand?page=${paging.startPage - 1}">Previous</a></li>
							
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
			<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/qam/brand?page=${page}">${page}</a></li>
		</c:forEach>
		
		<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/qam/brand?page=${paging.endPage + 1}">Next</a></li>
	</ul>
</nav>

<script src="../resources/js/qam/brand.js"></script>

</body>
</html>
