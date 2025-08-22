<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용 선언 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품명 등록/수정</title> <!-- 페이지 제목 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" href="../resources/css/qamForm.css"/>
</head>
<body>
	<h5>[품질 관리] > [브랜드 조회] > [제품 정보 수정/등록]</h5>
	<h3>제품 정보 수정/등록</h3>

<form action="${action}" method="post" class="filter-bar">
    <input type="hidden" name="productCode" value="${productName.productCode}" />

	<div class="box">
		<table>
			<tr>
				<th>브랜드</th>
				<td>				
					<select name="brandCode">
					        <c:forEach var="brand" items="${brandList}">
					            <option value="${brand.brandCode}" ${productName.brandCode == brand.brandCode ? 'selected' : ''}>${brand.brandName}</option>
					        </c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>				
					<select name="productCategory">
					    <c:forEach var="category" items="${categoryList}">
					        <option value="${category}" ${productName.productCategory == category ? 'selected' : ''}>${category}</option>
					    </c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>제품명</th>
				<td><input type="text" name="productName" value="${productName.productName}" required /></td>
			</tr>
			<tr>
				<th>색상</th>
				<td><input type="text" name="productColor" value="${productName.productColor}" required /></td>
			</tr>
			<tr>
				<th>판매가</th>
				<td><input type="number" name="productPrice" value="${productName.productPrice}" required /></td>
			</tr>
			<tr>
				<th>단가</th>
				<td><input type="number" name="productCost" value="${productName.productCost}" required /></td>
			</tr>
		</table>
	</div>
	
	<div>
    <button type="submit" class="btn">저장</button>
	<a href="/qam/productName" class="btn">목록으로</a>
	</div>
	
</form>

</body>
</html>
