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
	<div>
		사번 : <input type="text" id="empNo">
		<button id="btn">조회</button>
	</div>
	<div>
		<table border="1" id="result"></table>
	</div>

	<script>
		// 조회 버튼 클릭 시 정보 출력
		$("#btn").click(()=>{
			const formData = new FormData();
			formData.append("empNo", $('#empNo').val());
			
			$("#result").empty();
			// 사원 정보 조회
			$.ajax({
				// 요청
				type : "post",
				url : "/leaveDays",
				data : formData, 
				processData : false,
			    contentType : false,
				// 응답
				success : function(result) {
					
					for(const leaveDays of result) {
						var text = "<b>사번</b> : " + leaveDays.empNo
							       + "</br><b>사원명</b> : " + leaveDays.empName
							       + "</br><b>부서</b> :" + leaveDays.deptName 
								   + "</br><b>직급</b> : " + leaveDays.jobTitle 
					               + "</br><b>올해 받은 휴가일수</b> : 12일";
					$("#result").append(text);
					}
					// 휴가 누적 사용일 수,  첫번째 ajax요청 다음에 실행되도록
		      $.ajax({
					// 요청
					type : "post",
					url : "/leaveTotalDays",
					data : formData, 
					processData : false,
				    contentType : false,
					// 응답
					success : function(result) {
						
						  for(const leaveTotalDays of result) {
							if(leaveTotalDays && leaveTotalDays.empNo !== null) {
							  var text = "</br><b>휴가 누적 사용일수</b> : " + leaveTotalDays.totalDays + "일"
						             + "</br><b>남은 휴가일수</b> : " + (12-leaveTotalDays.totalDays)  + "일";
					       } else {
								var text = "</br><b>휴가 누적 사용일수</b> : 0일"
							             + "</br><b>남은 휴가일수</b> : 12일";
							   
						} 
						$("#result").append(text);
					}
				},
				error:function(xhr, status, error){
						
					}
					});
				},
				error:function(xhr, status, error){
					
				}
			})
		});

			
	</script>
  </body>
  </html>