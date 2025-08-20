<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>모달 테스트</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
	<div class="filter-bar">
		
		<button type="button" data-bs-toggle="modal" data-bs-target="#barModal">bar</button>
		<button type="button" data-bs-toggle="modal" data-bs-target="#doughnutModal">doughnut</button>
		<button type="button" data-bs-toggle="modal" data-bs-target="#lineModal">line</button>
		<button type="button" data-bs-toggle="modal" data-bs-target="#scatterModal">scatter</button>
		
		<!-- bar -->
		<div class="modal fade" id="barModal" tabindex="-1" aria-labelledby="exampleModal" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModal">그래프</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      	<div class="modal-body">
					<p>bar</p>
					<div>
					  <canvas id="barChart"></canvas>
					</div>
				</div>
		      	<div class="modal-footer">
		       	 	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		    	</div>
		    </div>
		  </div>
		</div>
		
		<!-- doughnut -->
		<div class="modal fade" id="doughnutModal" tabindex="-1" aria-labelledby="exampleModal" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModal">그래프</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      	<div class="modal-body">
					<p>doughnut</p>
					<div>
					  <canvas id="doughnutChart"></canvas>
					</div>
				</div>
		      	<div class="modal-footer">
		       	 	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		    	</div>
		    </div>
		  </div>
		</div>
		
		<!-- line -->
		<div class="modal fade" id="lineModal" tabindex="-1" aria-labelledby="exampleModal" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModal">그래프</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      	<div class="modal-body">
					<p>line</p>
					<div>
					  <canvas id="lineChart"></canvas>
					</div>
				</div>
		      	<div class="modal-footer">
		       	 	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		    	</div>
		    </div>
		  </div>
		</div>
		
		<!-- scatterChart -->
		<div class="modal fade" id="scatterModal" tabindex="-1" aria-labelledby="exampleModal" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModal">그래프</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      	<div class="modal-body">
					<p>scatter</p>
					<div>
					  <canvas id="scatterChart"></canvas>
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
		  const barChart = document.getElementById('barChart');
		  const doughnutChart = document.getElementById('doughnutChart');
		  const lineChart = document.getElementById('lineChart');
		  const scatterChart = document.getElementById('scatterChart');
		  
		  const labels = [
		      <c:forEach var="sales" items="${salesChart}" varStatus="loop">
		        "${sales.saleDate}"<c:if test="${!loop.last}">,</c:if>
		      </c:forEach>
		    ];
			
			const dataValues = [
			   <c:forEach var="sales" items="${salesChart}" varStatus="loop">
			     ${sales.saleAmount}<c:if test="${!loop.last}">,</c:if>
			   </c:forEach>
			 ];
		  
		  new Chart(barChart, {
		    type: 'bar',
		    data: {
		      labels: labels,
		      datasets: [{
		        label: '주간 매출액',
		        data: dataValues,
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
		 
		  new Chart(doughnutChart, {
  		    type: 'doughnut',
  		    data: {
			  labels: labels,
			  datasets: [{
			    label: '주간 매출액',
			    data: dataValues,
			    backgroundColor: [
			      'rgb(255, 99, 132)',
			      'rgb(54, 162, 235)',
			      'rgb(255, 205, 86)',
				  'rgb(50, 205, 50)',
				  'rgb(153, 102, 255)'
			    ],
			    hoverOffset: 4
			  }]
			},
  		    options: {
				responsive: true, // 창 크기에 맞게 자동 조절
				maintainAspectRatio: false, // 비율 고정 여부
				cutout: "50%", // 도넛 가운데 구멍 크기 (퍼센트나 픽셀 가능)
  		    }
  		  });
		  
		  new Chart(lineChart, {
		    type: 'line',
		    data: {
			  labels: labels,
			  datasets: [{
			    label: '주간 매출액',
			    data: dataValues,
			    fill: false,
			    borderColor: 'rgb(75, 192, 192)'
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
		  
		  new Chart(scatterChart, {
  		    type: 'scatter',
  		    data: {
  			  labels: ['January', 'February', 'March', 'April'],
			  datasets: [{
			      type: 'bar',
			      label: 'Bar Dataset',
			      data: [10, 20, 30, 40],
				  borderWidth: 1,
			      borderColor: 'rgb(255, 99, 132)',
			      backgroundColor: 'rgba(255, 99, 132, 0.2)'
			    }, {
		      type: 'line',
		      label: 'Line Dataset',
		      data: [15, 30, 25, 43],
		      fill: false,
		      borderColor: 'rgb(255, 99, 132)'
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
	</script>
</body>
</html>