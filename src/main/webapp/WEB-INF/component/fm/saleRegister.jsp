<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>saleRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>매출 등록</h1>
	<div id="register">
		날짜 : <input type="date" id="saleDate"/>
		<button id="search">조회</button>
		<button id="sale-register">매출 등록</button>
		
		<table border="1" id="result">
			
		</table>
	</div>
	
	<script>
		$("#search").click(() => {
			const formData = new FormData();
			formData.append("saleDate", $("#saleDate").val());
			console.log($("#saleDate").val());
			
			$.ajax({
				type: "post",
				url: "/dailySale",
				data: formData,
				processData: false,
				contentType: false,
				success: function(result) {
					$("#result").html("");
					$("#result").append("<tr><th>상품명</th><th>상품 코드</th><th>가격</th><th>수량</th><th>부가세</th><th>총액</th><th>매출 발생일자</th></tr>");
					for (const sale of result) {
						const totalAmount = sale.productPrice * sale.quantity;
						const varAmount = Math.floor(totalAmount - (totalAmount / 1.1));
						$("#result").append("<tr><td>" + sale.productName + "</td><td>" +sale.productCode + "</td><td>" + sale.productPrice + "</td><td>" + sale.quantity + "</td><td>" + varAmount + "</td><td>" + totalAmount + "</td><td>" + $("#saleDate").val() + "</td></tr>");
					}
				}
			});
		});
		
		$("#sale-register").click(() => {
			const table = $("#result tr");
			const smList = [];
			
			for (var i = 1; i < table.length; i++) {
				const obj ={};
				obj.productCode=$("#result tr").eq(i).find("td").eq(1).text();
				obj.quantity=$("#result tr").eq(i).find("td").eq(3).text();
				obj.varAmount=$("#result tr").eq(i).find("td").eq(4).text();
				obj.totalAmount=$("#result tr").eq(i).find("td").eq(5).text();
				obj.saleDate=$("#result tr").eq(i).find("td").eq(6).text();
				
				smList.push(obj);
			}
			console.log(JSON.stringify(smList));
			
			$.ajax({
				type : "post",
				url: "/saleRegister",
				dataType : "json",
				data : JSON.stringify(smList),
				processData: false,
				contentType: 'application/json; charset=UTF-8',
				success: function(response) {
					
				},
				error: function(xhr, status, error) {
				
				}
			});
		});
		
	</script>
</body>
</html>