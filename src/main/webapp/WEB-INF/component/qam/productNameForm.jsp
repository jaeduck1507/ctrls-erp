<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용 선언 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품명 등록/수정</title> <!-- 페이지 제목 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> <!-- jQuery 로드 -->
</head>
<body>

<h2>제품 정보 등록 / 수정</h2> <!-- 제목 표시 -->

<!-- ✅ 제품명 등록/수정 공용 폼 -->
<!-- Controller에서 action URL과 productName 객체를 전달함 -->
<form action="${action}" method="post">
    <!-- ✅ 수정 시 필요한 고유 코드 (productCode) 숨김 전송 -->
    <input type="hidden" name="productCode" value="${productName.productCode}" />

    <!-- ✅ 색상 입력 -->
    <label>색상:
        <input type="text" name="productColor" value="${productName.productColor}" required />
    </label><br/>

    <!-- ✅ 제품명 입력 -->
    <label>제품명:
        <input type="text" name="productName" value="${productName.productName}" required />
    </label><br/>

    <!-- ✅ 판매가 입력 -->
    <label>판매가:
        <input type="number" name="productPrice" value="${productName.productPrice}" required />
    </label><br/>

    <!-- ✅ 단가 입력 -->
    <label>단가:
        <input type="number" name="productCost" value="${productName.productCost}" required />
    </label><br/>

    <!-- ✅ 카테고리 선택 -->
    <label>카테고리:
        <select name="productCategory">
            <option value="상의" ${productName.productCategory == '상의' ? 'selected' : ''}>상의</option>
            <option value="하의" ${productName.productCategory == '하의' ? 'selected' : ''}>하의</option>
            <option value="악세사리" ${productName.productCategory == '악세사리' ? 'selected' : ''}>악세사리</option>
            <option value="신발" ${productName.productCategory == '신발' ? 'selected' : ''}>신발</option>
        </select>
    </label><br/><br/>

    <!-- ✅ 저장 버튼 -->
    <button type="submit">저장</button>
</form>

<!-- ✅ 목록 페이지로 돌아가기 링크 -->
<a href="/qam/productName">목록으로</a>

</body>
</html>
