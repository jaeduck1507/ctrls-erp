const now = new Date();
const today = now.getFullYear() + '-' 
	                    + String(now.getMonth() + 1).padStart(2, '0') + '-' 
	                    + String(now.getDate()).padStart(2, '0');

const monthTrans = document.querySelector("#monthTrans");
/*
const transMonthLabels = [
	<c:forEach var="trans" items="${monthTransList}" varStatus="loop">
		"${trans.transMonth}"<c:if test="${!loop.last}">,</c:if>
	</c:forEach>
];

const monthIncomeValues = [
	<c:forEach var="trans" items="${monthTransList}" varStatus="loop">
		"${trans.monthIncome}"<c:if test="${!loop.last}">,</c:if>
	</c:forEach>
];

const monthExpensesValues = [
	<c:forEach var="trans" items="${monthTransList}" varStatus="loop">
		"${trans.monthExpenses}"<c:if test="${!loop.last}">,</c:if>
	</c:forEach>
];
*/

const transMonthLabels = monthTransList.map(item => item.transMonth);
const monthIncomeValues = monthTransList.map(item => item.monthIncome);
const monthExpensesValues = monthTransList.map(item => item.monthExpenses);

new Chart(monthTransChart, {
	type: 'bar',
	data: {
		labels: transMonthLabels,
		datasets: [
			{
				label: '월별 수입',
				data: monthIncomeValues,
				backgroundColor: 'rgba(255, 99, 132, 0.2)',
				borderColor: 'rgb(255, 99, 132)',
				borderWidth: 1
			},
			{
				label: '월별 지출',
				data: monthExpensesValues,
				backgroundColor: 'rgba(54, 162, 235, 0.2)',
				borderColor: 'rgb(54, 162, 235)',
				borderWidth: 1
			}
		]
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

function showTrans(page = 1) {
	const formData = new FormData();
	formData.append("transType", $("#transType").val());
	formData.append("deptName", $("#deptName").val());
	formData.append("transDesc", $("#transDesc").val() || '');
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
		url: "/showtrans",
		data: formData,
		processData: false,
		contentType : false,
		success: function(result) {
			//console.log($("#transType").val());
			//console.log($("#deptName").val());
			//console.log($("#transDesc").val());
			//console.log($("#startDate").val());
			//console.log($("#endDate").val());
			
			if (!result.transList || result.transList.length === 0) {
				//alert("조회된 결과가 없습니다");
				//location.reload();
				Swal.fire({
					position: "top",
					icon: "error",
					title: "조회된 결과가 없습니다!",
					showConfirmButton: false,
					timer: 1500,
					didClose: () => {
						$("#transType").val("all");
						$("#deptName").val("all");
						$("#transDesc").val("");
						$("#startDate").val("");
						$("#endDate").val("");
						$("#result").html("");
						$(".pagination").html("");
					}
				});
				return;
			}
			
			$("#result").html("");
			$("#result").append("<tr><th>거래 번호</th><th>부서</th><th>수입/지출</th><th>금액</th><th>분류</th><th>상세 내역</th><th>발생 일자</th></tr>");
				for (const trans of result.transList) {
					var text = "<tr><td>" + trans.transNo + "</td><td>" + trans.deptName + "</td><td>" + trans.transType + "</td><td>" + trans.transAmount .toLocaleString()
						+ "</td><td>" + trans.category + "</td><td>" + trans.transDesc + "</td><td>" + trans.transDate + "</td></tr>"
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
	showTrans(1);
});

$("#btn").click(function(e) {
	e.preventDefault();
	showTrans(1);
});

$(document).on('click', 'a.page-link', function(e) {
	e.preventDefault();
	const page = $(this).attr('href');
	console.log(page);
	showTrans(page);
	/*
	const formData = new FormData();
	formData.append("transType", $("#transType").val());
	formData.append("deptName", $("#deptName").val());
	formData.append("page", $(this).attr('href'));
	
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
		url: "/showtrans",
		data: formData,
		processData: false,
		contentType : false,
		success: function(result) {
			$("#result").html("");
			$("#result").append("<tr><th>거래 번호</th><th>부서</th><th>수입/지출</th><th>금액</th><th>분류</th><th>상세 내역</th><th>발생 일자</th></tr>");
				for (const trans of result.transList) {
					var text = "<tr><td>" + trans.transNo + "</td><td>" + trans.deptName + "</td><td>" + trans.transType + "</td><td>" + trans.transAmount.toLocaleString()
						+ "</td><td>" + trans.category + "</td><td>" + trans.transDesc + "</td><td>" + trans.transDate + "</td></tr>"
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
	});*/
});