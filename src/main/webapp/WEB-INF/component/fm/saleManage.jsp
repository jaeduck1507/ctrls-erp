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
		        <h1 class="modal-title fs-5" id="chartModal"><span id="currentMonth"></span> 제품별 판매 현황</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      	<div class="modal-body">
					<button type="button" onclick="loadChart('all')">전체</button>
					<button type="button" onclick="loadChart('상의')">상의</button>
					<button type="button" onclick="loadChart('하의')">하의</button>
					<button type="button" onclick="loadChart('악세사리')">악세사리</button>
					<button type="button" onclick="loadChart('신발')">신발</button>
					<div>
					  <canvas id="doughnutChart" style="width: 100%; height: 400px;"></canvas>
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
					monthAmount: ${month.monthAmount},
				}<c:if test="${!loop.last}">,</c:if>
			</c:forEach>
		];
		
		const weekSalesChart = [
			<c:forEach var="week" items="${weekSalesChart}" varStatus="loop">
				{
					saleDate: "${week.saleDate}",
					saleAmount: ${week.saleAmount},
				}<c:if test="${!loop.last}">,</c:if>
			</c:forEach>
		];
	</script>
	<script src="../resources/js/fm/saleManage.js"></script>
</body>
</html>