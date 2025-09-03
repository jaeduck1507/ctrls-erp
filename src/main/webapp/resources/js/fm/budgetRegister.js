const periodTypeCheck = /^[YQM]$/;
const budgetAmountCheck = /^[1-9]\d*$/;
const executionDateCheck = /.+/;
$(document).on("input", ".periodType, .budgetAmount, .executionDate", (e) => {
	const periodInput = document.querySelectorAll(".periodType");
	for (let i = 0; i < periodInput.length; i++) {
		const input = periodInput[i];
		if (!periodTypeCheck.test(input.value)) {
			input.parentElement.classList.add("red");
		} else {
			input.parentElement.classList.remove("red");
		}
	}
	
	const amountInput = document.querySelectorAll(".budgetAmount");
	for (let i = 0; i < amountInput.length; i++) {
		const input = amountInput[i];
		if (!budgetAmountCheck.test(input.value)) {
			input.parentElement.classList.add("red");
		} else {
			input.parentElement.classList.remove("red");
		}
	}
	
	const dateInput = document.querySelectorAll(".executionDate");
	for (let i = 0; i < dateInput.length; i++) {
		const input = dateInput[i];
		if (!executionDateCheck.test(input.value)) {
			input.parentElement.classList.add("red");
		} else {
			input.parentElement.classList.remove("red");
		}
	}
});

var count = 0;

function addRow() {
	$("#result").append('<tr></tr>');
	for(var i = 0; i < 6; i++) {
		if(i == 0) {
			count++;
			var text = `<td><input list="List${count}" class="deptName" placeholder="부서 선택"/><datalist id="List${count}">${department.map(dept => `<option value="${dept.deptName}" data-dept_no="${dept.deptNo}"></option>`).join("")}</datalist></td>`;
			$("#result tr").eq(-1).append(text);
		}
		else $("#result tr").eq(-1).append('<td></td>');
	}
	$("#result tr").eq(-1).append('<td><button class="remove-row">열 삭제</button></td>'); // 열 삭제 버튼 추가
}

addRow();

$("#add-row").click(() => {
	addRow();
});

$(document).on("click", ".remove-row", function() {
	if($("#result tr").length > 2) $(this).parent().parent().remove();
});

$(document).on("change", ".deptName", (e) => {
	$(e.target).parent().removeClass("red");
	const deptInfo = {};
	const val = $(e.target).val();
	const opt = $('#result tr').eq(1).find('td').eq(0).find('datalist').find('option').filter((a, o) => o.value === val);
	
	if (!opt.length) {
		Swal.fire({
			position: "top",
			icon: "error",
			title: "없는 부서입니다",
			showConfirmButton: true,
			confirmButtonColor: "#85c468",
			timer: 2000
		});
		$(e.target).val("");
		for (var i = 1; i < 6; i++) {
			$(e.target).parent().parent().find("td").eq(i).text("");
			$(e.target).parent().parent().find("td").eq(i).removeClass("red");
		}
		return;
	}
	
	deptInfo.deptNo = opt.data('dept_no');
	$(e.target).parent().parent().find("td").eq(1).text(deptInfo.deptNo);
	$(e.target).parent().parent().find("td").eq(2).html('<select class="periodType"><option value="" disabled selected>연/분기/월</option><option value="Y">연(Y)</option><option value="Q">분기(Q)</option><option value="M">월(M)</option></select>');
	$(e.target).parent().parent().find("td").eq(3).html('<input type="number" min="0" name="budget-amount" class="budgetAmount" placeholder="예산 입력">');
	$(e.target).parent().parent().find("td").eq(4).html('<input type="text" name="plan" class="plan" placeholder="계획 입력">');
	$(e.target).parent().parent().find("td").eq(5).html('<input type="date" name="execution-date" class="executionDate">');
});


$("#budget-register").click(() => {
	let allFilled = true;
	
	$("#result tr").each(function () {
		$(this).find("input, select").not(".plan").each(function () {
			const val = String($(this).val() || "").trim();
			if (!val) {
				allFilled = false;
				$(this).parent().addClass("red");
			}
			
			if ($(this).is(".periodType")) {
				if (!periodTypeCheck.test(val)) {
					allFilled = false;
					$(this).parent().addClass("red");
                }
            }
			
			if ($(this).is(".budgetAmount")) {
				if (!budgetAmountCheck.test(val)) {
					allFilled = false;
					$(this).parent().addClass("red");
                }
            }
			
			if ($(this).is(".executionDate")) {
				if (!executionDateCheck.test(val)) {
					allFilled = false;
					$(this).parent().addClass("red");
                }
            }
		});
	});
	
	if (!allFilled) {
		Swal.fire({
			position: "center",
			icon: "warning",
			iconColor: "#E74C3C",
			title: "등록 실패!",
			text: "필수 항목을 정확히 입력해주세요.",
			showConfirmButton: true,
			confirmButtonColor: "#85c468",
			timer: 2000
        });
		return;
	}
	
	const table = $("#result tr");
	const bList = [];
	
	for (var i = 1; i < table.length; i++) {
		const obj ={};
		obj.deptNo=$("#result tr").eq(i).find("td").eq(1).text();
		obj.periodType=$("#result tr").eq(i).find("td").eq(2).find("select").val();
		obj.annualBudget=$("#result tr").eq(i).find("td").eq(3).find("input").val();
		obj.plan=$("#result tr").eq(i).find("td").eq(4).find("input").val();
		obj.executionDate=$("#result tr").eq(i).find("td").eq(5).find("input").val();
		
		bList.push(obj);
	}
	
	Swal.fire({
		title: "등록하시겠습니까?",
		text: "총 " + bList.length + "개의 내역이 등록됩니다!",
		icon: "question",
		iconColor: "#48b85b",
		showCancelButton: true,
		confirmButtonColor: "#48b85b",
		cancelButtonColor: "#d33",
		confirmButtonText: "등록",
		cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type : "post",
					url: "/budgetRegister",
					dataType : "json",
					data : JSON.stringify(bList),
					processData: false,
					contentType: 'application/json; charset=UTF-8',
					success: function(response) {
						if (response) {
							Swal.fire({
								title: "등록 완료!",
								text: "성공적으로 등록되었습니다.",
								icon: "success",
								iconColor: "#48b85b",
								confirmButtonColor: "#48b85b",
								timer: 3000,
								timerProgressBar: true,
								didClose: () => {
									location.reload();
								}
							});
						}
					},
					error: function(xhr, status, error) {
						
					}
				});
			}
		});
});