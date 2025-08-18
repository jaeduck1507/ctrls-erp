<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salary</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>
<body>
	<h5>[재무 관리] > [급여 조회]</h5>
	<h3>급여 조회</h3>
	<div id="search" class="filter-bar">
		사원 검색 : <input type="text" id="empName">
		<select id="deptName">
			<option value="dept">부서 선택</option>
			<c:forEach items="${department}" var="dept">
				<option value="${dept.deptName}">${dept.deptName}</option>
			</c:forEach>
		</select>
		<input type="month" id="yearMonth">
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
			formData.append("empName", $("#empName").val());
			formData.append("yearMonth", $("#yearMonth").val());
			
			$.ajax({
				type: "post",
				url: "/showSalary",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					//console.log($("#deptName").val());
					//console.log($("#empName").val());
					//console.log($("#yearMonth").val());
					
					if (!result.salaryList || result.salaryList.length === 0) {
						alert("조회된 결과가 없습니다");
						location.reload();
					}
					
					$("#result").html("");
					$("#result").append("<tr><th>직원 번호</th><th>부서 이름</th><th>직원 이름</th><th>지급일</th><th>기본급</th><th>보너스</th><th>공제금</th><th>급여 총액</th></tr>");
					for (const salary of result.salaryList) {
						const total = salary.baseSalary + salary.bonus - salary.deduction;
						var text = "<tr><td>" + salary.empNo + "</td><td>" + salary.deptName + "</td><td>" + salary.empName + "</td><td>" + salary.salaryDate 
							+ "</td><td>" + salary.baseSalary.toLocaleString() + "</td><td>" + salary.bonus.toLocaleString() + "</td><td>" + salary.deduction.toLocaleString() 
							+ "</td><td>" + total.toLocaleString() + "</td></tr>"
						$("#result").append(text);
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
            e.preventDefault(); // a 태그 기본 동작(페이지 이동) 차단
			
			const formData = new FormData();
            formData.append("deptName", $("#deptName").val());
			formData.append("empName", $("#empName").val());
			formData.append("yearMonth", $("#yearMonth").val());
        	formData.append("page", $(this).attr('href'));
                
        	// 링크 URL 읽기
			
        	$.ajax({
                // 요청
                type : "post",
                url : "/showSalary",
                data : formData,
				processData: false,
				contentType : false,
                // 응답
                success : function(result) {
					//테이블 생성
					$("#result").html("");
					$("#result").append("<tr><th>직원 번호</th><th>부서 이름</th><th>직원 이름</th><th>지급일</th><th>기본급</th><th>보너스</th><th>공제금</th><th>급여 총액</th></tr>");
					for (const salary of result.salaryList) {
						const total = salary.baseSalary + salary.bonus - salary.deduction;
						var text = "<tr><td>" + salary.empNo + "</td><td>" + salary.deptName + "</td><td>" + salary.empName + "</td><td>" + salary.salaryDate 
							+ "</td><td>" + salary.baseSalary.toLocaleString() + "</td><td>" + salary.bonus.toLocaleString() + "</td><td>" + salary.deduction.toLocaleString() 
							+ "</td><td>" + total.toLocaleString() + "</td></tr>"
						$("#result").append(text);
					}
					
					// 페이징 생성
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