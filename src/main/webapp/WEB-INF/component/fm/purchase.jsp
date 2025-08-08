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
		<select id="brandName">
			<option value="all">브랜드</option>
			<option value="상의">샤넬</option>
			<option value="하의">자라</option>
			<option value="악세사리">유니클로</option>
		</select>
		<select id="productCategory">
			<option value="all">카테고리</option>
			<c:forEach items="${categoryList}" var="category">
				<option value="${category}">${category}</option>
			</c:forEach>
		</select>
		제품명 검색: <input type="text" id="productName">
		
		조회 시작일: <input type="date" id="startDate">
		조회 종료일: <input type="date" id="endDate">
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
			formData.append("startDate", $("#startDate").val());
			formData.append("endDate", $("#endDate").val());
			
			$.ajax({
				type: "post",
				url: "/showPurchase",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					//console.log($("#productName").val());
					//console.log($("#productCategory").val());
					//console.log($("#startDate").val());
					//console.log($("#endDate").val());
					$("#result").html("");
					$("#result").append("<tr><th>매입 번호</th><th>브랜드</th><th>제품명</th><th>카테고리</th><th>단가</th><th>수량</th><th>부가세</th><th>총액</th><th>매입 날짜</th></tr>");
					for (const p of result) {
						var text = "<tr><td>"  + p.purchaseNo + "</td><td>"  + p.brandName + "</td><td>"  + p.productName + "</td><td>" + p.productCategory + "</td><td>"	
							+ p.unitPrice + "</td><td>" + p.quantity + "</td><td>" + p.varAmount + "</td><td>" + p.totalAmount + "</td><td>" + p.purchaseDate + "</td></tr>"
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