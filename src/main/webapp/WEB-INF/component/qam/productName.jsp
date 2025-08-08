<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용 선언 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 정보 조회</title> <!-- 페이지 제목 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> <!-- jQuery 로드 -->
</head>

<body>

<h1>제품 정보 조회</h1> <!-- 타이틀 -->

<!-- 제품명 신규 등록 버튼 -->
<a href="/productNameForm">
    <button>제품 신규 등록</button>
</a>

<!-- 검색창: 제품명 + 카테고리 -->
<form id="searchForm">
    제품명 : <input type="text" name="productName" id="productName" />
    <select name="productCategory" id="productCategory">
        <option value="">카테고리 선택</option>
        <option value="상의">상의</option>
        <option value="하의">하의</option>
        <option value="악세사리">악세사리</option>
        <option value="신발">신발</option>
    </select>
    <button type="submit">검색</button> <!-- 검색 버튼 -->
</form>

<!-- 검색 및 전체 조회 결과 출력 테이블 -->
<table border="1" id="result">
</table>

<script>
    $(document).ready(function() {

        // 검색 폼 제출 시 AJAX 요청
        $("#searchForm").submit(function (e) {
            e.preventDefault(); // form 기본 제출 막기

            $.ajax({
                type: "get",
                url: "/searchProductName", // 검색 요청 URL
                data: {
                    productName: $("#productName").val(),
                    productCategory: $("#productCategory").val()
                },
                success: function (result) {
                    // 결과 테이블 초기화 후 헤더 생성
                    $("#result").html("");
                    $("#result").append("<tr><th>제품 코드</th><th>브랜드코드</th><th>브랜드</th><th>카테고리</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>수정</th><th>삭제</th></tr>");
                    // 데이터 순회하며 행 생성
                    for (const pn of result) {
                        let row = "<tr><td>" + pn.productCode + "</td><td>" + pn.brandCode + "</td><td>" + pn.brandName + "</td><td>" + pn.productCategory + "</td><td>" + pn.productColor + "</td><td>" + pn.productName + "</td><td>" + pn.productPrice + "</td><td>" + pn.productCost + "</td>";
                        row += "<td><a href='/productNameForm?productCode=" + pn.productCode + "'>수정</a></td>";
                        row += "<td><a href='/deleteProductName?productCode=" + pn.productCode + "' onclick='return confirm(\"정말 삭제하시겠습니까?\")'>삭제</a></td></tr>";
                        $("#result").append(row);
                    }
                }
            });
        });

        // 페이지 로딩 시 전체 제품명 목록 조회
        $.ajax({
            type: "get", 
            url: "/showProductName", // 전체 조회 URL
            success: function(result) {
                // 테이블 초기화 + 헤더 생성
                $("#result").html(""); 
                $("#result").append("<tr><th>제품 코드</th><th>브랜드코드</th><th>브랜드</th><th>카테고리</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>수정</th><th>삭제</th></tr>");

                // 각 제품명 객체를 테이블에 추가
                for (const pn of result) {
                    var text = "<tr>";
                    text += "<td>" + pn.productCode + "</td>";
					text += "<td>" + pn.brandCode + "</td>";
					text += "<td>" + pn.brandName + "</td>";
					text += "<td>" + pn.productCategory + "</td>";
                    text += "<td>" + pn.productColor + "</td>";
                    text += "<td>" + pn.productName + "</td>";
                    text += "<td>" + pn.productPrice + "</td>";
                    text += "<td>" + pn.productCost + "</td>";
                    text += "<td><a href='/productNameForm?productCode=" + pn.productCode + "'>수정</a></td>";
                    text += "<td><a href='/deleteProductName?productCode=" + pn.productCode + "' onclick='return confirm(\"정말 삭제하시겠습니까?\")'>삭제</a></td>";
                    text += "</tr>";
                    $("#result").append(text);
                }
            },
            error: function(xhr, status, error) {
                // 오류 발생 시 처리 (필요 시 알림 등)
            }
        });
    });
</script>

</body>
</html>
