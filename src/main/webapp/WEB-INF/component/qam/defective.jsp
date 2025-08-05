<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>불량품 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>불량품 조회</h2>

<form id="searchForm">
	<!-- 추후 검색 조건 추가 가능 -->
</form>

<table border="1" id="defectiveResult">
    <tr>
        <th>불량코드</th>
        <th>제품번호</th>
        <th>제품코드</th>
		<th>제품명</th>
		<th>제품가격</th>
		<th>불량사유</th>
	</tr>
</table>
	

<div id="priceSum">
	<!-- 총 가격 출력 영역 -->
</div>

<script>
	function displayDefective(data) {
		let tableHead = "<tr><th>불량코드</th><th>제품번호</th><th>제품코드</th><th>제품명</th><th>제품가격</th><th>불량사유</th></tr>"
		$("#defectiveResult").html(tableHead);
		
		// 가격 총합 변수 (int)
		var total = 0;

		for (var i = 0; i < data.length; i++) {
					var d = data[i];
					total += d.productPrice;

				let row = "<tr>";
				row += "<td>" + d.defectiveNo + "</td>";
				row += "<td>" + d.productNo + "</td>";
				row += "<td>" + d.productCode + "</td>";
				row += "<td>" + d.productName + "</td>";
				row += "<td>" + d.productPrice + "</td>";
				row += "<td>" + d.reason + "</td>";
//				row += "<td><a href='/qam/defectiveUpdate?defectiveNo=" + d.defectiveNo + "'>수정</a></td>";
				row += "</tr>"
				$("#defectiveResult").append(row);
				}
				
				document.getElementById("priceSum").innerText = "손실액 총합: " + total + "원";
				
			}
	$(document).ready(function() {
		$.ajax({
				type: "get",
				url: "/qam/showDefective",
				success: function (result) {
					displayDefective(result);
				}
			});
			
		
			
		});
	
</script>

</body>
</html>
