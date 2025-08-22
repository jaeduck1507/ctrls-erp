<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PurchaseRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	td {
		position: relative;
		box-sizing: border-box;
	}

	.red {
		border-color: red;
		border-width: 2px;
	}

	table {
	  border-collapse: separate;  
	}
</style>
</head>
<body>
	<h5>[재무 관리] > [매입 일괄 등록]</h5>
	<h3>매입 일괄 등록</h3>
	<div id="brandList" class="filter-bar">
		<select id="brand">
			<option value="0" disabled selected> 선택</option>
			<c:forEach items="${brandList}" var="brand">
				<option value="${brand.brandCode}">${brand.brandName}</option>
			</c:forEach>
		</select>
		<button id="selectBrand">거래처 선택</button>
	</div>
	
	<div class="filter-bar">
		<div id="test" class="data-table">
			
		</div>
	</div>
	
	<script>
		const quantityCheck = /^[1-9]\d*$/;
		$(document).on("input", ".quantity", (e) => {
			console.log(e.target.value);
			console.log(quantityCheck.test(e.target.value));
			
			let allValid = true;
				
			const table = document.querySelectorAll(".quantity");
			    for (let i = 0; i < table.length; i++) {
			        const check = table[i];

			        if (!quantityCheck.test(check.value)) {
			            check.parentElement.classList.add("red");
			            allValid = false;
			        } else {
			            check.parentElement.classList.remove("red");
			        }
			    }
				$("#purchase-register").prop("disabled", !allValid);
			/*
			if (!quantityCheck.test(e.target.value)) {
				e.target.parentElement.classList.add("red");
				$("#purchase-register").prop("disabled", true);
			} else {
				e.target.parentElement.classList.remove("red");
				$("#purchase-register").prop("disabled", false);
			}*/
		});
		
		var count = 0;
		var totalOptionText ='';
		$("#brand").change((e) =>{
			console.log($("#brand").val());
		});
		
		$("#selectBrand").click((e) => {
			const brand = $("#brand").val();
			console.log(brand);
			
			if (brand == null) {
				alert("거래처를 선택해주세요!");
				return;
			}
			
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/showProductNameByBrandFilter",
	            dataType : "json", // dataType 지정해줘야 자바에서 인식하는 듯?
	            data : JSON.stringify({"brandCode" : brand}), // json문자열로 변환해서 전송
				processData: false,
				contentType: 'application/json; charset=UTF-8', // formData에서는 false였으나 여기서는 contentType을 지정해줘야함
	            // 응답
	            success : function(result) {
	            	$("#test").html('');
	        		$("#test").append(
	        		'<button id = "add-row" class="filter-bar">열 추가</button>' +
	        		'<table border="1" id = "result" class="filter-bar">' +
	        		'<tr><th>상품 이름</th><th>상품 코드</th><th>상품 색깔</th><th>상품 가격</th><th>상품 단가</th><th>상품 카테고리</th><th>수량</th><th>부가세</th><th>총액</th><th>매입일</th><th>삭제</th></tr>' +
	        		'</table>' +
	        		'<button id="purchase-register" class="filter-bar" disabled>매입 등록</button>'
	        		);
	        		totalOptionText ='';
					for(r of result) {
						var optionText = '<option value="'+ r.productName +'" ';
						optionText += 'data-product_code ="' + r.productCode + '" ';
						optionText += 'data-product_color ="' + r.productColor + '" ';
						optionText += 'data-product_price ="' + r.productPrice + '" ';
						optionText += 'data-product_cost ="' + r.productCost + '" ';
						optionText += 'data-product_category ="' + r.productCategory + '" ';
						optionText += 'data-brand_code ="' + r.brandCode + '" ';
						optionText += 'data-brand_name ="' + r.brandName + '" ';
						optionText += '></option>';
						totalOptionText += optionText;
					}
	        		addRow(totalOptionText);
	            },
	            
				error:function(xhr,status,error) {
					
				}
	        }); 
		});
		
		
		function addRow(totalOptionText) { // 열 추가 함수()
	        $("#result").append('<tr></tr>'); // 기본 열 추가
	        for(var i = 0; i < 10; i++) { // 열에 데이터 추가  4 : 직무, 5: 부서, 6 : 고용일 나머지 : 텍스트 데이터 
				if(i == 0) {
					
					//console.log(totalOptionText);
	        		$("#result tr").eq(-1).append('<td><input list="List'+ (++count) +'" class="productName" placeholder="검색 또는 선택" />'+
						'<datalist id="List'+ count +'">'+
						totalOptionText+
						'</datalist></td>');
	
				}
				else $("#result tr").eq(-1).append('<td></td>');
	        }
	        $("#result tr").eq(-1).append('<td><button class="remove-row">열 삭제</button></td>'); // 열 삭제 버튼 추가 (클래스 btn4)
	    }
		
		
		$(document).on("click", "#add-row", function() {
		    addRow(totalOptionText);
		});
		
		$(document).on("click", ".remove-row", function() { // 나중에 생성된 태그 경우 인식이 안되므로 $(document).on을 이용해 인식시켜야함, 클래스로 지정시 클릭한 버튼의 클래스의 이벤트를 따름
	        if($("#result tr").length > 2) $(this).parent().parent().remove(); // this : 현재 태크(button) 부모의 부모는 button -> td -> tr 즉 tr을 삭제(조건은 하나의 열은 남겨둬야되서 걸어둠)
		});
	
		
		$(document).on('change', '.productName', (e) => {
			const productInfo = {};
			const val = $(e.target).val();
			const opt = $('#result tr').eq(1).find('td').eq(0).find('datalist').find('option').filter((a, o) => o.value === val);
			
			if (!opt.length) {
				console.warn('없는 값:', val);
				alert("존재하지 않는 상품입니다!");
				return;
			}
			
			productInfo.productCode = opt.data('product_code');
			productInfo.productColor = opt.data('product_color');
			productInfo.productPrice = opt.data('product_price');
			productInfo.productCost = opt.data('product_cost');
			productInfo.productCategory = opt.data('product_category');
			
			$(e.target).parent().parent().find("td").eq(1).text(productInfo.productCode);
			$(e.target).parent().parent().find("td").eq(2).text(productInfo.productColor);
			$(e.target).parent().parent().find("td").eq(3).text(productInfo.productPrice);
			$(e.target).parent().parent().find("td").eq(4).text(productInfo.productCost);
			$(e.target).parent().parent().find("td").eq(5).text(productInfo.productCategory);
			$(e.target).parent().parent().find("td").eq(6).html('<input type="number" min="0" name="quantity" class="quantity">');
			$(e.target).parent().parent().find("td").eq(7).text("");
			$(e.target).parent().parent().find("td").eq(8).text("");
			$(e.target).parent().parent().find("td").eq(9).html('<input type="date" name="purchase-date" value="${today}" readonly="readonly">');
		});
		
		$(document).on('input', '.quantity', (e) => {
			const price = $(e.target).val();
			const amount = $(e.target).parent().parent().find("td").eq(4).text();
			const totalPrice = price * amount;
			const vat = Math.floor(totalPrice - (totalPrice / 1.1));
			
			
			$(e.target).parent().parent().find("td").eq(7).text(vat);
			$(e.target).parent().parent().find("td").eq(8).text(totalPrice);
		});
		
		$(document).on("click", "#purchase-register", function() { // 제출 버튼 동적으로 바꿔야함!
	        const table = $("#result tr"); // 테이블 정보 획득
	        const prList = []; // 객체를 담을 배열
	    	
	        for(var i = 1; i < table.length; i++){ // i가 1부터 시작하는 이유는 첫번째 열은 th(열의 설명)부분이라 데이터가 아님
	            const obj ={}; // 직원 하나당 하나의 객체로 생성
	            obj.productCode=$("#result tr").eq(i).find("td").eq(1).text(); 
	            obj.unitPrice=$("#result tr").eq(i).find("td").eq(4).text(); 
	            obj.quantity=$("#result tr").eq(i).find("td").eq(6).find("input").val(); 
	            obj.varAmount=$("#result tr").eq(i).find("td").eq(7).text(); 
	            obj.totalAmount=$("#result tr").eq(i).find("td").eq(8).text(); 
	            obj.purchaseDate=$("#result tr").eq(i).find("td").eq(9).find("input").val();  
	            obj.brandCode=$("#brand").val();
	            prList.push(obj); // 정보 저장한 객체를 배열에 삽입
	        }
	        console.log(JSON.stringify(prList));
	        
	        $.ajax({
	            // 요청
	            type : "post",
	            url : "/purchaseRegister",
	            dataType : "json", // dataType 지정해줘야 자바에서 인식하는 듯?
	            data : JSON.stringify(prList), // json문자열로 변환해서 전송
				processData: false,
				contentType: 'application/json; charset=UTF-8', // formData에서는 false였으나 여기서는 contentType을 지정해줘야함
	            // 응답
	            success : function(result) {
					if (result) {
						alert("등록되었습니다!");
						location.reload();
					}
	            },
	            
				error:function(xhr,status,error) {
					
				}
			});
		});
</script>
</body>
</html>