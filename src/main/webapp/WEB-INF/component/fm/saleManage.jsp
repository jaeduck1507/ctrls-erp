<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SaleManage</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
		<select id="productCategory">
			<option value="all">카테고리</option>
			<c:forEach items="${categoryList}" var="category">
				<option value="${category}">${category}</option>
			</c:forEach>
		</select>
		<input type="text" id="productName" placeholder="상품 검색">
		조회 시작일: <input type="date" id="startDate">
		조회 종료일: <input type="date" id="endDate">
		<button id="btn">조회</button>
		
		<div>
			<button type="button" data-bs-toggle="modal" data-bs-target="#monthSales">월별 매출</button>
			<button type="button" data-bs-toggle="modal" data-bs-target="#weekSales">주간 매출</button>
			<button type="button" data-bs-toggle="modal" data-bs-target="#salesQuantity">제품별 판매 현황</button>
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
		
		<div class="modal fade" id="salesQuantity" tabindex="-1" aria-labelledby="chartModal" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="chartModal">월별 제품 판매 현황</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      	<div class="modal-body">
					<select id="saleCategory">
						<option value="all">전체</option>
						<c:forEach items="${categoryList}" var="category">
							<option value="${category}">${category}</option>
						</c:forEach>
					</select>
					<input type="month" id="yearMonth">
					<button type="button" id="search">조회</button>
					<div>
						<canvas id="doughnutChart" style="width: 100%; height: 380px;"></canvas>
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
		const monthSalesChart = [
			<c:forEach var="month" items="${monthSalesChart}" varStatus="loop">
				{
					saleMonth: "${month.saleMonth}",
					monthAmount: ${month.monthAmount}
				}<c:if test="${!loop.last}">,</c:if>
			</c:forEach>
		];
		
		const weekSalesChart = [
			<c:forEach var="week" items="${weekSalesChart}" varStatus="loop">
				{
					saleDate: "${week.saleDate}",
					saleAmount: ${week.saleAmount}
				}<c:if test="${!loop.last}">,</c:if>
			</c:forEach>
		];
	</script>
	<script src="../resources/js/fm/saleManage.js"></script>
</body>
</html>