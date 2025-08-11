<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>브랜드 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>

<body>
<h2>브랜드 조회</h2>

<a href="/brandForm">
    <button>브랜드 신규 등록</button>
</a>

<form id="searchBrand">
</form>

<table border="1" id="result">
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
		    <td><a href='/brandFormUpdate?brandCode=${b.brandCode}'>수정</a></td>
		    <td><a href='/deleteBrand?brandCode=${b.brandCode}'>삭제</a></td>
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

<script>

</script>

</body>
</html>
