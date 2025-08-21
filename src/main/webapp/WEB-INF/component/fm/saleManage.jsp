<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SaleManage</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<style>
	.modal-dialog {
		max-width: 800px;
	}
	.modal-body {
		min-height: 450px;
	}
</style>
</head>
<body>
	<h5>[재무 관리] > [매출 조회]</h5>
	<h3>매출 조회</h3>	
	<div id="search" class="filter-bar">
		제품명 검색: <input type="text" id="productName">
		<select id="productCategory">
			<option value="all">카테고리</option>
			<c:forEach items="${categoryList}" var="category">
				<option value="${category}">${category}</option>
			</c:forEach>
		</select>
		조회 시작일: <input type="date" id="startDate">
		조회 종료일: <input type="date" id="endDate">
		<button id="btn">조회</button>
		
		<div>
			<button type="button" data-bs-toggle="modal" data-bs-target="#monthSales">월별 매출</button>
			<button type="button" data-bs-toggle="modal" data-bs-target="#weekSales">주간 매출</button>
		</div>
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
	
	<div class="filter-bar">
		<div class="modal fade" id="monthSales" tabindex="-1" aria-labelledby="chartModal" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="chartModal">월별 매출 현황</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      	<div class="modal-body">
					<div>
					  <canvas id="monthChart"></canvas>
					</div>
				</div>
		      	<div class="modal-footer">
		       	 	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		    	</div>
		    </div>
		  </div>
		</div>
		
		<div class="modal fade" id="weekSales" tabindex="-1" aria-labelledby="chartModal" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="chartModal">주간 매출 변화</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      	<div class="modal-body">
					<div>
					  <canvas id="weekChart"></canvas>
					</div>
				</div>
		      	<div class="modal-footer">
		       	 	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		    	</div>
		    </div>
		  </div>
		</div>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
		const monthChart = document.querySelector("#monthChart");
		const weekChart = document.querySelector("#weekChart");
		
		// 월간 매출
		const monthLabels = [
			<c:forEach var="month" items="${monthSalesChart}" varStatus="loop">
		    	"${month.saleMonth}"<c:if test="${!loop.last}">,</c:if>
		    </c:forEach>
		];
		
		const monthDataValues = [
			<c:forEach var="month" items="${monthSalesChart}" varStatus="loop">
		    	"${month.monthAmount}"<c:if test="${!loop.last}">,</c:if>
		    </c:forEach>
		];
		
		// 주간 매출
		const weekLabels = [
		    <c:forEach var="week" items="${weekSalesChart}" varStatus="loop">
		    	"${week.saleDate}"<c:if test="${!loop.last}">,</c:if>
		    </c:forEach>
		];
		
		const weekDataValues = [
			<c:forEach var="week" items="${weekSalesChart}" varStatus="loop">
				${week.saleAmount}<c:if test="${!loop.last}">,</c:if>
			</c:forEach>
		];
		
		new Chart(monthChart, {
			type: 'bar',
			data: {
				labels: monthLabels,
				datasets: [{
					label: '월별 매출액',
					data: monthDataValues,
					backgroundColor: [
					'rgba(255, 99, 132, 0.2)',
					'rgba(255, 159, 64, 0.2)',
					'rgba(255, 205, 86, 0.2)',
					'rgba(75, 192, 192, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					'rgba(153, 102, 255, 0.2)',
					'rgba(255, 182, 193, 0.2)'
					],
					borderColor: [
					'rgb(255, 99, 132)',
					'rgb(255, 159, 64)',
					'rgb(255, 205, 86)',
					'rgb(75, 192, 192)',
					'rgb(54, 162, 235)',
					'rgb(153, 102, 255)',
					'rgb(255, 182, 193)'
					],
					borderWidth: 1
				}]
			},
			options: {
				scales: {
					y: {
						beginAtZero: true
					}
				}
			}
		});
		
		new Chart(weekChart, {
			type: 'line',
			data: {
				labels: weekLabels,
				datasets: [{
					label: '주간 매출액',
					data: weekDataValues,
					fill: false,
					borderColor: 'rgb(31, 216, 108)'
				}]
			},
			options: {
				scales: {
					y: {
						beginAtZero: true
					}
				}
			}
		});
		
		$("#btn").click(() => {
			const formData = new FormData();
			formData.append("productCategory", $("#productCategory").val());
			formData.append("productName", $("#productName").val());
			
			const startDate = $("#startDate").val();
			const endDate = $("#endDate").val();
			formData.append("startDate", startDate);
			formData.append("endDate", endDate);
			
			if (startDate && !endDate) {
				alert("조회 종료일을 선택해주세요!");
				return;
			} else if (!startDate && endDate) {
				alert("조회 시작일을 선택해주세요!");
				return;
			} else if (startDate > endDate) {
				alert("조회 기간을 다시 선택해주세요!");
				return;
			}
			
			$.ajax({
				type: "post",
				url: "/showSaleManage",
				data: formData,
				processData: false,
				contentType: false,
				success: function(result) {
					//console.log($("#productCategory").val());
					//console.log($("#productName").val());
					//console.log($("#startDate").val());
					//console.log($("#endDate").val());
					
					if (!result.salesList || result.salesList.length === 0) {
						alert("조회된 결과가 없습니다");
						location.reload();
					}
					
					$("#result").html("");
					$("#result").append("<tr><th>매출 번호</th><th>제품명</th><th>카테고리</th><th>가격</th><th>수량</th><th>부가세</th><th>총액</th><th>매출 발생일자</th></tr>");
					for (const sales of result.salesList) {
						var text = "<tr><td>" + sales.smNo + "</td><td>" + sales.productName + "</td><td>" + sales.productCategory + "</td><td>" + sales.productPrice.toLocaleString() + "</td><td>" 
							+ sales.quantity + "</td><td>" + sales.varAmount.toLocaleString() + "</td><td>" + sales.totalAmount.toLocaleString() + "</td><td>" + sales.saleDate + "</td></tr>"
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
			e.preventDefault();
			
			const formData = new FormData();
			formData.append("productCategory", $("#productCategory").val());
			formData.append("productName", $("#productName").val());
			formData.append("startDate", $("#startDate").val());
			formData.append("endDate", $("#endDate").val());
			formData.append("page", $(this).attr('href'));
			
			$.ajax({
				type: "post",
				url: "/showSaleManage",
				data: formData,
				processData: false,
				contentType: false,
				success: function(result) {
					$("#result").html("");
					$("#result").append("<tr><th>매출 번호</th><th>제품명</th><th>카테고리</th><th>가격</th><th>수량</th><th>부가세</th><th>총액</th><th>매출 발생일자</th></tr>");
					for (const sales of result.salesList) {
						var text = "<tr><td>" + sales.smNo + "</td><td>" + sales.productName + "</td><td>" + sales.productCategory + "</td><td>" + sales.productPrice.toLocaleString() + "</td><td>" 
							+ sales.quantity + "</td><td>" + sales.varAmount.toLocaleString() + "</td><td>" + sales.totalAmount.toLocaleString() + "</td><td>" + sales.saleDate + "</td></tr>"
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
	</script>
</body>
</html>