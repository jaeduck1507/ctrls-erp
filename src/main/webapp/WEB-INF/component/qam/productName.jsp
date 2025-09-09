<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용 선언 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 정보 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
<h5>[제품 관리] > [제품 정보 조회]</h5>
<h3>제품 정보 조회</h3>
<div class="filter-bar">
<a href="/productNameForm">제품 신규 등록</a>

<form action="productName">
    제품명 : <input type="text" name="productName" id="productName" />
	<select name="productCategory" id="productCategory">
		<option value="">카테고리 선택</option>
		<c:forEach items="${categoryList}" var="category">
			<option value="${category}">${category}</option>
		</c:forEach>
	</select>
    <button type="submit">검색</button>
</form>
</div>

<table border="1" id="result" class="data-table">
	<tr>
		<th>제품 코드</th>
		<th>브랜드코드</th>
		<th>브랜드</th>
		<th>카테고리</th>
		<th>색상</th>
		<th>제품명</th>
		<th>판매가</th>
		<th>단가</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	
	<c:forEach items="${productNameList}" var="pn">
	    <tr>
	        <td>${pn.productCode}</td>
	        <td>${pn.brandCode}</td>
	        <td>${pn.brandName}</td>
	        <td>${pn.productCategory}</td>
	        <td>${pn.productColor}</td>
	        <td>${pn.productName}</td>
	        <td>${pn.productPrice}</td>
	        <td>${pn.productCost}</td>
	        <td><a href='/productNameForm?productCode=${pn.productCode}' class="btnO">수정</a></td>
	        <td>
	            <a href='/deleteProductName?productCode=${pn.productCode}' class="btnX">삭제</a>
	        </td>
	    </tr>
	</c:forEach>
	
</table>

<nav>
    <ul class="pagination">
		<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/qam/productName?page=${paging.startPage - 1}&productName=${productName}&productCategory=${productCategory}">Previous</a></li>			
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
					<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/qam/productName?page=${page}&productName=${productName}&productCategory=${productCategory}">${page}</a></li>
				</c:forEach>
		<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/qam/productName?page=${paging.endPage + 1}&productName=${productName}&productCategory=${productCategory}">Next</a></li>
    </ul>
</nav>

<script src="../resources/js/qam/productName.js"></script>

</body>
</html>
