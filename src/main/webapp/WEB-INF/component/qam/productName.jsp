<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품정보조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<body>

<h1>제품 정보 조회</h1>

<table border="1" id="result">
</table>

<script>
    $(document).ready(function() {
        $.ajax({
            type: "get", 
            url: "/showProductName", 
            success: function(result) {
                $("#result").html(""); 
                $("#result").append("<tr><th>제품 코드</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>카테고리</th></tr>");
				
                for (const pn of result) {
                    var text = "<tr><td>"+ pn.productCode +"</td><td>"+ pn.productColor +"</td><td>"+pn.productName + "</td><td>" + pn.productPrice + "</td><td>" + pn.productCost + "</td><td>" + pn.productCategory + "</td></tr>"
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
