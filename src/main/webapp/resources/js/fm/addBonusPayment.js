const bonusNoCheck = /^[1-9]$/;
const paymentCheck = /^[1-9]\d*$/;
const payDateCheck = /.+/;
$(document).on("input", ".bonusNo, .payment, .payDate", (e) => {
	//console.log(e.target.value);
	//console.log(bonusNoCheck.test(e.target.value));
	//console.log(paymentCheck.test(e.target.value));
	//console.log(payDateCheck.test(e.target.value));
	
	let allValid = true;
	
	const bonusNoInput = document.querySelectorAll(".bonusNo");
	for (let i = 0; i < bonusNoInput.length; i++) {
		const input = bonusNoInput[i];
		if (!bonusNoCheck.test(input.value)) {
			input.parentElement.classList.add("red");
			allValid = false;
		} else {
			input.parentElement.classList.remove("red");
		}
	}
	
	const paymentInput = document.querySelectorAll(".payment");
	for (let i = 0; i < paymentInput.length; i++) {
		const input = paymentInput[i];
		if (!paymentCheck.test(input.value)) {
			input.parentElement.classList.add("red");
			allValid = false;
		} else {
			input.parentElement.classList.remove("red");
		}
	}
	
	const payDateInput = document.querySelectorAll(".payDate");
	for (let i = 0; i < payDateInput.length; i++) {
		const input = payDateInput[i];
		if (!payDateCheck.test(input.value)) {
			input.parentElement.classList.add("red");
			allValid = false;
		} else {
			input.parentElement.classList.remove("red");
		}
	}
	
	$("#bonus-register").prop("disabled", !allValid);
});

var count = 0;

function addRow() { // 열 추가 함수
	$("#result").append('<tr></tr>'); // 기본 열 추가
	for(var i = 0; i < 4; i++) { // 열에 데이터 추가
		if(i == 0) {
			count++;
			var text = `<td><input list="List${count}" class="empName" placeholder="사원 선택" /><datalist id="List${count}">${empInfo.map(emp => `<option value="${emp.empName}/${emp.deptName}/${emp.jobTitle}" data-emp_no="${emp.empNo}"></option>`).join("")}</datalist></td>`;
			$("#result tr").eq(-1).append(text);
		}
		else $("#result tr").eq(-1).append('<td></td>');
	}
	$("#result tr").eq(-1).append('<td><button class="remove-row">열 삭제</button></td>'); // 열 삭제 버튼 추가
}

addRow();

$("#add-row").click(() => { // 열 추가 버튼 클릭시 열 추가 함수 addRow 함수 실행
	addRow();
});

$(document).on("click", ".remove-row", function() { // 열 삭제 함수
	if($("#result tr").length > 2) $(this).parent().parent().remove();
});

$(document).on("change", ".empName", (e) => {
	const deptInfo = {};
	const val = $(e.target).val();
	console.log(val);
	const opt = $('#result tr').eq(1).find('td').eq(0).find('datalist').find('option').filter((a, o) => o.value === val);
	
	if (!opt.length) {
		alert("존재하지 않는 사원입니다");
		return;
	}
	
	deptInfo.deptNo = opt.data('emp_no');
	$(e.target).parent().parent().find("td").eq(1).html(`<select class="bonusNo"><option value="" disabled selected>선택</option>${bonus.map(bn => `<option value="${bn.bonusNo}">${bn.bonusName}</option>`).join("")}</select>`);
	$(e.target).parent().parent().find("td").eq(2).html('<input type="number" min="0" name="payment" class="payment" >');
	$(e.target).parent().parent().find("td").eq(3).html('<input type="date" name="payDate" class="payDate">');
});

$("#bonus-register").click(() => {
	const table = $("#result tr");
	const bList = [];
	for (var i = 1; i < table.length; i++) {
		const val = $('#result tr').eq(i).find('td').eq(0).find('input').val();
		const opt = $('#result tr').eq(i).find('td').eq(0).find('datalist').find('option').filter(function () {
		  return this.value === val;
		});
		const obj ={};
		obj.empNo=opt.data('emp_no');
		obj.bonusNo=$("#result tr").eq(i).find("td").eq(1).find("select").val();
		obj.payment=$("#result tr").eq(i).find("td").eq(2).find("input").val();
		obj.payDate=$("#result tr").eq(i).find("td").eq(3).find("input").val();
		
		bList.push(obj);
	}
	console.log(JSON.stringify(bList));
	console.log(bList.length);
	
	Swal.fire({
		title: "등록하시겠습니까?",
		text: "총 " + bList.length + "개의 내역이 등록됩니다!",
		icon: "question",
		iconColor: "#8de664",
		showCancelButton: true,
		confirmButtonColor: "#48b85b",
		cancelButtonColor: "#d33",
		confirmButtonText: "등록",
		cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type : "post",
					url: "/addBonusPayment",
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