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
	<div id="search">
		제품명 검색: <input type="text" id="productName">
		<select id="productCategory">
			<option value="all">전체</option>
			<option value="상의">상의</option>
			<option value="하의">하의</option>
			<option value="악세사리">악세사리</option>
			<option value="신발">신발</option>
		</select>
		조회 기간: <input type="month" id="month">
		<button id="btn">조회</button>
	</div>
	
	<div>	
		<table border="1" id="result">
			
		</table>
	</div>
	
	<script>
		
		$("#btn").click(() => {
			const formData = new FormData();
			formData.append("productCategory", $("#productCategory").val());
			formData.append("productName", $("#productName").val());
			//formData.append("month", $("#month").val());
			$.ajax({
				type: "post",
				url: "/showSaleManage",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					//console.log($("#month").val());
					$("#result").html("");
					$("#result").append("<tr><th>매출 번호</th><th>매출 발생일자</th><th>수량</th><th>부가세</th><th>총액</th><th>제품명</th><th>카테고리</th></tr>");
					for (const sm of result) {
						var text = "<tr><td>" + sm.smNo + "</td><td>" + sm.saleDate + "</td><td>" + sm.quantity + "</td><td>" + sm.varAmount 
							+ "</td><td>" + sm.totalAmount + "</td><td>" + sm.productName + "</td><td>" + sm.productCategory + "</td></tr>"
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