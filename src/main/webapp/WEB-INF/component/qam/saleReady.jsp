<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>판매대기 제품 리스트</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>판매대기 제품 리스트</h2>

<button id = "sellRegister">판매 등록</button>

<table border="1" id="saleReady">
    <tr>
		<th>판매코드</th>
		<th>제품번호</th>
		<th>제품코드</th>
		<th>카테고리</th>
		<th>제품명</th>
        <th>가격</th>
		<th>판매날짜(확인용)</th>
		<th>날짜입력</th>
	</tr>
</table>
	
<script>
	function displaySale(data) {
		let tableHead = "<tr><th>판매코드</th><th>제품번호</th><th>제품코드</th><th>카테고리</th><th>제품명</th><th>가격</th><th>판매날짜(확인용)</th><th>날짜입력</th></tr>"
		$("#saleReady").html(tableHead);
		
		for (let s of data) {
				let row = "<tr>";
				row += "<td>" + s.saleNo + "</td>";
				row += "<td>" + s.productNo + "</td>";
				row += "<td>" + s.productCode + "</td>";
				row += "<td>" + s.productCategory + "</td>";
				row += "<td>" + s.productName + "</td>";
				row += "<td>" + s.productPrice + "</td>";
				row += "<td>" + s.saleDate + "</td>";
				row += "<td><input type='date' class='sellDate'></td>";
				row += "</tr>"
				$("#saleReady").append(row);
				}
				$("#saleReady tr").find(".sellDate").val(new Date().toISOString().substring(0, 10));
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

				let saleNos = row.find("td").eq(0).text();
				let saleDates = row.find("td").eq(7).find("input").val(); 

				if (saleDates) {
					sellList.push({
						saleNo: saleNos,
						saleDate: saleDates // sellList [] 안에 saleNo, saleDate 삽입, s를 끝에 붙임으로 어느게 어느건지 가시화
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
