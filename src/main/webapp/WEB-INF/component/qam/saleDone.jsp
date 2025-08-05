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

<table border="1" id="saleResult">
    <tr>
		<th>판매코드</th>
        <th>제품번호</th>
        <th>제품코드</th>
        <th>가격</th>
		<th>판매날짜</th>
	</tr>
</table>
		
<script>
	function displaySale(data) {
		let tableHead = "<tr><th>판매코드</th><th>제품번호</th><th>제품코드</th><th>가격</th><th>판매날짜</th></tr>"
		$("#saleResult").html(tableHead);
		
		for (let s of data) {
				let row = "<tr>";
				row += "<td>" + s.saleNo + "</td>";
				row += "<td>" + s.productNo + "</td>";
				row += "<td>" + s.productCode + "</td>";
				row += "<td>" + s.productPrice + "</td>";
				row += "<td>" + s.saleDate + "</td>";

				row += "</tr>"
				$("#saleResult").append(row);
				}
			}
	$(document).ready(function() {
		$.ajax({
				type: "get",
				url: "/qam/showSaleDone",
				success: function (result) {
					displaySale(result);
				}
			});
		});
	
</script>

</body>
</html>
