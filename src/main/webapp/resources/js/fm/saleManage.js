const now = new Date();
const today = now.getFullYear() + '-' 
	                    + String(now.getMonth() + 1).padStart(2, '0') + '-' 
	                    + String(now.getDate()).padStart(2, '0');

let month = now.getFullYear() + '-' + String(now.getMonth() + 1).padStart(2, '0');
					
const monthChart = document.querySelector("#monthChart");
const weekChart = document.querySelector("#weekChart");

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
		responsive: true,
		maintainAspectRatio: false,
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
		responsive: true,
		maintainAspectRatio: false,
		scales: {
			y: {
				beginAtZero: true
			}
		}
	}
});

let doughnutChart;

// 차트 생성하기
function createChart(result) {
	let productLabels = [];
	let quantityValues = [];
	
	result.forEach(item => {
		productLabels.push(item.productName);
		quantityValues.push(item.monthQuantity);
	});
	
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
}

// formData 받아서 차트 조회하기 -> result 값을 createChart 로 전달
function searchChart(saleCategory, yearMonth) {
	const formData = new FormData();
	formData.append("saleCategory", saleCategory);
	formData.append("yearMonth", yearMonth);
		
	$.ajax({
		type: "post",
		url: "/monthQuantityChart",
		data: formData,
		processData: false,
		contentType: false,
		success: function(result) {
			let currentMonth = $("#yearMonth").val();
			if (result.length === 0) {
				Swal.fire({
					position: "top",
					icon: "error",
					title: "조회 실패",
					text: "해당 월의 판매 내역이 존재하지 않습니다!",
					showConfirmButton: false,
					timer: 2000,
					didClose: () => {
						if (currentMonth.substring(5) === String(now.getMonth() + 1).padStart(2, '0')) {
							month = now.getFullYear() + '-' + String(now.getMonth()).padStart(2, '0');
							if (now.getMonth() === 0) {
								month = now.getFullYear() - 1 + '-12';
							}
						} 
						reloadChart();
					}
				});
				return;
			}
			createChart(result);
		},
		error: function(xhr, status, error) {
			
		}
	});
}

// 처음 모달 창을 열었을 때 조회 초기값 세팅
$("#salesQuantity").on("show.bs.modal", function () {
	reloadChart();
});

// 조회 버튼 클릭 시 -> 카테고리와 월 데이터를 전달해서 차트 조회
$(document).on("click", "#search", function() {
	const saleCategory = $("#saleCategory").val();
	const yearMonth = $("#yearMonth").val();
	searchChart(saleCategory, yearMonth);
});

// 조회 실패 에러 시 차트 초기화면 재로딩
function reloadChart() {
	$("#saleCategory").val("all");
	$("#yearMonth").val(month);
	searchChart("all", month);
}

function showSaleManage(page = 1) {
	const formData = new FormData();
	formData.append("productCategory", $("#productCategory").val());
	formData.append("productName", $("#productName").val() || '');
	formData.append("page", page);
	
	const startDate = $("#startDate").val();
	const endDate = $("#endDate").val();
	
	if (startDate && endDate) {
		if (startDate > endDate) {
			Swal.fire({
				position: "top",
				icon: "error",
				title: "조회 실패",
				text: "조회 기간을 다시 선택해주세요!",
				showConfirmButton: false,
				timer: 1500
			});
			return;
		}
		formData.append("startDate", startDate);
		formData.append("endDate", endDate);
	} else if (startDate && !endDate) {
		formData.append("startDate", startDate);
		formData.append("endDate", today);
	} else if (!startDate && endDate) {
		formData.append("startDate", '1900-01-01');
		formData.append("endDate", endDate);
	}
	
	$.ajax({
		type: "post",
		url: "/showSaleManage",
		data: formData,
		processData: false,
		contentType: false,
		success: function(result) {
			if (!result.salesList || result.salesList.length === 0) {
				Swal.fire({
					position: "top",
					icon: "error",
					title: "조회된 결과가 없습니다!",
					showConfirmButton: false,
					timer: 1500,
					didClose: () => {
						$("#productCategory").val("all");
						$("#productName").val("");
						$("#startDate").val("");
						$("#endDate").val("");
						$("#result").html("");
						$(".pagination").html("");
					}
				});
				return;
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
}

$(document).ready(function() {
	showSaleManage(1);
});

$("#btn").click(function(e) {
	e.preventDefault();
	showSaleManage(1);
});

$(document).on('click', 'a.page-link', function(e) {
	e.preventDefault();
	const page = $(this).attr('href');
	showSaleManage(page);
});