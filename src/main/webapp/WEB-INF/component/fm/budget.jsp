<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budget</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>
<body>
	<h5>[재무 관리] > [예산 조회]</h5>
	<h3>예산 조회</h3>
	<div id="search" class="filter-bar">
		<select id="deptName">
			<option value="dept">부서 선택</option>
			<c:forEach items="${department}" var="dept">
				<option value="${dept.deptName}">${dept.deptName}</option>
			</c:forEach>
		</select>
		<input type="month" id="yearMonth"/>
		<button id="btn">조회</button>
	</div>
	
	<div>	
		<table border="1" id="result" class="data-table">
				
		</table>
	</div>
	
	<div>
		<nav>
			<ul class="pagination">
				
			</ul>
		</nav>
	</div>
	
	<script>
		$("#btn").click(() => {
			const formData = new FormData();
			formData.append("deptName", $("#deptName").val());
			formData.append("yearMonth", $("#yearMonth").val());
			
			$.ajax({
				type: "post",
				url: "/showBudget",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					//console.log($("#deptName").val());
					//console.log($("#yearMonth").val());
					
					if (!result.budgetList || result.budgetList.length === 0) {
						alert("조회된 결과가 없습니다");
						location.reload();
					}
					
					$("#result").html("");
					$("#result").append("<tr><th>예산 코드</th><th>부서</th><th>예산 금액</th><th>계획</th><th>예산 집행일</th><th>수정</th><th>삭제</th></tr>");
					for (const budget of result.budgetList) {
						var text = "<tr><td>" + budget.periodValue + "</td><td>" + budget.deptName + "</td><td>" 
							+ budget.annualBudget.toLocaleString() + "</td><td>" + budget.plan + "</td><td>" + budget.executionDate + "</td></tr>"
						$("#result").append(text);
						$("#result tr").eq(-1).append('<td><a href="/fm/budgetUpdate?budgetNo=' + budget.budgetNo + '">수정</a></td>');
						$("#result tr").eq(-1).append('<td><a href="/fm/budgetDelete?budgetNo=' + budget.budgetNo + '">삭제</a></td>');
					}
					
					$(".pagination").html('');
                	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
                	for (var i = result.startPage; i <= result.endPage; i++) {
                		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
                	}
                	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
				},
				error: function(xhr, status, error) {
					
				}
			});
		});
		
		$(document).on('click', 'a.page-link', function(e) {
			e.preventDefault();
			
			const formData = new FormData();
			formData.append("deptName", $("#deptName").val());
			formData.append("page", $(this).attr('href'));
			
			$.ajax({
				type: "post",
				url: "/showBudget",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					$("#result").html("");
					$("#result").append("<tr><th>예산 코드</th><th>부서</th><th>예산 금액</th><th>계획</th><th>예산 집행일</th><th>수정</th></tr>");
					for (const budget of result.budgetList) {
						var text = "<tr><td>" + budget.periodValue + "</td><td>" + budget.deptName + "</td><td>" 
							+ budget.annualBudget.toLocaleString() + "</td><td>" + budget.plan + "</td><td>" + budget.executionDate + "</td></tr>"
						$("#result").append(text);
						$("#result tr").eq(-1).append('<td><a href="/fm/budgetUpdate?budgetNo=' + budget.budgetNo + '">수정</a></td>');
						$("#result tr").eq(-1).append('<td><a href="/fm/budgetDelete?budgetNo=' + budget.budgetNo + '">삭제</a></td>');
					}
					
					$(".pagination").html('');
                	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
                	for (var i = result.startPage; i <= result.endPage; i++) {
                		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
                	}
                	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
				},
				error: function(xhr, status, error) {
					
				}
			});
		});
	</script>
</body>
</html>