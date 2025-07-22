<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품명 등록/수정</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
    <h2>제품 정보 등록 / 수정</h2>

    <form action="${action}" method="post">
        <input type="hidden" name="productCode" value="${productName.productCode}" />

        <label>색상: <input type="text" name="productColor" value="${productName.productColor}" required /></label><br/>
        <label>제품명: <input type="text" name="productName" value="${productName.productName}" required /></label><br/>
        <label>판매가: <input type="number" name="productPrice" value="${productName.productPrice}" required /></label><br/>
        <label>단가: <input type="number" name="productCost" value="${productName.productCost}" required /></label><br/>
        <label>카테고리:
            <select name="productCategory">
                <option value="상의" ${productName.productCategory == '상의' ? 'selected' : ''}>상의</option>
                <option value="하의" ${productName.productCategory == '하의' ? 'selected' : ''}>하의</option>
                <option value="악세사리" ${productName.productCategory == '악세사리' ? 'selected' : ''}>악세사리</option>
                <option value="신발" ${productName.productCategory == '신발' ? 'selected' : ''}>신발</option>
            </select>
        </label><br/><br/>

        <button type="submit">저장</button>
    </form>

    <a href="/qam/productName">목록으로</a>
</body>
</html>
