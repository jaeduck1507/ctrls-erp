<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>판매 전 제품 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>판매 전 제품 조회</h2>

<table border="1" id="saleReady">
    <tr>
        <th>제품번호</th>
        <th>제품코드</th>
        <th>가격</th>
		<th>판매코드</th>
		<th>판매날짜</th>
		<th>날짜입력</th>
	</tr>
</table>
<button id = "sellRegister">판매 등록</button>
		
<script>
	function displaySale(data) {
		let tableHead = "<tr><th>제품번호</th><th>제품코드</th><th>가격</th><th>판매코드</th><th>판매날짜</th><th>날짜입력</th></tr>"
		$("#saleReady").html(tableHead);
		
		for (let s of data) {
				let row = "<tr>";
				row += "<td>" + s.productNo + "</td>";
				row += "<td>" + s.productCode + "</td>";
				row += "<td>" + s.productPrice + "</td>";
				row += "<td>" + s.saleNo + "</td>";
				row += "<td>" + s.saleDate + "</td>";
				row += "<td><input type='date' class='sellDate'></td>";
				row += "</tr>"
				$("#saleReady").append(row);
				}
			}
			
	$(document).ready(function() {
		
		$.ajax({
				type: "get",
				url: "/qam/showSaleNull",
				success: function (result) {
					displaySale(result);
				}
			});
			
		$("#sellRegister").click(() => {
			const table = $("#saleReady tr");
			let sellList = [];

			for (let i = 1; i < table.length; i++) {
				let row = table.eq(i);

				let saleNo = row.find("td").eq(3).text();
				let saleDate = row.find("td").eq(5).find("input").val(); // 

				if (saleDate) {
					sellList.push({
						saleNo: saleNo,
						saleDate: saleDate
					});
				}
			}

			$.ajax({
				type: "post",
				url: "/qam/registerSaleDate",
				contentType: "application/json",
				data: JSON.stringify(sellList),
				success: function (result) {
					location.reload();
				},
				error: function (xhr, status, error) {
				}
			});
		});
	});
</script>

</body>
</html>
