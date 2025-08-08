<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>transaction</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
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
			<c:forEach items="${department}" var="dept">
				<option value="${dept.deptName}">${dept.deptName}</option>
			</c:forEach>
		</select>
		조회 시작일: <input type="date" id="startDate">
		조회 종료일: <input type="date" id="endDate">
		<button id="btn">조회</button>
	</div>
	
	<div>	
		<table border="1" id="result">
			
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
			formData.append("transType", $("#transType").val());
			formData.append("deptName", $("#deptName").val());
			formData.append("startDate", $("#startDate").val());
			formData.append("endDate", $("#endDate").val());
			
			$.ajax({
				type: "post",
				url: "/showtrans",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					//console.log($("#transType").val());
					//console.log($("#deptName").val());
					//console.log($("#startDate").val());
					//console.log($("#endDate").val());
					$("#result").html("");
					$("#result").append("<tr><th>거래 번호</th><th>부서명</th><th>수입/지출</th><th>금액</th><th>분류</th><th>상세 내역</th><th>발생 일자</th></tr>");
						for (const trans of result.transList) {
							var text = "<tr><td>" + trans.transNo + "</td><td>" + trans.deptName + "</td><td>" + trans.transType + "</td><td>" + trans.transAmount 
								+ "</td><td>" + trans.category + "</td><td>" + trans.transDesc + "</td><td>" + trans.transDate + "</td></tr>"
						$("#result").append(text);
					}
					
					$(".pagination").html('');
                	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
                	for(var i =result.startPage; i<=result.endPage; i++) {
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
			formData.append("transType", $("#transType").val());
			formData.append("deptName", $("#deptName").val());
			formData.append("startDate", $("#startDate").val());
			formData.append("endDate", $("#endDate").val());
			formData.append("page",$(this).attr('href'));
			
			$.ajax({
				type: "post",
				url: "/showtrans",
				data: formData,
				processData: false,
				contentType : false,
				success: function(result) {
					$("#result").html("");
					$("#result").append("<tr><th>거래 번호</th><th>부서명</th><th>수입/지출</th><th>금액</th><th>분류</th><th>상세 내역</th><th>발생 일자</th></tr>");
						for (const trans of result.transList) {
							var text = "<tr><td>" + trans.transNo + "</td><td>" + trans.deptName + "</td><td>" + trans.transType + "</td><td>" + trans.transAmount 
								+ "</td><td>" + trans.category + "</td><td>" + trans.transDesc + "</td><td>" + trans.transDate + "</td></tr>"
						$("#result").append(text);
					}
					
					$(".pagination").html('');
                	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
                	for(var i =result.startPage; i<=result.endPage; i++) {
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