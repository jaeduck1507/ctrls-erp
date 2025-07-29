<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제품 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>제품 조회</h2>

<!-- 검색창 -->
<form id="searchForm">
    제품명: <input type="text" id="productName" />
    <select id="productCategory">
        <option value="">카테고리 선택</option>
        <option value="상의">상의</option>
        <option value="하의">하의</option>
        <option value="악세사리">악세사리</option>
        <option value="신발">신발</option>
    </select>
    <button type="submit">검색</button>
    <button type="button" id="resetBtn">전체보기</button>
</form>
<br/>

<!-- 제품 목록 테이블 -->
<table border="1" id="result">
    <tr>
        <th>제품 번호</th><th>생산일</th><th>제품 코드</th>
        <th>색상</th><th>제품명</th><th>판매가</th>
        <th>단가</th><th>카테고리</th><th>수정</th><th>삭제</th>
    </tr>
</table>

<script>
function displayProducts(data) {
    // 테이블 헤더 초기화
    let tableHead = "<tr><th>제품 번호</th><th>생산일</th><th>제품 코드</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>카테고리</th><th>수정</th><th>삭제</th></tr>";
    $("#result").html(tableHead);

    // 각 제품 행 기입
    for (let p of data) {
        let row = "<tr>";
        row += "<td>" + p.productNo + "</td>";
        row += "<td>" + p.productionDate + "</td>";
        row += "<td>" + p.productCode + "</td>";
        row += "<td>" + p.productColor + "</td>";
        row += "<td>" + p.productName + "</td>";
        row += "<td>" + p.productPrice + "</td>";
        row += "<td>" + p.productCost + "</td>";
        row += "<td>" + p.productCategory + "</td>";
        row += "<td><a href='/productDetailFormUpdate?productNo=" + p.productNo + "'>수정</a></td>";
        row += "<td><a href='/deleteProduct?productNo=" + p.productNo + "'>삭제</a></td>";
        row += "</tr>";
        $("#result").append(row);
    }
}

$(document).ready(function () {
    // 전체 제품 불러오기 (초기 로딩)
    $.ajax({
        type: "get",
        url: "/showProduct",
        success: function (result) {
            displayProducts(result);
        }
    });

    // 검색 버튼 처리
    $("#searchForm").submit(function (e) {
        e.preventDefault(); // form 전송 막기

        $.ajax({
            type: "get",
            url: "/searchProduct",
            data: {
                productName: $("#productName").val(),
                productCategory: $("#productCategory").val()
            },
            success: function (result) {
                displayProducts(result);
            }
        });
    });

    // 전체보기 버튼
    $("#resetBtn").click(function () {
        $("#productName").val("");
        $("#productCategory").val("");

        $.ajax({
            type: "get",
            url: "/showProduct",
            success: function (result) {
                displayProducts(result);
            }
        });
    });
});
</script>

</body>
</html>
