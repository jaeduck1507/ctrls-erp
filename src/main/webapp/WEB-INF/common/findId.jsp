<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h2>아이디 찾기</h2>
	
	<div id="find">
		사번 <input type="text" id="empNo">
		<button id="btn">조회</button>
	</div>
	<div>
		<table id="result"></table>
	</div>
	<script>
		$("#btn").click(()=>{
			const formData = new FormData();
						formData.append("empNo", $('#empNo').val());
						$("#result").empty();
						$.ajax({
							type: "post",
							url: "/findId",
							data: formData,
							processData : false,
							contentType : false,
							success : function(result) {
								
								if(result == '') {
									$("#result").append("아이디가 존재하지 않습니다.");
								} else{
									$("#result").append("아이디는 " + result + "입니다.");
								}
							},
							error:function(xhr,status,error) {
									   }
						});
		});
	</script>
</body>
</html>
