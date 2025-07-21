<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제품조회</title>
<!--    <link rel="stylesheet" href="<c:url value='/resources/css/product.css' />">-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>제품 목록</h2>

<table border="1" id="result">
</table>

<script>
    $(document).ready(function () {
        $.ajax({
			type: "get",
            url: "/showProduct",
			success: function (result) {
			    $("#result").html("");
				$("#result").append("<tr><th>제품 번호</th><th>생산일</th><th>제품 코드</th></tr>");

				for(const p of result)	{
					var text = "<tr><td>"+ p.productNo +"</td><td>"+p.productionDate+"</td><td>"+p.productCode+"</td></tr>"
					$("#result").append(text);
				}
			},
            error: function(xhr,status,error) {
            }
        });
    });
</script>

</body>
</html>

