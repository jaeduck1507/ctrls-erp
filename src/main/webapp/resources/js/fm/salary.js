function showSalary(page = 1) {
	const formData = new FormData();
	formData.append("deptName", $("#deptName").val());
	formData.append("empName", $("#empName").val() || '');
	formData.append("yearMonth", $("#yearMonth").val() || '');
	formData.append("page", page);
	
	$.ajax({
		type: "post",
		url: "/showSalary",
		data: formData,
		processData: false,
		contentType : false,
		success: function(result) {
			if (!result.salaryList || result.salaryList.length === 0) {
				Swal.fire({
					position: "top",
					icon: "error",
					title: "조회된 결과가 없습니다!",
					showConfirmButton: false,
					timer: 1500,
					didClose: () => {
						$("#deptName").val("all");
						$("#empName").val("");
						$("#yearMonth").val("");
						$("#result").html("");
						$(".pagination").html("");
					}
				});
				return;
			}
			
			$("#result").html("");
			$("#result").append("<tr><th>직원 번호</th><th>부서</th><th>사원</th><th>지급일</th><th>기본급</th><th>보너스</th><th>공제금</th><th>급여 총액</th></tr>");
			for (const salary of result.salaryList) {
				const total = salary.baseSalary + salary.bonus - salary.deduction;
				var text = "<tr><td>" + salary.empNo + "</td><td>" + salary.deptName + "</td><td>" + salary.empName + "</td><td>" + salary.salaryDate 
					+ "</td><td>" + salary.baseSalary.toLocaleString() + "</td><td>" + salary.bonus.toLocaleString() + "</td><td>" + salary.deduction.toLocaleString() 
					+ "</td><td>" + total.toLocaleString() + "</td></tr>"
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
	showSalary(1);
});

$("#btn").click(function(e) {
	e.preventDefault();
	showSalary(1);
});

$(document).on('click', 'a.page-link', function(e) {
    e.preventDefault();
	const page = $(this).attr('href');
	showSalary(page);
}); 