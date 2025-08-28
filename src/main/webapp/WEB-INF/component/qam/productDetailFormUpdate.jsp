<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용 위한 태그 라이브러리 설정 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 정보 수정</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" href="../resources/css/qam/qamForm.css"/>
</head>
<body>
	
<!-- 현재 기용 X, jsp에 상품 수정을 없애고 삭제만 남겨둠 -->
	
	<h5>[품질 관리] > [상품 조회] > [상품 정보 수정]</h5>
	<h3>상품 정보 수정</h3>

	<form action="/updateProduct" method="post" class="filter-bar">
		<div class="box">
	    <input type="hidden" name="productNo" value="${product.productNo}" />
	    <input type="hidden" name="productCode" value="${product.productCode}" />
		
		<table>
			<tr>
			    <th>생산일</th>
			    <td><input type="date" name="productionDate" value="${product.productionDate}" required /></td>
		    </tr>
			<tr>
			    <th>색상</th>
			    <td><input type="text" name="productColor" value="${product.productColor}" required /></td>
			</tr>
			<tr>
			    <th>제품명</th>
			    <td><input type="text" name="productName" value="${product.productName}" required /></td>
			</tr>
			<tr>
			    <th>판매가</th>
			    <td><input type="number" name="productPrice" value="${product.productPrice}" required /></td>
			</tr>
			<tr>
			    <th>단가</th>
			    <td><input type="number" name="productCost" value="${product.productCost}" required /></td>
			</tr>
			<tr>
			    <th>카테고리</th>
			    <td><select name="productCategory">
				    <option value="상의" ${product.productCategory == '상의' ? 'selected' : ''}>상의</option>
				    <option value="하의" ${product.productCategory == '하의' ? 'selected' : ''}>하의</option>
				    <option value="악세사리" ${product.productCategory == '악세사리' ? 'selected' : ''}>악세사리</option>
				    <option value="신발" ${product.productCategory == '신발' ? 'selected' : ''}>신발</option>
				</select></td>
			</tr>
		</table>
		</div>
	    <div>
		    <button type="submit" class="btn">저장</button>
			<a href="/qam/product" class="btn">목록으로</a>
		</div>
	</form>
	
</body>
</html>
