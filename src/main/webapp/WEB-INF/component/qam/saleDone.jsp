<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>판매완료 제품 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>판매완료 제품 조회</h2>

<h3 id="salePriceSum">
	<!-- 총 가격 출력 영역 -->
</h3>

<form id="saleSearchForm">
	카테고리 조회:
	<select id="productCategory">
	    <option value="">카테고리 선택</option>
	    <option value="상의">상의</option>
	    <option value="하의">하의</option>
	    <option value="악세사리">악세사리</option>
	    <option value="신발">신발</option>
	</select>
	<button type="button" id="searchBtn">조회</button>
	<button type="button" id="resetBtn">전체보기</button>
</form>

<table border="1" id="saleResult">
    <tr>
		<th>판매코드</th>
        <th>제품번호</th>
        <th>제품코드</th>
		<th>카테고리</th>
		<th>제품명</th>
        <th>가격</th>
		<th>판매날짜</th>
	</tr>
</table>
		
<script>
	function displaySale(data) {
		let tableHead = "<tr><th>판매코드</th><th>제품번호</th><th>제품코드</th><th>카테고리</th><th>제품명</th><th>가격</th><th>판매날짜</th></tr>"
		$("#saleResult").html(tableHead);
		
		// 가격 총합 변수 (int)
		var total = 0;

		for (var i = 0; i < data.length; i++) {
					var s = data[i];
					total += s.productPrice;

				let row = "<tr>";
				row += "<td>" + s.saleNo + "</td>";
				row += "<td>" + s.productNo + "</td>";
				row += "<td>" + s.productCode + "</td>";
				row += "<td>" + s.productCategory + "</td>";
				row += "<td>" + s.productName + "</td>";
				row += "<td>" + s.productPrice + "</td>";
				row += "<td>" + s.saleDate + "</td>";
				row += "</tr>"
				$("#saleResult").append(row);
				}
				document.getElementById("salePriceSum").innerText = "매출 총합: " + total.toLocaleString() + "원";
			}
	$(document).ready(function() {
		
		$.ajax({
			type: "get",
			url: "/qam/showSaleDone",
			success: function (result) {
				displaySale(result);
			}
		});
		
		// 조회 버튼 이벤트
		$("#searchBtn").click(function () {
			
			$.ajax({
				type: "get",
				url: "/qam/searchSaleDone", 
				data: {
					productCategory: $("#productCategory").val(),
				},
				success: function (result) {
					displaySale(result);
				}
			});
		});

		// 전체보기 버튼 이벤트
		$("#resetBtn").click(function () {
			$("#productCategory").val("");

			$.ajax({
				type: "get",
				url: "/qam/showSaleDone",
				success: function (result) {
					displaySale(result);
				}
			});
		});
		
		});
	
</script>

</body>
</html>
