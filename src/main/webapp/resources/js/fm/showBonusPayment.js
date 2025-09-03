function showBonusPayment(page = 1) {
	const formData = new FormData();
	formData.append("empName", $("#empName").val() || '');
	formData.append("deptNo", $("#deptName").val());
	formData.append("jobNo", $("#jobTitle").val());
	formData.append("date", $("#date").val() || '');
	formData.append("page", page);
	
	$.ajax({
        type : "post",
        url : "/showBonusPayment",
        data : formData,
		processData: false,
		contentType: false,
		
        success : function(result) {
			if (!result.bonusPaymentList || result.bonusPaymentList.length === 0) {
				Swal.fire({
					position: "top",
					icon: "error",
					title: "조회된 결과가 없습니다!",
					showConfirmButton: false,
					timer: 1500,
					didClose: () => {
						$("#empName").val("");
						$("#deptName").val("-1");
						$("#jobTitle").val("-1");
						$("#date").val("");
						$("#result").html("");
						$(".pagination").html("");
					}
				});
				return;
			}
			
			$("#result").html("");
        	$("#result").append("<tr><th>이름</th><th>부서</th><th>직급</th><th>수당 금액</th><th>수당 종류</th><th>지급 날짜</th></tr>");
        	for(const bonus of result.bonusPaymentList) {
			var text = "<tr><td>"+ bonus.empName +"</td><td>"+bonus.deptName+"</td><td>"+bonus.jobTitle+"</td><td>"+bonus.payment.toLocaleString()+"</td><td>"+bonus.bonusName+"</td><td>"+bonus.payDate+"</td></tr>"
				$("#result").append(text);
        	}
			
			$(".pagination").html('');
        	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
        	for (var i = result.startPage; i <= result.endPage; i++) {
        		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
        	}
        	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>'); 
        },
		error:function(xhr,status,error) {
			
		}
    });
}

$(document).ready(function() {
	showBonusPayment(1);
});

$("#btn").click(function(e) {
	e.preventDefault();
	showBonusPayment(1);
});

$(document).on('click', 'a.page-link', function(e) {
	e.preventDefault();
	const page = $(this).attr('href');
	showBonusPayment(page);
});