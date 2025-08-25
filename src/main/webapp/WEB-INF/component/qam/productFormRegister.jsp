<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 선언 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품 등록</title> <!-- 페이지 제목 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> <!-- jQuery CDN -->
</head>
<body>
    <h2>제품 등록</h2> 

	
<!--	이 페이지도 사용 X, 현재 매입으로만 상품은 추가 가능하도록 기능 구현, 상품 페이지 자체에서 상품 등록 불가능! -->
	
	
	
	
	
    <!-- 제품 등록 폼 시작 -->
    <!-- action은 Controller에서 동적으로 결정 (등록/수정 겸용 설계) -->
    <form action="${action}" method="post">
        <!-- 생산일 입력 필드 -->
        <label>생산일:
            <input type="date" name="productionDate" required />
        </label><br/>

        <!-- 제품명 선택 드롭다운 -->
        <label>제품 코드:
            <select name="productCode" required id="productCodeSelect">
                <!-- AJAX로 product_name 목록을 불러와서 동적으로 option 생성 -->
            </select>
        </label><br/><br/>

        <!-- 등록 버튼 -->
        <button type="submit">저장</button>
    </form>

    <!-- 목록으로 돌아가기 -->
    <a href="/qam/product">목록으로</a>

    <!-- 제품명 목록 불러오기 (AJAX) -->
    <script>
        $(document).ready(function () {
            $.ajax({
                type: "get", // 요청 방식
                url: "/showProductName", // 제품명 목록을 요청할 API
                success: function (result) {
                    var select = $("#productCodeSelect"); // 드롭다운 select 요소
                    select.empty(); // 기존 옵션 초기화

                    // 받은 데이터로 option 항목 생성
                    for (var p of result) {
                        var label = "[" + p.productCode + "] " + p.productName + " - " + p.productColor;
                        var option = `<option value="${p.productCode}">${label}</option>`;
                        select.append(option);
                    }
                },
                error: function (xhr, status, error) {
                    // 에러 처리 (필요 시 작성 가능)
                }
            });
        });
    </script>
</body>
</html>
