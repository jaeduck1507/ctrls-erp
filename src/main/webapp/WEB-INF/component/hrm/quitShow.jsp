<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퇴사자정보조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>퇴사자정보조회</h1>
	<div id="search">
		이름 : <input type="text" id="quitName">
		<button id="btn">검색</button>
	</div>
	<div>
		<table border="1" id="result"></table>
	</div>
	
	<script>
		$("#btn").click(()=>{
			
			const formData = new FormData();
			formData.append("empName", $('#quitName').val());
			$.ajax({
				// 요청
				type : "post", 
				url : "/quitShow", 
				data : formData,
				processData : false,
				contentType : false,
				// 응답
				success : function(result) {
					//$("#result").text("");
					$("#result").append("<th><th>이름</th><th>퇴사일</th><th>퇴직금</th><th>퇴직금지급날짜</th></tr>");
					for(const quitter of result) {
						var text = "<tr><td>"+ quitter.empName +"</td><td>" +quitter.quitDate +"</td><td>"+quitter.quitPay+"</td><td>"+quitter.quitPayDate+"</td></tr>";
						$("#result").append(text);
					}
				},
				
				error:function(xhr, status, error){
					
				}
			})
					})
	</script>
</body>
</html>