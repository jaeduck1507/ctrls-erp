const now = new Date();
const month = now.getMonth() + 1;
document.querySelector("#currentMonth").innerHTML = month + "월";

const monthChart = document.querySelector("#monthChart");
const weekChart = document.querySelector("#weekChart");
/*
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
*/

const monthLabels = monthSalesChart.map(item => item.saleMonth);
const monthDataValues = monthSalesChart.map(item => item.monthAmount);

const weekLabels = weekSalesChart.map(item => item.saleDate);
const weekDataValues = weekSalesChart.map(item => item.saleAmount);

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

let doughnutChart;
		
$("#salesQuantity").on("shown.bs.modal", function () {
	loadChart('all');
});

function loadChart(category) {
    console.log(category);
	
	const formData = new FormData();
	formData.append("productCategory", category);
	
	$.ajax({
		type: "post",
		url: "/monthQuantityChart",
		data: formData,
		processData: false,
		contentType: false,
		success: function(result) {
			console.log(result);
			
			let productLabels = [];
			let quantityValues = [];
			
			result.forEach(item => {
				productLabels.push(item.productName);
				quantityValues.push(item.monthQuantity);
			});
			
			console.log(productLabels);
			console.log(quantityValues);
			
			if (doughnutChart) {
				doughnutChart.destroy();
			}
			
			const ctx = document.querySelector("#doughnutChart");
			doughnutChart = new Chart(ctx, {
				type: 'doughnut',
				data: {
					labels: productLabels,
					datasets: [{
						label: '제품별 판매 수량',
						data: quantityValues,
						backgroundColor: [
						'rgba(255, 99, 132, 0.5)',
						'rgba(255, 159, 64, 0.5)',
						'rgba(255, 205, 86, 0.5)',
						'rgba(75, 192, 192, 0.5)',
						'rgba(54, 162, 235, 0.5)',
						'rgba(153, 102, 255, 0.5)',
						'rgba(255, 182, 193, 0.5)'
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
			
		},
		error: function(xhr, status, error) {
			
		}
	});
}


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