<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>판매/대기 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>판매/대기 조회</h2>

<table border="1" id="saleResult">
    <tr>
        <th>판매번호</th>
        <th>판매날짜</th>
        <th>제품번호</th>
	</tr>
</table>
		
<script>
	function displaySale(data) {
		let tableHead = "<tr><th>판매번호</th><th>판매날짜</th><th>제품번호</th></tr>"
		$("#saleResult").html(tableHead);
		
		for (let s of data) {
				let row = "<tr>";
				row += "<td>" + s.saleNo + "</td>";
				row += "<td>" + s.saleDate + "</td>";
				row += "<td>" + s.productNo + "</td>";
				row += "</tr>"
				$("#saleResult").append(row);
				}
			}
	$(document).ready(function() {
		$.ajax({
				type: "get",
				url: "/qam/showSale",
				success: function (result) {
					displaySale(result);
				}
			});
		});
	
</script>

</body>
</html>
