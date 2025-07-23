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
	
	
	<div id = "test">
        <button id = "btn2">열 추가</button>
        <table border="1" id = "result">
            <tr>
                <th>상품 이름</th>
                <th>상품 코드</th>
                <th>상품 색깔</th>
                <th>상품 가격</th>
                <th>상품 단가</th>
                <th>상품 카테고리</th>
                <th>수량</th>
                <th>부가세</th>
                <th>총액</th>
                <th>매입일</th>
            </tr>
           	<tr>
                <td>
                <input list="List" id="productName" class="a" placeholder="검색 또는 선택" />
				<datalist id="List">
					<c:forEach items="${productNameList}" var="product">
					    <option value="${product.productName}" data-product_code ="${product.productCode}" 
					    data-product_color="${product.productColor}" data-product_price="${product.productPrice}"
					    data-product_cost="${product.productCost}" data-product_category="${product.productCategory}" ></option>
					</c:forEach>
				</datalist>
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>
				</td>
                <td> 부가세 </td>
                <td>총액</td>
                <td>매입일</td>
            </tr>
            
            
        </table>
        <button id = "btn">사원 등록</button>
        
    </div>
	
	<script>
	
	$('.a').change( (e) => {
		const productInfo = {};
		const val = $(e.target).val();
		const opt = $('#List option').filter((a, o) => o.value === val);
		
		if (!opt.length) {
		  console.warn('없는 값:', val);
		  return;
		}
		
		
		
		productInfo.productCode = opt.data('product_code');
		productInfo.productColor = opt.data('product_color');
		productInfo.productPrice = opt.data('product_price');
		productInfo.productCost = opt.data('product_cost');
		productInfo.productCategory = opt.data('product_category');
		
		console.log(productInfo.productCode);
		$(e.target).parent().parent().find("td").eq(1).text(productInfo.productCode);
		$(e.target).parent().parent().find("td").eq(2).text(productInfo.productColor);
		$(e.target).parent().parent().find("td").eq(3).text(productInfo.productPrice);
		$(e.target).parent().parent().find("td").eq(4).text(productInfo.productCost);
		$(e.target).parent().parent().find("td").eq(5).text(productInfo.productCategory);
		$(e.target).parent().parent().find("td").eq(6).append('<input type="number" name="quantity">');
		});

</script>
</body>
</html>