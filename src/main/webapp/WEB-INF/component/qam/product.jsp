<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제품 목록</title>
<!--    <link rel="stylesheet" href="<c:url value='/resources/css/product.css' />">-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2 class="title">제품 목록</h2>

<table id="productTable">
    <thead>
        <tr>
            <th>제품 번호</th>
            <th>생산일</th>
            <th>제품 코드</th>
        </tr>
    </thead>
    <tbody>
        <!-- Data will be inserted here via JavaScript -->
    </tbody>
</table>

<script>
    $(document).ready(function () {
        $.ajax({
            url: "/showProduct",
            method: "GET",
			success: function (data) {
			    console.log("Data fetched:", data); // Add this
			    const tbody = $("#productTable tbody");
			    if (data.length === 0) {
			        tbody.append("<tr><td colspan='3'>등록된 제품이 없습니다.</td></tr>");
			    } else {
			        data.forEach(function (product) {
			            console.log("▶ Product:", product); // Add this
			            tbody.append(`<tr><td>${product.productNo}</td><td>${product.productionDate}</td><td>${product.productCode}</td></tr>`);
			        });
			    }
			},

            error: function () {
                alert("제품 목록을 불러오는데 실패했습니다.");
            }
        });
    });
</script>

</body>
</html>

