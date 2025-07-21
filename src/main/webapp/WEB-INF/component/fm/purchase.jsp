<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Purchase</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>매입 내역 조회</h1>
	<div>
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
				url: "/showPurchase",
				success: function(result) {
					$("#result").append("<tr><th>매입 번호</th><th>단가</th><th>수량</th><th>부가세</th><th>총액</th><th>매입 날짜</th><th>상품 번호</th></tr>");
					for (const p of result) {
						var text = "<tr><td>"  + p.purchaseNo + "</td><td>" + p.unitPrice + "</td><td>" + p.quantity + "</td><td>" 
							+ p.varAmount + "</td><td>" + p.totalAmount + "</td><td>" + p.purchaseDate + "</td><td>" + p.productNo + "</td>"
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