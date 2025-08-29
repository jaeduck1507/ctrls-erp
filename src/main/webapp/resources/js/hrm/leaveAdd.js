function addRow() {
    // 행 추가
    $("#result").append("<tr></tr>");
    let $newRow = $("#result tr").last(); // 마지막 행 선택

    // 열 추가
    $newRow.append('<td><input type="text" class="empNo" placeholder="사번 입력"></td>');
    $newRow.append('<td><input type="date" class="currentDate" disabled></td>');
    $newRow.append('<td><select><option disabled selected>유형선택</option><option value="연차" selected>연차</option><option value="병가">병가</option><option value="경조사">경조사</option><option value="기타">기타</option></select></td>');
    $newRow.append('<td><input type="date" class="leaveDate startDate"></td>');
    $newRow.append('<td><input type="date" class="leaveDate endDate"></td>');
    $newRow.append('<td><input type="text" value="휴가"></td>');
    $newRow.append('<td><button class="btn4">열 삭제</button></td>');

    // 현재 날짜 고정
	 const today = new Date();
	 const year = today.getFullYear();
	 const month = String(today.getMonth() + 1).padStart(2, "0");
	 const day = String(today.getDate()).padStart(2, "0");
	 const todayStr = year+"-"+month+"-"+day;
    $newRow.find(".currentDate").val(todayStr);

    // 내일부터 시작 (주말 보정)
    let tomorrow = new Date();
    tomorrow.setDate(today.getDate() + 1);
	// 토요일이면 +2일 → 월요일
    if (tomorrow.getDay() === 6) tomorrow.setDate(tomorrow.getDate() + 2); // 토요일 → 월요일
	// 일요일이면 +1일 → 월요일
	if (tomorrow.getDay() === 0) tomorrow.setDate(tomorrow.getDate() + 1); // 일요일 → 월요일

	 const nextYear = tomorrow.getFullYear();
	 const nextMonth = String(tomorrow.getMonth() + 1).padStart(2, "0");
	 const nextDay = String(tomorrow.getDate()).padStart(2, "0");
	 const nextStr = nextYear+"-"+nextMonth+"-"+nextDay;
    $newRow.find(".leaveDate").val(nextStr).attr("min", nextStr);

    // 공휴일
    const holidays = [
        "2025-08-15", // 광복절
        "2025-10-03", // 개천절
        "2025-10-06", // 추석
        "2025-10-07", // 추석연휴
        "2025-10-08", // 대체휴일
        "2025-10-09", // 한글날
        "2025-12-25", // 크리스마스
        "2026-01-01"  // 신정
    ];

    // 새 행의 시작일 / 종료일
    let $startDate = $newRow.find(".startDate");
    let $endDate   = $newRow.find(".endDate");

    // 날짜 선택 이벤트 (행마다 독립적으로 바인딩)
    $newRow.find(".leaveDate").on("input", function () {
        const selectedDate = new Date(this.value);
        const day = selectedDate.getDay();
        const weekend = (day === 0 || day === 6);
        const holiday = holidays.includes(this.value);

        if (weekend || holiday) {
            Swal.fire({
                title: "다른 날짜를 선택해주세요.",
                text: "주말 및 공휴일은 선택이 불가합니다. ",
                confirmButtonText: "확인",
                confirmButtonColor: "#90C67C",
                icon: "warning"
            });
            $(this).val(nextStr);
            $endDate.val($startDate.val());
            return;
        }

        // 종료일은 시작일 이후만 가능
        $endDate.attr("min", $startDate.val());
        if ($endDate.val() < $startDate.val()) {
            $endDate.val($startDate.val());
        }
    });
	checkAllValid();
}

// 행 삭제
$(document).on("click", ".btn4", function () {
    if ($("#result tr").length > 2) {
        $(this).closest("tr").remove();
    }
});

// 초기 행 자동 추가
addRow();

// 열 추가 버튼
$("#btn2").click(() => {
    addRow();
});

// 제출 버튼
$("#btn").click((e) => {
    const table = $("#result tr");
    const liList = [];
    let valid = true;

    for (let i = 1; i < table.length; i++) { // 첫 행은 th라 제외
        const obj = {};
        const empNoVal = $("#result tr").eq(i).find("td").eq(0).find("input").val().trim();

        if (!empNoVal) {
            Swal.fire({
                title: "사번을 입력해주세요!",
                confirmButtonText: "확인",
                width: 600,
                confirmButtonColor: "#90C67C",
                icon: "warning",
                
            });
            valid = false;
            break;
        }

        obj.empNo       = empNoVal;
        obj.requestDate = $("#result tr").eq(i).find("td").eq(1).find("input").val();
        obj.leaveType   = $("#result tr").eq(i).find("td").eq(2).find("select").val();
        obj.startDate   = $("#result tr").eq(i).find("td").eq(3).find("input").val();
        obj.endDate     = $("#result tr").eq(i).find("td").eq(4).find("input").val();
        obj.reason      = $("#result tr").eq(i).find("td").eq(5).find("input").val();

        liList.push(obj);
    }

    if (!valid) return;

	Swal.fire({
            title: "휴가를 등록 하시겠습니까?",
            confirmButtonText: "신청",
            confirmButtonColor: "green",
            icon: "question",
            iconColor: "green",
            showCancelButton: true,
            cancelButtonText: "취소",
            cancelButtonColor: "red"
        }).then((result) => {
            if (result.isConfirmed) {
				
    $.ajax({
        type: "post",
        url: "/leaveAdd",
        dataType: "text",
        data: JSON.stringify(liList),
        processData: false,
        contentType: "application/json; charset=UTF-8",
		success: function(response) {
                   if (response === "success") {
					Swal.fire({
	   					title: "휴가 신청 완료!",
	   					text: "성공적으로 신청되었습니다.",
	   					icon: "success",
	   					timer: 3000,
	   					timerProgressBar: true,
	   					didClose: () => {
	   						location.href = $(this).attr("href");
	   					}
	   				}).then(() => location.reload());
                   } else if (response === "overlap") {
                       Swal.fire({
                           title: "다른 날짜를 선택해주세요.",
                           text: "이미 신청 또는 승인된 휴가일 입니다.",
                           confirmButtonText: '확인',
                           width: 600,
                           confirmButtonColor: "#90C67C",
                           icon: "warning"
                       });
                   } else if (response === "exceed") {
                       Swal.fire({
                           title: "휴가일수를 확인해주세요.",
                           text: "남은 휴가일수를 초과했습니다.",
                           confirmButtonText: '확인',
                           width: 600,
                           confirmButtonColor: "#90C67C",
                           icon: "warning"
                       });
                   }
               },
               error: function(xhr, status, error) {
                   console.error(error);
               }
           });
       }
       // 취소를 누르면 서버 호출 없음 → 저장 안 됨
   });
});
let empNoValid = false;
let startDateCheck = false;
let endDateCheck = false;
function checkAllValid() {
  let valid = true;

  $("#result tr").each(function (index) {
    if (index === 0) return; // 첫 행은 th라 제외

    const empNoVal = $(this).find(".empNo").val().trim();
    const startVal = $(this).find(".startDate").val();
    const endVal   = $(this).find(".endDate").val();

    if (empNoVal === "" || startVal === "" || endVal === "") {
      valid = false;
      return false; // 하나라도 공란이면 반복 중단
    }
  });

  $("#btn").prop("disabled", !valid);
}

// --- 이벤트 바인딩 (동적 행 대응) ---
$(document).on("input", ".empNo", checkAllValid);
$(document).on("change", ".startDate", checkAllValid);
$(document).on("change", ".endDate", checkAllValid);

$("#btn").prop("disabled", true);