<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>휴가 누적 사용일 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  </head>
  <body>
	<h1>휴가 누적 사용일 조회</h1>
	<p>승인된 휴가일만 누적</p>
	<div>
		사번 : <input type="text" id="empNo">
		<button id="btn">조회</button>
	</div>
	<div>
		<table border="1" id="result"></table>
	</div>

	<script>
		$("#btn").click(()=>{
			const formData = new FormData();
			formData.append("empNo", $('#empNo').val());
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
					for(const leaveDays of result) {
						var text = "사번 : " + leaveDays.empNo
							       + "</br>사원명 : " + leaveDays.empName
							       + "</br>부서 :" + leaveDays.deptName 
								   + "</br>직급 : " + leaveDays.jobTitle 
								   
					               + "</br>올해 받은 휴가일수 : " + "12일"
								   + "</br>휴가 누적 사용일수 : " + leaveDays.totalDays + "일"
								   + "</br>남은 휴가일수 : " + (12-leaveDays.totalDays)
		
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