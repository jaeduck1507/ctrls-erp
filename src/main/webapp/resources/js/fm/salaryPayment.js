const deductionCheck = /^[0-9]\d*(\.\d+)?$/;
// 유효성 검사 함수
function validateDeductions() {	
	const deductionInput = document.querySelectorAll(".deduction");
	for (let i = 0; i < deductionInput.length; i++) {
		const input = deductionInput[i];
		const deduction = Number(input.value || 0);
		const baseSalary = Number($(input).parent().parent().find("td").eq(5).text() || 0);
		
		const checkValid = deductionCheck.test(input.value) && baseSalary > deduction;
		if (!checkValid) {
			input.parentElement.classList.add("red");
		} else {
			input.parentElement.classList.remove("red");
		}
		
		localStorage.setItem(input.name, input.value || 0);
		localStorage.setItem(input.name + "_valid", checkValid);
	}
	
	// 전체 localStorage 기준으로 버튼 disabled 결정
	const allKeys = Object.keys(localStorage).filter(k => k.endsWith("_valid"));
	const anyInvalid = allKeys.some(k => localStorage.getItem(k) === "false");
	$("#submit").prop("disabled", anyInvalid);
}

// 버튼 상태 복원 함수
function restoreSubmitState() {
    // localStorage에서 모든 deduction_*_YYYYMM key 확인
	const allKeys = Object.keys(localStorage).filter(k => k.endsWith("_valid"));
	const anyInvalid = allKeys.some(k => localStorage.getItem(k) === "false");
	$("#submit").prop("disabled", anyInvalid);
}

// 페이지 로딩 시 localStorage 초기화
$(document).ready(function() {
	Object.keys(localStorage).filter(k => k.startsWith("deduction_")).forEach(k => localStorage.removeItem(k));
});

// 아래 쪽에 있는 input deduction function 에 넣어도 OK
$(document).on('input', '.deduction', function() {
	validateDeductions();
});

var salayPagingDTO = {};
function inint_Paing() {
salayPagingDTO = { 
		offset: 0,
        limit: 10,
        page: 1,
        pageSize: 10,
        endPage: this.pageSize,
        startPage: this.endPage - this.pageSize + 1,
        prev : false,
        next : false,
        total: 0,

        setTotal(total) {
          this.total = total;
          this.offset = (this.page - 1) * this.limit;

          this.endPage = Math.ceil(this.page / this.pageSize) * this.pageSize;
          this.startPage = this.endPage - this.pageSize + 1;

          const lastPage = Math.ceil(this.total / this.limit);

          if (lastPage < this.endPage) {
            this.endPage = lastPage;
          };

          this.prev = this.startPage > 1;
          this.next = this.endPage < lastPage;
        }
	};
};

$("#btn").click(() => {
	const yearMonth = $("#yearMonth").val();
	if(yearMonth) {
		$.ajax({
			type: "post",
			url: "/salaryPayment",
			data: {yearMonth : yearMonth},
			
			success: function(result) {
				inint_Paing();
				salayPagingDTO.result = result;
				salayPagingDTO.setTotal(result.length);
				console.log(result.length);
				if (result.length === 0) {
					Swal.fire({
						position: "top",
						icon: "error",
						title: "급여 등록이 완료된 월입니다!",
						showConfirmButton: false,
						timer: 1500,
						didClose: () => {
							$("#yearMonth").val("");
							$("#result").html("");
							$(".pagination").html("");
						}
					});
					return;
				}
				
				$("#result").html("");
				$("#result").append("<tr><th>직원 번호</th><th>직원 이름</th><th>부서명</th><th>직급명</th><th>지급일</th><th>기본급</th><th>보너스</th><th>공제금</th><th>급여 총액</th></tr>");
				for (var i = salayPagingDTO.offset;   i < ((salayPagingDTO.offset + salayPagingDTO.limit) > salayPagingDTO.result.length ? salayPagingDTO.result.length: (salayPagingDTO.offset + salayPagingDTO.limit) ); i++) {
					var deduction =0;
					if(salayPagingDTO.result[i].deduction == 0) {
						deduction = (Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus))*0.1;
						salayPagingDTO.result[i].deduction = deduction;
					} else {
						deduction = salayPagingDTO.result[i].deduction;
					}
					
					//console.log(salayPagingDTO.result[i].empName);
					const inputName = 'deduction_' + salayPagingDTO.result[i].empNo + '_' + yearMonth;
					//console.log(inputName);
					
					var text = '<tr id="index_'+ i +'"><td>' + salayPagingDTO.result[i].empNo + "</td><td>" + salayPagingDTO.result[i].empName + "</td><td>" + salayPagingDTO.result[i].deptName + "</td><td>" 
						+ salayPagingDTO.result[i].jobTitle + "</td><td>" + (yearMonth +'-15') + "</td><td>" + salayPagingDTO.result[i].baseSalary + "</td><td>" + salayPagingDTO.result[i].bonus + "</td><td>" 
						+ '<input type="number" min="0" class="deduction" name="' + inputName + '" value="'+ deduction +'">' +"</td><td>" + ((Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus)-deduction)) + "</td></tr>";
					$("#result").append(text);
				}
				$("#result").append('<div class="filter-bar"><button id="submit">등록하기</button></div>');
				
				$(".pagination").html('');
            	$(".pagination").append('<li class="page-item ' + (salayPagingDTO.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (salayPagingDTO.startPage - 1) + '">Previous</a></li>');
            	for(var i =salayPagingDTO.startPage; i<=salayPagingDTO.endPage; i++) {
            		$(".pagination").append('<li class="page-item"><a class="page-link ' + (salayPagingDTO.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
            	}
            	$(".pagination").append('<li class="page-item ' + (salayPagingDTO.next ? '' : 'disabled') + '"><a class="page-link" href="' + (salayPagingDTO.endPage + 1) + '">Next</a></li>');
				
				// 유효성 복원
				$(".deduction").each(function() {
			        const saved = localStorage.getItem(this.name);
			        if (saved !== null) $(this).val(saved);

			        const isValid = localStorage.getItem(this.name + "_valid");
			        if (isValid === "false") $(this).parent().addClass("red");
			        else $(this).parent().removeClass("red");
			    });
				
				// 유효성 검사 함수
				validateDeductions();
				
				// 버튼 복원 함수
				restoreSubmitState();
				
			},
			error: function(xhr, status, error) {
						
			}
		});
		
	} else {
		//alert("월을 입력해주세요");
		//location.reload();
		Swal.fire({
			position: "top",
			icon: "error",
			title: "조회할 월을 선택해주세요!",
			showConfirmButton: true,
			confirmButtonColor: "#85c468",
			timer: 2000
		});
		return;
	}
});

$(document).on('input', '.deduction', (e) => {
	const indexNum = $(e.target).parent().parent().attr("id").split("_")[1];
	console.log(indexNum);
	const deduction = $(e.target).val();
	const salaryDate = $(e.target).parent().parent().find("td").eq(4).text();
	const baseSalary = $(e.target).parent().parent().find("td").eq(5).text();
	const bonus = $(e.target).parent().parent().find("td").eq(6).text();
	const total = Number(baseSalary) + Number(bonus) - deduction;
	salayPagingDTO.result[Number(indexNum)].deduction = deduction;
	salayPagingDTO.result[Number(indexNum)].baseSalary = baseSalary;
	salayPagingDTO.result[Number(indexNum)].bonus = bonus;
	salayPagingDTO.result[Number(indexNum)].salaryDate = salaryDate;
	console.log(salayPagingDTO.result[Number(indexNum)].bonus);
	$(e.target).parent().parent().find("td").eq(8).html("");
	$(e.target).parent().parent().find("td").eq(8).text(total);
});

$(document).on('click', 'a.page-link', function(e) {
    e.preventDefault();    
   
    // a 태그 기본 동작(페이지 이동) 차단
    
    const yearMonth = $("#yearMonth").val();
	const page = $(this).attr('href');
	salayPagingDTO.offset = (page - 1) * salayPagingDTO.limit;
	salayPagingDTO.page = page;
	salayPagingDTO.setTotal(salayPagingDTO.result.length);
        
	// 링크 URL 읽기

	$("#result").html("");
	$("#result").append("<tr><th>직원 번호</th><th>직원 이름</th><th>부서명</th><th>직급명</th><th>지급일</th><th>기본급</th><th>보너스</th><th>공제금</th><th>급여 총액</th></tr>");
	for (var i = salayPagingDTO.offset;   i < ((salayPagingDTO.offset + salayPagingDTO.limit) > salayPagingDTO.result.length ? salayPagingDTO.result.length: (salayPagingDTO.offset + salayPagingDTO.limit) ); i++) {
		var deduction =0;
		if(salayPagingDTO.result[i].deduction ==0) {
			deduction = (Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus))*0.1;
			salayPagingDTO.result[i].deduction = deduction;
		} else {
			deduction = salayPagingDTO.result[i].deduction;
		}
		
		const inputName = 'deduction_' + salayPagingDTO.result[i].empNo + '_' + yearMonth;
		
		var text = '<tr id="index_'+ i +'"><td>' + salayPagingDTO.result[i].empNo + "</td><td>" + salayPagingDTO.result[i].empName + "</td><td>" + salayPagingDTO.result[i].deptName + "</td><td>" 
			+ salayPagingDTO.result[i].jobTitle + "</td><td>" + (yearMonth +'-15') + "</td><td>" + salayPagingDTO.result[i].baseSalary + "</td><td>" + salayPagingDTO.result[i].bonus + "</td><td>" 
			+ '<input type="number" min="0" class="deduction" name="' + inputName + '" value="'+ deduction +'">' +"</td><td>" + ((Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus)-deduction)) + "</td></tr>";
		$("#result").append(text);
		console.log(i + " : " + ((Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus))*0.1));
	}
	$("#result").append('<div class="filter-bar"><button id="submit">등록하기</button></div>');
	
	$(".pagination").html('');
	$(".pagination").append('<li class="page-item ' + (salayPagingDTO.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (salayPagingDTO.startPage - 1) + '">Previous</a></li>');
	for(var i =salayPagingDTO.startPage; i<=salayPagingDTO.endPage; i++) {
		$(".pagination").append('<li class="page-item"><a class="page-link ' + (salayPagingDTO.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
	}
	$(".pagination").append('<li class="page-item ' + (salayPagingDTO.next ? '' : 'disabled') + '"><a class="page-link" href="' + (salayPagingDTO.endPage + 1) + '">Next</a></li>');
    
    
	// 유효성 복원
	$(".deduction").each(function() {
        const saved = localStorage.getItem(this.name);
        if (saved !== null) $(this).val(saved);

        const isValid = localStorage.getItem(this.name + "_valid");
        if (isValid === "false") $(this).parent().addClass("red");
        else $(this).parent().removeClass("red");
    });
	
	// 유효성 검사 함수
	validateDeductions();
	
	// 버튼 복원 함수
	restoreSubmitState();
});

$(document).on("click", "#submit", function() { // 제출 버튼
	const yearMonth = $("#yearMonth").val();
    const table = $("#result tr"); // 테이블 정보 획득
    const spList = []; // 객체를 담을 배열
	
    for(var r of salayPagingDTO.result){ // i가 1부터 시작하는 이유는 첫번째 열은 th(열의 설명)부분이라 데이터가 아님
        const obj ={}; // 직원 하나당 하나의 객체로 생성
        /*
        obj.empNo=$("#result tr").eq(i).find("td").eq(0).text(); 
        obj.salaryDate=$("#result tr").eq(i).find("td").eq(4).text(); 
        obj.baseSalary=$("#result tr").eq(i).find("td").eq(5).text(); 
        obj.bonus=$("#result tr").eq(i).find("td").eq(6).text(); 
        obj.deduction=$("#result tr").eq(i).find("td").eq(7).find("input").val(); 
        */
        
        obj.empNo= r.empNo;
        obj.salaryDate= yearMonth +'-15';
        obj.baseSalary= r.baseSalary;
        obj.bonus=r.bonus;
        
        var deduction =0;
		if(r.deduction == 0) {
			deduction = (Number(r.baseSalary)+Number(r.bonus))*0.1;
			r.deduction = deduction;
		} else {
			deduction = r.deduction;
		}
        
        obj.deduction=r.deduction
        
        
        spList.push(obj); // 정보 저장한 객체를 배열에 삽입
    }
    console.log(spList);
	console.log(spList.length);
	
	Swal.fire({
		title: "등록하시겠습니까?",
		text: "총 " + spList.length + "개의 내역이 등록됩니다!",
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
					// 요청
					type : "post",
					url : "/addSalaryPayment",
					dataType : "json", // dataType 지정해줘야 자바에서 인식하는 듯?
					data : JSON.stringify(spList), // json문자열로 변환해서 전송
					processData: false,
					contentType: 'application/json; charset=UTF-8', // formData에서는 false였으나 여기서는 contentType을 지정해줘야함
			        // 응답
					success: function(result) {
						if (result) {
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