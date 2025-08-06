<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>totalSalary</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>부서별 월 급여</h1>
	<div id="total">
		<input type="month" id="yearMonth"/>
		<button id="search">조회</button>
		<button id="register">등록</button>
		
		<table border="1" id="result">
			
		</table>
	</div>
	
	<script>
		$("#search").click(() => {
			const formData = new FormData();
			formData.append("yearMonth", $("#yearMonth").val());
			console.log($("#yearMonth").val());
			
			if (!$("#yearMonth").val()) {
				alert("조회할 월을 선택해주세요");
				return;
			}
			
			$.ajax({
				type: "post",
				url: "/totalSalary",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					$("#result").html("");
					$("#result").append("<tr><th>부서명</th><th>부서 코드</th><th>급여 이체일</th><th>총액</th></tr>");
					for (const sal of result) {
						//const totalSal = sal.baseSalary + sal.bonus - sal.deduction;
						var text = "<tr><td>" + sal.deptName + "</td><td>" + sal.deptNo + "</td><td>" + sal.salaryDate + "</td><td>" + sal.totalSal + "</td></tr>"
						$("#result").append(text);
					}
				},
				error: function(xhr, status, error) {
					
				}
			});
		});
		
		$("#register").click(() => {
			const table = $("#result tr");
			const salList = [];
			
			for (var i = 1; i < table.length; i++) {
				const obj ={};
				obj.deptNo=$("#result tr").eq(i).find("td").eq(1).text();
				obj.transDate=$("#result tr").eq(i).find("td").eq(2).text();
				obj.transAmount=$("#result tr").eq(i).find("td").eq(3).text();
				obj.transType="지출";
				obj.category="인건비";
				obj.transDesc=$("#result tr").eq(i).find("td").eq(0).text() + " " + obj.transDate.substring(6, 7) + "월 급여";
				
				salList.push(obj);
			}
			console.log(JSON.stringify(salList));
			/*
			$.ajax({
				type : "post",
				url: "/transRegister",
				dataType : "json",
				data : JSON.stringify(salList),
				processData: false,
				contentType: 'application/json; charset=UTF-8',
				success: function(response) {
					
				},
				error: function(xhr, status, error) {
					
				}
			});
			alert("등록되었습니다");
			location.reload();*/
		});
	</script>
</body>
</html>