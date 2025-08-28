const transAmountCheck = /^[1-9]\d*$/;
const transDateCheck = /.+/;
$(document).on("input", ".transAmount, .transDate", (e) => {
	//console.log(e.target.value);
	//console.log(transAmountCheck.test(e.target.value));
	//console.log(transDateCheck.test(e.target.value));
	
	const amountInput = document.querySelectorAll(".transAmount");
	for (let i = 0; i < amountInput.length; i++) {
		const input = amountInput[i];
		if (!transAmountCheck.test(input.value)) {
			input.parentElement.classList.add("red");
		} else {
			input.parentElement.classList.remove("red");
		}
	}
	
	const dateInput = document.querySelectorAll(".transDate");
	for (let i = 0; i < dateInput.length; i++) {
		const input = dateInput[i];
		if (!transDateCheck.test(input.value)) {
			input.parentElement.classList.add("red");
		} else {
			input.parentElement.classList.remove("red");
		}
	}
});

var count = 0;

function addRow() {
	$("#result").append("<tr></tr>");
	for (var i = 0; i < 7; i++) {
		if (i == 0) {
			count++;
			var text = `<td><input list="List${count}" class="deptName" placeholder="부서 선택"/><datalist id="List${count}">${department.map(dept => `<option value="${dept.deptName}" data-dept_no="${dept.deptNo}"></option>`).join("")}</datalist></td>`;
			$("#result tr").eq(-1).append(text);
		}
		else $("#result tr").eq(-1).append('<td></td>');
	}
	$("#result tr").eq(-1).append('<td><button class="remove-row">열 삭제</button></td>')
}

addRow();

$("#add-row").click(() => {
	addRow();
});

$(document).on("click", ".remove-row", function() {
	if ($("#result tr").length > 2) $(this).parent().parent().remove();
});

$(document).on("change", ".deptName", (e) => {
	$(e.target).parent().removeClass("red");
	$(e.target).parent().parent().find("td").eq(3).html("");
	const deptInfo = {};
	const val = $(e.target).val();
	console.log(val);
	const opt = $('#result tr').eq(1).find('td').eq(0).find('datalist').find('option').filter((a, o) => o.value === val);
	
	if (!opt.length) {
		//alert("없는 부서입니다");
		Swal.fire({
			position: "top",
			icon: "error",
			title: "없는 부서입니다",
			showConfirmButton: true,
			confirmButtonColor: "#85c468",
			timer: 2000
		});
		$(e.target).val("");
		for (var i = 1; i < 7; i++) {
			$(e.target).parent().parent().find("td").eq(i).text("");
			$(e.target).parent().parent().find("td").eq(i).removeClass("red");
		}
		return;
	}
	
	deptInfo.deptNo = opt.data('dept_no');
	$(e.target).parent().parent().find("td").eq(1).text(deptInfo.deptNo);
	$(e.target).parent().parent().find("td").eq(2).text("지출");
	$(e.target).parent().parent().find("td").eq(3).text("기타 비용");
	$(e.target).parent().parent().find("td").eq(4).html('<input type="number" min="0" name="trans-amount" class="transAmount" placeholder="금액 입력">');
	$(e.target).parent().parent().find("td").eq(5).html('<input type="text" name="trans-desc" class="transDesc" placeholder="상세내역 입력">');
	$(e.target).parent().parent().find("td").eq(6).html('<input type="date" name="trans-date" class="transDate">');
});

$("#trans-register").click(() => {
	let allFilled = true;
		
	$("#result tr").each(function () {
		$(this).find("input").not(".transDesc").each(function () {
			const val = String($(this).val() || "").trim()
			console.log(val)
			if (!val) {
				allFilled = false;
				$(this).parent().addClass("red");
			}
			
			if ($(this).is(".transAmount")) {
				if (!transAmountCheck.test(val)) {
					allFilled = false;
					$(this).parent().addClass("red");
                }
            }
						
			if ($(this).is(".transDate")) {
				if (!transDateCheck.test(val)) {
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
			text: "필수 정보를 정확히 입력해주세요.",
			showConfirmButton: true,
			confirmButtonColor: "#85c468",
			timer: 2000
        });
		return;
	}
	
	const table = $("#result tr");
	const tList = [];
	
	for (var i = 1; i < table.length; i++) {
		const obj ={};
		obj.deptNo=$("#result tr").eq(i).find("td").eq(1).text();
		obj.transType=$("#result tr").eq(i).find("td").eq(2).text();
		obj.category=$("#result tr").eq(i).find("td").eq(3).text();
		obj.transAmount=$("#result tr").eq(i).find("td").eq(4).find("input").val();
		obj.transDesc=$("#result tr").eq(i).find("td").eq(5).find("input").val();
		obj.transDate=$("#result tr").eq(i).find("td").eq(6).find("input").val();
		
		tList.push(obj);
	}
	console.log(JSON.stringify(tList));
	console.log(tList.length);
	
	Swal.fire({
		title: "등록하시겠습니까?",
		text: "총 " + tList.length + "개의 내역이 등록됩니다!",
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
					url: "/transRegister",
					dataType : "json",
					data : JSON.stringify(tList),
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