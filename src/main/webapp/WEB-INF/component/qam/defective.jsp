<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>불량품 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>불량품 조회</h2>

<table border="1" id="defectiveResult">
    <tr>
        <th>불량번호</th>
        <th>제품번호</th>
        <th>불량사유</th>
		<th>수정</th>
	</tr>
</table>
		
<script>
	function displayDefective(data) {
		let tableHead = "<tr><th>불량번호</th><th>제품번호</th><th>불량사유</th><th>수정</th></tr>"
		$("#defectiveResult").html(tableHead);
		
		for (let d of data) {
				let row = "<tr>";
				row += "<td>" + d.defectiveNo + "</td>";
				row += "<td>" + d.productNo + "</td>";
				row += "<td>" + d.reason + "</td>";
				row += "<td><a href='/qam/defectiveUpdate?defectiveNo=" + d.defectiveNo + "'>수정</a></td>";
				row += "</tr>"
				$("#defectiveResult").append(row);
				}
			}
	$(document).ready(function() {
		$.ajax({
				type: "get",
				url: "/qam/showDefective",
				success: function (result) {
					displayDefective(result);
				}
			});
		});
	
</script>

</body>
</html>
