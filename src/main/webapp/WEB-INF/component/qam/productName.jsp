<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 정보 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>

<h1>제품 정보 조회</h1>

<a href="/productNameForm">
    <button>제품 신규 등록</button>
</a>

<!-- 검색창 -->
<form id="searchForm">
    제품명 : <input type="text" name="productName" id="productName">
    <select name="productCategory" id="productCategory">
        <option value="">카테고리 선택</option>
        <option value="상의">상의</option>
        <option value="하의">하의</option>
        <option value="악세사리">악세사리</option>
        <option value="신발">신발</option>
    </select>
    <button type="submit">검색</button>
</form>

<table border="1" id="result">
</table>

<script>
    $(document).ready(function() {
		
		$("#searchForm").submit(function (e) {
		    e.preventDefault();
		    //const name = $("#productName").val();
		    //const category = $("#productCategory").val();

		    $.ajax({
		        type: "get",
		        url: "/searchProductName",
				data: {
				    productName: $("#productName").val(),
				    productCategory: $("#productCategory").val()
		        },
		        success: function (result) {
		            $("#result").html("");
		            $("#result").append("<tr><th>제품 코드</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>카테고리</th><th>수정</th><th>삭제</th></tr>");
		            for (const pn of result) {
		                let row = "<tr><td>" + pn.productCode + "</td><td>" + pn.productColor + "</td><td>" + pn.productName + "</td><td>" + pn.productPrice + "</td><td>" + pn.productCost + "</td><td>" + pn.productCategory + "</td>";
		                row += "<td><a href='/productNameForm?productCode=" + pn.productCode + "'>수정</a></td>";
		                row += "<td><a href='/deleteProductName?productCode=" + pn.productCode + "'>삭제</a></td></tr>";
		                $("#result").append(row);
		            }
		        }
		    });
		});
		
        $.ajax({
            type: "get", 
            url: "/showProductName", 
            success: function(result) {
                $("#result").html(""); 
                $("#result").append("<tr><th>제품 코드</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>카테고리</th><th>수정</th><th>삭제</th></tr>");
				
                for (const pn of result) {
                    var text = "<tr>";
                    text += "<td>" + pn.productCode + "</td>";
                    text += "<td>" + pn.productColor + "</td>";
                    text += "<td>" + pn.productName + "</td>";
                    text += "<td>" + pn.productPrice + "</td>";
                    text += "<td>" + pn.productCost + "</td>";
                    text += "<td>" + pn.productCategory + "</td>";
                    text += "<td><a href='/productNameForm?productCode=" + pn.productCode + "'>수정</a></td>";
                    text += "<td><a href='/deleteProductName?productCode=" + pn.productCode + "'>삭제</a></td>";
					text += "</tr>";
                    $("#result").append(text);
                }
            },
            error: function(xhr, status, error) {
                alert("데이터 로딩 실패: " + error);
            }
        });
    });
</script>


</body>
</html>
