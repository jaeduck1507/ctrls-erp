<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>transaction</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<style>
	.modal-dialog {
		max-width: 800px;
	}
	.modal-body {
		height: 450px;
	}
</style>
</head>
<body>
	<h5>[재무 관리] > [거래내역 조회]</h5>
	<h3>거래내역 조회</h3>
	<div id="search" class="filter-bar">
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
		<button type="button" data-bs-toggle="modal" data-bs-target="#monthTrans">월별 수입/지출</button>
	</div>
	
	<div class="modal fade" id="monthTrans" tabindex="-1" aria-labelledby="chartModal" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="chartModal">월별 수입/지출</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      	<div class="modal-body">
				<div>
				  <canvas id="monthTransChart"></canvas>
				</div>
			</div>
	      	<div class="modal-footer">
	       	 	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	    	</div>
	    </div>
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
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
		const monthTransList = [
			<c:forEach var="trans" items="${monthTransList}" varStatus="loop">
				{
					transMonth: "${trans.transMonth}",
					monthIncome: ${trans.monthIncome},
					monthExpenses: ${trans.monthExpenses}
				}<c:if test="${!loop.last}">,</c:if>
			</c:forEach>
		];
	</script>
	<script src="../resources/js/fm/transaction.js"></script>
</body>
</html>