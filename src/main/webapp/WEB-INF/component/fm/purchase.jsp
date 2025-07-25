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
		제품명 검색: <input type="text" id="productName">
		<select id="productCategory">
			<option value="all">전체</option>
			<option value="상의">상의</option>
			<option value="하의">하의</option>
			<option value="악세사리">악세사리</option>
			<option value="신발">신발</option>
		</select>
		<button id="btn">조회</button>
	</div>
	
	<div>	
		<table border="1" id="result">
			
		</table>
	</div>
	
	<script>
		$("#btn").click(() => {
			const formData = new FormData();
			formData.append("productName", $("#productName").val());
			formData.append("productCategory", $("#productCategory").val());
			$.ajax({
				type: "post",
				url: "/showPurchase",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					//console.log($("#productName").val());
					//console.log($("#productCategory").val());
					$("#result").html("");
					$("#result").append("<tr><th>매입 번호</th><th>제품명</th><th>카테고리</th><th>단가</th><th>수량</th><th>부가세</th><th>총액</th><th>매입 날짜</th></tr>");
					for (const p of result) {
						var text = "<tr><td>"  + p.purchaseNo + "</td><td>"  + p.productName + "</td><td>" + p.productCategory + "</td><td>" + p.unitPrice 
							+ "</td><td>" + p.quantity + "</td><td>" + p.varAmount + "</td><td>" + p.totalAmount + "</td><td>" + p.purchaseDate + "</td></tr>"
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