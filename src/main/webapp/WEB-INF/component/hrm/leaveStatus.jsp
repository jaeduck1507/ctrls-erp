<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 상태 처리</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>휴가 상태 처리</h1>
	
	<div>
		<table border="1" id="result">
				<tr>
					
				<th>신청번호</th>
				<th>신청날짜</th>
				<th>유형</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>이유</th>
				<th>사번</th>
				<th>신청자</th>
				<th>부서</th>
				<th>직급</th>
				<th>상태</th>
				<th>승인/반려</th>
				</tr>
					
				<c:forEach items="${leaveInfoList}" var="item">
				<tr>
				    <td>${item.leaveId}</td>
					<td>${item.requestDate}</td>
					<td>${item.leaveType}</td>
					<td>${item.startDate}</td>
					<td>${item.endDate}</td>
					<td>${item.reason}</td>
					<td>${item.empNo}</td>
					<td>${item.empName}</td>
					<td>${item.deptName}</td>
					<td>${item.jobTitle}</td>
					<td>${item.status}</td>
					
					<td>
						<button class="btnO">승인</button>
						<button class="btnX">반려</button>
					</td>
				</tr>
				</c:forEach>
		</table>
		
	</div>
	
	<script>
		$(".btnO").click((e)=>{
					const formData = new FormData();
					formData.append("status", "승인");
					formData.append("leaveId", $(e.target).parent().parent().find("td").eq(0).text());
					//location.reload(); // 승인 버튼 누르면 자동 새로고침
					$.ajax({
						// 요청
						type : "post",
						url : "/leaveStatusUpdate",
						data : formData, 
						processData : false,
					    contentType : false,
						// 응답
						success : function(result) {
							
							
						},
						error:function(xhr, status, error){
							
						}
					});
					//console.log("gdg");
					setTimeout(() => {
					    location.reload();
					},2);
					
				});
				$(".btnX").click((e)=>{
									const formData = new FormData();
									formData.append("status", "반려");
									formData.append("leaveId", $(e.target).parent().parent().find("td").eq(0).text());
									//location.reload(); // 반려 버튼 누르면 자동 새로고침
									$.ajax({
										// 요청
										type : "post",
										url : "/leaveStatusUpdate",
										data : formData, 
										processData : false,
									    contentType : false,
										// 응답
										success : function(result) {
											
											
										},
										error:function(xhr, status, error){
											
										}
									});
									setTimeout(() => {
										location.reload();
									},2);
								});
	</script>
</body>
</html>