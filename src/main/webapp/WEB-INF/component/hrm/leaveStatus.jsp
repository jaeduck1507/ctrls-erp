<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 상태 처리</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>
<body>
	<h5>[근태 관리] > [휴가 상태 처리]</h5>
	<h3>휴가 상태 처리</h3>
		<table border="1" id="result" class="data-table">
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
				<th>승인</th>
				<th>반려</th>
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
					</td>
					<td>
						<button class="btnX">반려</button>
					</td>
				</tr>
				</c:forEach>
		</table>

		<nav>
		<ul class="pagination">
				<li class="page-item ${paging.prev ? '' : 'disabled'}">
					<a class="page-link" href="/hrm/leaveStatus?page=${paging.startPage - 1}">Previous</a>
				</li>
										
			<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
				<li class="page-item">
					<a class="page-link ${paging.page == page ? 'active' : ''}" href="/hrm/leaveStatus?page=${page}">${page}</a>
				</li>
			</c:forEach>
				<li class="page-item ${paging.next ? '' : 'disabled'}">
					<a class="page-link" href="/hrm/leaveStatus?page=${paging.endPage + 1}">Next</a>
				</li>
		</ul>
		</nav>
	
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
							location.reload();
							
						},
						error:function(xhr, status, error){
							
						}
					});
					
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
											location.reload();
											
										},
										error:function(xhr, status, error){
											
										}
									});
									
								});
		
	</script>
</body>
</html>