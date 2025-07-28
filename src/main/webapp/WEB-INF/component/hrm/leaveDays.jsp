<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>휴가 누적 사용일, 잔여일 수 조회</title>

  </head>
  <body>
	<h1>휴가 누적 사용일, 잔여일 수 조회</h1>
	<div>
		사번 : <input type="text" id="search">
		<button id="btn">조회</button>
	</div>
	<div>
		<table border="1" id="result"></table>
	</div>

	<script>
		$("#btn").click(()=>{
			const formData = new FormData();
			formData.append("empNo", $('#search').val());
			$.ajax({
				// 요청
				type : "post",
				url : "/leaveDays",
				data : formData, 
				processData : false,
			    contentType : false,
				// 응답
				success : function(result) {
					$("#result").empty();
					$("#result").append("<tr><th>사번</th><th>사원명</th><th>부서</th><th>직급</th><th>휴가누적사용일수</th><th>잔여일수</th></tr>");
					for(const leaveDays of result) {
						var text = "<tr><td>" + leaveDays.empNo
							       + "</td><td>" + leaveDays.empName
							       + "</td><td>" + leaveDays.deptName 
								   + "</td><td>" + leaveDays.jobTitle 
								   + "</td><td>" + leaveDays.totalDays 
								   + "</td><td>" + leaveDays.remainDays
									+ "</td></tr>"
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