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
		<button id="add-row">열 추가</button>
		<table border="1" id="result">
			<tr>
				<th>상품명</th>
				<th>상품 코드</th>
				<th>가격</th>
				<th>수량</th>
				<th>부가세</th>
				<th>총액</th>
				<th>매출 발생일자</th>
				<th>삭제</th>
			</tr>
		</table>
		<button id="sale-register">매출 등록</button>
	</div>
	
	<script>
		var count = 0;
		
		function addRow() {
			$("#result").append("<tr></tr>");
			for (var i = 0; i < 7; i++) {
				if (i == 0) $("#result tr").eq(-1).append('<td><input list="productList'+ (++count) +'" class="productName" placeholder="검색 또는 선택" /><datalist id="productList'+ count +'"><c:forEach items="${productNameList}" var="product"><option value="${product.productName}" data-product_code ="${product.productCode}" data-product_price="${product.productPrice}" ></option></c:forEach></datalist></td>');
				else $("#result tr").eq(-1).append('<td></td>');
			}
			$("#result tr").eq(-1).append('<td><button class="remove-row">열 삭제</button></td>');
		}
		
		addRow();
		
		$("#add-row").click(() => {
			addRow();
		});
		
		$(document).on("click", ".remove-row", function() {
			if($("#result tr").length > 2) $(this).parent().parent().remove();
		});
		
		$(document).on("change", ".productName", (e) => {
			const productInfo = {};
			const val = $(e.target).val();
			console.log(val);
			const opt = $('#result tr').eq(1).find('td').eq(0).find('datalist').find('option').filter((a, o) => o.value === val);
			
			if (!opt.length) {
				alert("존재하지 않는 상품입니다");
				return;
			}
			
			productInfo.productCode = opt.data("product_code");
			productInfo.productPrice = opt.data("product_price");
			$(e.target).parent().parent().find("td").eq(1).text(productInfo.productCode);
			$(e.target).parent().parent().find("td").eq(2).text(productInfo.productPrice);
			$(e.target).parent().parent().find("td").eq(3).html('<input type="number" name="quantity" class="quantity"/>');
			$(e.target).parent().parent().find("td").eq(4).text("");
			$(e.target).parent().parent().find("td").eq(5).text("");
			$(e.target).parent().parent().find("td").eq(6).html('<input type="date" name="sale-date"/>');
		});
		
		$(document).on("change", ".quantity", (e) => {
			const quantity = $(e.target).val();
			const amount = $(e.target).parent().parent().find("td").eq(2).text();
			const total = quantity * amount;
			const vat = Math.floor(total - (total / 1.1));
			
			$(e.target).parent().parent().find("td").eq(4).text(vat);
			$(e.target).parent().parent().find("td").eq(5).text(total);
		});
		
		$("#sale-register").click(() => {
			const table = $("#result tr");
			const smList = [];
			
			for (var i = 1; i < table.length; i++) {
				const obj ={};
				obj.productCode=$("#result tr").eq(i).find("td").eq(1).text();
				obj.quantity=$("#result tr").eq(i).find("td").eq(3).find("input").val();
				obj.varAmount=$("#result tr").eq(i).find("td").eq(4).text();
				obj.totalAmount=$("#result tr").eq(i).find("td").eq(5).text();
				obj.saleDate=$("#result tr").eq(i).find("td").eq(6).find("input").val();
				
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