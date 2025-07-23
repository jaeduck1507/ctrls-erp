<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>transaction</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>거래내역 조회</h1>
	<div id="search">
		<select id="transType">
			<option value="all">전체</option>
			<option value="수입">수입</option>
			<option value="지출">지출</option>
		</select>
		<select id="deptName">
			<option value="dept">부서 선택</option>
		</select>
		<button id="btn">조회</button>
	</div>
	
	<div>	
		<table border="1" id="result">
			
		</table>
	</div>
	
	<script>
		$(document).ready(() => {
			$.ajax({
				type : "get",
				url : "/selectDept",
				success : function(result) {
					for(const i of result) {
						var text = '<option value="'+ i.deptName +'">'+ i.deptName +'</option>';
						$("#deptName").append(text);
					}
				},
				error:function(xhr,status,error) {
							
				}
			});
		});
		
		$("#btn").click(() => {
			const formData = new FormData();
			formData.append("transType", $("#transType").val());
			formData.append("deptName", $("#deptName").val());
			$.ajax({
				type: "post",
				url: "/showtrans",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					//console.log($("#transType").val());
					//console.log($("#deptName").val());
					$("#result").html("");
					$("#result").append("<tr><th>거래 번호</th><th>수입/지출</th><th>금액</th><th>분류</th><th>수입/지출 내역 상세</th><th>수입/지출 발생 일자</th><th>부서명</th></tr>");
						for (const t of result) {
							var text = "<tr><td>" + t.transNo + "</td><td>" + t.transType + "</td><td>" + t.transAmount + "</td><td>" 
									+ t.category + "</td><td>" + t.transDesc + "</td><td>" + t.transDate + "</td><td>" + t.deptName + "</td></tr>"
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