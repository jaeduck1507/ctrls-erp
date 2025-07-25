<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용 위한 태그 라이브러리 설정 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품 정보 수정</title> <!-- 페이지 제목 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<h2>제품 정보 수정</h2> <!-- 제목 표시 -->

<!-- ✅ 제품 정보 수정 폼 -->
<!-- action: /updateProduct (Controller로 POST 전송됨) -->
<form action="/updateProduct" method="post">
    <!-- 제품 번호 (product 테이블 PK) - 숨김 필드 -->
    <input type="hidden" name="productNo" value="${product.productNo}" />

    <!-- 제품 코드 (product_name 테이블 FK) - 숨김 필드 -->
    <input type="hidden" name="productCode" value="${product.productCode}" />

    <!-- ✅ 생산일 입력 -->
    <label>생산일:
        <input type="date" name="productionDate" value="${product.productionDate}" required />
    </label><br/>

    <!-- ✅ 색상 입력 -->
    <label>색상:
        <input type="text" name="productColor" value="${product.productColor}" required />
    </label><br/>

    <!-- ✅ 제품명 입력 -->
    <label>제품명:
        <input type="text" name="productName" value="${product.productName}" required />
    </label><br/>

    <!-- ✅ 판매가 입력 -->
    <label>판매가:
        <input type="number" name="productPrice" value="${product.productPrice}" required />
    </label><br/>

    <!-- ✅ 단가 입력 -->
    <label>단가:
        <input type="number" name="productCost" value="${product.productCost}" required />
    </label><br/>

    <!-- ✅ 카테고리 선택 -->
    <label>카테고리:
        <select name="productCategory">
            <option value="상의" ${product.productCategory == '상의' ? 'selected' : ''}>상의</option>
            <option value="하의" ${product.productCategory == '하의' ? 'selected' : ''}>하의</option>
            <option value="악세사리" ${product.productCategory == '악세사리' ? 'selected' : ''}>악세사리</option>
            <option value="신발" ${product.productCategory == '신발' ? 'selected' : ''}>신발</option>
        </select>
    </label><br/><br/>

    <!-- ✅ 저장 버튼 -->
    <button type="submit">저장</button>
</form>

<!-- ✅ 목록으로 이동 링크 -->
<a href="/qam/product">목록으로</a>
</body>
</html>
