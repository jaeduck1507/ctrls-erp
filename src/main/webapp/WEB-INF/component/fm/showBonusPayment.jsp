<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보너스 수당 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>
<body>
	<h5>[재무 관리] > [수당 조회]</h5>
	<div class="container">
		
		<h3>수당 조회</h3>
		<div id = "search" class="filter-bar">
		이름 : <input type="text" id="empName">
			<select id="deptName">
				<option value="-1">부서 선택</option>
				<c:forEach items="${department}" var="emp">
					<option value="${emp.deptNo}">${emp.deptName}</option>
				</c:forEach>
			</select>
			<select id="jobTitle">
				<option value="-1">직무 선택</option>
				<c:forEach items="${jobPosition}" var="emp">
					<option value="${emp.jobNo}">${emp.jobTitle}</option>
				</c:forEach>
			</select>
			조회 월 선택 : <input type="month" id="date">
			<button id = "btn">검색</button>
		</div>
		
		<div>
			<table border="1" id = "result" class="data-table">
			</table>
		</div>
	
		<div>
			<nav>
				<ul class="pagination">
				</ul>
			</nav>
		</div>
	</div>
	
	<script>
		$("#btn").click(() =>{
			const formData = new FormData();
			formData.append("empName", $("#empName").val());
			formData.append("deptNo", $("#deptName").val());
			formData.append("jobNo", $("#jobTitle").val());
			formData.append("date", $("#date").val());
			
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/showBonusPayment",
                data : formData,
				processData: false,
				contentType: false,
				
	            // 응답
	            success : function(result) {
					if (!result.bonusPaymentList || result.bonusPaymentList.length === 0) {
						alert("조회된 결과가 없습니다");
						location.reload();
					}
					
					$("#result").html("");
	            	$("#result").append("<tr><th>이름</th><th>부서</th><th>직급</th><th>수당 금액</th><th>수당 종류</th><th>지급 날짜</th></tr>");
                	for(const bonus of result.bonusPaymentList) {
					var text = "<tr><td>"+ bonus.empName +"</td><td>"+bonus.deptName+"</td><td>"+bonus.jobTitle+"</td><td>"+bonus.payment+"</td><td>"+bonus.bonusName+"</td><td>"+bonus.payDate+"</td></tr>"
						$("#result").append(text);
                	}
					
					$(".pagination").html('');
                	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
                	for (var i = result.startPage; i <= result.endPage; i++) {
                		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
                	}
                	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>'); 
	            },
				error:function(xhr,status,error) {
					
				}
	        });
	    });
		
		$(document).on('click', 'a.page-link', function(e) {
			e.preventDefault();
			
			const formData = new FormData();
			formData.append("empName", $("#empName").val());
			formData.append("deptNo", $("#deptName").val());
			formData.append("jobNo", $("#jobTitle").val());
			formData.append("date", $("#date").val());
			formData.append("page", $(this).attr('href'));
						
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/showBonusPayment",
                data : formData,
				processData: false,
				contentType: false,
				
	            // 응답
	            success : function(result) {
					$("#result").html("");
	            	$("#result").append("<tr><th>이름</th><th>부서</th><th>직급</th><th>수당 금액</th><th>수당 종류</th><th>지급 날짜</th></tr>");
                	for(const bonus of result.bonusPaymentList) {
					var text = "<tr><td>"+ bonus.empName +"</td><td>"+bonus.deptName+"</td><td>"+bonus.jobTitle+"</td><td>"+bonus.payment+"</td><td>"+bonus.bonusName+"</td><td>"+bonus.payDate+"</td></tr>"
						$("#result").append(text);
                	}
					
					$(".pagination").html('');
                	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
                	for (var i = result.startPage; i <= result.endPage; i++) {
                		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
                	}
                	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>'); 
	            },
				error:function(xhr,status,error) {
					
				}
	        });
		});
	</script>
</body>
</html>