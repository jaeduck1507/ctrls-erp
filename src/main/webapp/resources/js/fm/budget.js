const deptBalance = balanceList.map(item => ({
	deptName: item.deptName,
	balance: item.totalBudget - item.expenses
}));

function showBudget(page = 1) {
	const formData = new FormData();
	const deptName = $("#deptName").val();
	formData.append("deptName", deptName);
	formData.append("yearMonth", $("#yearMonth").val() || '');
	formData.append("page", page);
	
	if (deptName === 'all') {
		document.querySelector("#balance").innerHTML = "";
		$("#balance").removeClass("balance");
	}
	
	$.ajax({
		type: "post",
		url: "/showBudget",
		data: formData,
		processData: false,
		contentType : false,
		success: function(result) {
			if (!result.budgetList || result.budgetList.length === 0) {
				Swal.fire({
					position: "top",
					icon: "error",
					title: "조회된 결과가 없습니다!",
					showConfirmButton: false,
					timer: 1500,
					didClose: () => {
						$("#deptName").val("all");
						$("#yearMonth").val("");
						$("#result").html("");
						$(".pagination").html("");
						document.querySelector("#balance").innerHTML = "";
						$("#balance").removeClass("balance");
					}
				});
				return;
			}
			
			if (deptName) {
				const balanceInfo = deptBalance.find(item => item.deptName === deptName);
				if (balanceInfo) {
					document.querySelector("#balance").innerHTML = `${balanceInfo.deptName} 남은 예산: ${balanceInfo.balance.toLocaleString()}원`;
					$("#balance").addClass("balance");
				}
			}
						
			$("#result").html("");
			$("#result").append("<tr><th>예산 코드</th><th>부서</th><th>예산 금액</th><th>계획</th><th>예산 집행일</th><th>수정</th><th>삭제</th></tr>");
			for (const budget of result.budgetList) {
				var text = "<tr><td>" + budget.periodValue + "</td><td>" + budget.deptName + "</td><td>" 
					+ budget.annualBudget.toLocaleString() + "</td><td>" + budget.plan + "</td><td>" + budget.executionDate + "</td></tr>"
				$("#result").append(text);
				$("#result tr").eq(-1).append('<td><a href="/fm/budgetUpdate?budgetNo=' + budget.budgetNo + '" class="btnO">수정</a></td>');
				$("#result tr").eq(-1).append('<td><a href="/fm/budgetDelete?budgetNo=' + budget.budgetNo + '" class="btnX">삭제</a></td>');
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
	showBudget(1);
});

$("#btn").click(function(e) {
	e.preventDefault();
	showBudget(1);
});

$(document).on('click', 'a.page-link', function(e) {
	e.preventDefault();
	const page = $(this).attr('href');
	showBudget(page);
});

$(document).on('click', 'a.btnX', function(e) {
	e.preventDefault();
	
	Swal.fire({
		title: "정말 삭제하시겠습니까?",
		text: "삭제를 누르면 해당 항목이 영구적으로 삭제됩니다.",
		icon: "warning",
		iconColor: "#f1a025",
		showCancelButton: true,
		confirmButtonColor: "#48b85b",
		cancelButtonColor: "#d33",
		confirmButtonText: "삭제",
		cancelButtonText: "취소"
	}).then((result) => {
		if (result.isConfirmed) {
			Swal.fire({
				title: "삭제 완료!",
				text: "성공적으로 삭제되었습니다.",
				icon: "success",
				iconColor: "#48b85b",
				confirmButtonColor: "#48b85b",
				timer: 3000,
				timerProgressBar: true,
				didClose: () => {
					location.href = $(this).attr("href");
				}
			});
		}
	});
});