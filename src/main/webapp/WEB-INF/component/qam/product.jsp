<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제품 조회</title>
    <!-- CSS 적용은 주석처리된 상태 (추후 디자인 작업 시 해제 가능) -->
    <!-- <link rel="stylesheet" href="<c:url value='/resources/css/product.css' />"> -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 로드 -->
</head>

<body>
<h2>제품 조회</h2>

<!-- ✅ 검색창 영역 -->
<form id="searchForm">
    제품명: <input type="text" id="productName" /> <!-- 제품명 입력 -->
    <select id="productCategory"> <!-- 카테고리 선택 -->
        <option value="">카테고리 선택</option>
        <option value="상의">상의</option>
        <option value="하의">하의</option>
        <option value="악세사리">악세사리</option>
        <option value="신발">신발</option>
    </select>
    <button type="submit">검색</button> <!-- 검색 버튼 -->
    <button type="button" id="resetBtn">전체보기</button> <!-- 전체보기 버튼 -->
</form>
<br/>

<!-- ✅ 제품 목록 테이블 -->
<table border="1" id="result">
    <tr>
        <th>제품 번호</th><th>생산일</th><th>제품 코드</th>
        <th>색상</th><th>제품명</th><th>판매가</th>
        <th>단가</th><th>카테고리</th><th>수정</th><th>삭제</th>
    </tr>
</table>

<script>
// ✅ 화면에 제품 목록을 렌더링하는 함수
function displayProducts(data) {
    // 테이블 헤더 재설정
    let tableHead = "<tr><th>제품 번호</th><th>생산일</th><th>제품 코드</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>카테고리</th><th>수정</th><th>삭제</th></tr>";
    $("#result").html(tableHead);

    // 데이터 배열을 순회하며 행을 추가
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
        row += "<td><a href='/productFormUpdate?productNo=" + p.productNo + "'>수정</a></td>"; // 수정 페이지로 이동
        row += "<td><a href='/deleteProduct?productNo=" + p.productNo + "' onclick='return confirm(\"정말 삭제하시겠습니까?\")'>삭제</a></td>"; // 삭제 확인 후 요청
        row += "</tr>";
        $("#result").append(row);
    }
}

$(document).ready(function () {
    // ✅ 페이지 로딩 시 전체 제품 리스트 가져오기
    $.ajax({
        type: "get",
        url: "/showProduct",
        success: function (result) {
            displayProducts(result); // 결과를 테이블에 렌더링
        }
    });

    // ✅ 검색 기능 처리
    $("#searchForm").submit(function (e) {
        e.preventDefault(); // form 기본 동작 막기

        $.ajax({
            type: "get",
            url: "/searchProduct",
            data: {
                productName: $("#productName").val(), // 제품명 값
                productCategory: $("#productCategory").val() // 카테고리 값
            },
            success: function (result) {
                displayProducts(result); // 결과 출력
            }
        });
    });

    // ✅ 전체보기 버튼 클릭 시 다시 전체 리스트 불러오기
    $("#resetBtn").click(function () {
        // 입력창 초기화
        $("#productName").val("");
        $("#productCategory").val("");

        // 전체 목록 다시 불러오기
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
