<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SaleManage</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>매출 조회</h1>
	<div>
		상품 검색: <input type="text" id="keyword">
		<select id="category">
			<option value="" disabled selected>선택</option>
			<option value="top">상의</option>
			<option value="bottom">하의</option>
			<option value="accessory">악세사리</option>
			<option value="shoes">신발</option>
		</select>
		조회 기간: <input type="month" id="saleDate">
		<button id="btn">조회</button>
	</div>
	
	<div>	
		<table border="1" id="result">
			
		</table>
	</div>
	
	<script>
		
		$("#btn").click(() => {
			$.ajax({
				type: "get",
				url: "/showSaleManage",
				success: function(result) {
					$("#result").append("<tr><th>매출 번호</th><th>매출 발생일자</th><th>수량</th><th>부가세</th><th>총액</th><th>상품 번호</th></tr>");
					for (const sm of result) {
						var text = "<tr><td>" + sm.smNo + "</td><td>" + sm.saleDate + "</td><td>" + sm.quantity + "</td><td>"
							 + sm.varAmount + "</td><td>" + sm.totalAmount + "</td><td>" + sm.productCode + "</td></tr>"
						$("#result").append(text);
					}
				},
				error: function(xhr, status, error) {
					
				}
				
			});
		});
	</script>
</body>
</html>