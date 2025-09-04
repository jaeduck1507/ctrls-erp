
// 휴가시작일, 종료일 신청날짜 다음날로 고정(다음날부터 신청가능하도록)
const today = new Date();
const year = today.getFullYear();
const month = String(today.getMonth() + 1).padStart(2, "0");
const day = String(today.getDate()).padStart(2, "0");
let tomorrow = new Date();
tomorrow.setDate(today.getDate() + 1);
// 내일이 주말이면 다음 월요일로 이동
let dayOfWeek = tomorrow.getDay(); // 0=일, 6=토
if (dayOfWeek === 6) {
	// 토요일이면 +2일 → 월요일
	tomorrow.setDate(tomorrow.getDate() + 2);
} else if (dayOfWeek === 0) {
	// 일요일이면 +1일 → 월요일
	tomorrow.setDate(tomorrow.getDate() + 1);
}
const nextYear = tomorrow.getFullYear();
const nextMonth = String(tomorrow.getMonth() + 1).padStart(2, "0");
const nextDay = String(tomorrow.getDate()).padStart(2, "0");
const nextStr = nextYear + "-" + nextMonth + "-" + nextDay;

// 과거시간, 주말, 공휴일 선택 제한
const holidays = [// 막을 공휴일 목록
	"2025-08-15", // 광복절
	"2025-10-03", // 개천절
	"2025-10-06", // 추석
	"2025-10-07", // 추석연휴
	"2025-10-08", // 대체 휴일
	"2025-10-09", // 한글날
	"2025-12-25", // 크리스마스
	"2026-01-01"  // 신정
];

const leaveDateInputs = document.querySelectorAll('.leaveDate');
const endDateInput = document.querySelector('#endDate');

leaveDateInputs.forEach(function(input) {
	input.setAttribute('min', nextStr); // 과거 날짜 선택 제한

	input.addEventListener('input', function() {
		const selectedDate = new Date(this.value); // 사용자가 선택한 날짜
		const day = selectedDate.getDay(); // 사용자가 선택한 날짜 요일로 변환
		const weekend = (day === 0 || day === 6); // 0: 일, 6: 토 주말
		const holiday = holidays.includes(this.value); // 공휴일

		if (weekend || holiday) {
			Swal.fire({
				title: "다른 날짜를 선택해주세요.",
				text: "주말 및 공휴일은 선택이 불가합니다.",
				confirmButtonText: '확인',
				width: 600,
				confirmButtonColor: "#90C67C",
				icon: "warning"
			});
			this.value = nextStr; // 날짜 초기화
			return;
		}
		// 휴가 종료일은 휴가 시작일부터 가능하도록 제어
		endDateInput.setAttribute('min', this.value);
		$("#endDate").val(this.value);
	});
});

$(document).ready(function() {

	// 수정 버튼 클릭 시
	$("#update").click(function(e) {
		e.preventDefault(); // 기본 제출 막기
		const leaveId = $("input[name='leaveId']").val();
		const empNo = $("input[name='empNo']").val(); // JSP에서 hidden으로 내려줘야 함
		const startDate = $("input[name='startDate']").val();
		const endDate = $("input[name='endDate']").val();
		// 1. 먼저 겹침 체크
		$.ajax({
			url: "/checkApprove",
			type: "POST",
			data: {
				empNo: empNo,
				startDate: startDate,
				endDate: endDate,
				leaveId: leaveId // 수정 중인 자기 휴가는 제외하려면 활용
			},
			success: function(result) {
				if (result > 0) {
					Swal.fire({
						title: "다른 날짜를 선택해주세요.",
						text: "이미 신청 또는 승인된 휴가일 입니다.",
						confirmButtonText: '확인',
						width: 600,
						confirmButtonColor: "#90C67C",
						icon: "warning"
					});
					return;
				}

				Swal.fire({
					title: '수정하시겠습니까?',
					text: "변경된 내용을 저장합니다.",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '수정',
					cancelButtonText: '취소'
				}).then((result) => {
					if (result.isConfirmed) {
						$("form").submit(); // 확인 시 폼 제출
					}
				});
			}
		});
	});

	// 취소 버튼 클릭 시
	$("#cancel").click(function() {
		Swal.fire({
			title: '취소하시겠습니까?',
			text: "변경된 내용은 저장되지 않습니다.",
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '취소',
			cancelButtonText: '돌아가기'
		}).then((result) => {
			if (result.isConfirmed) {
				location.href = '/hrm/leaveInfo'; // 확인 시 이동
			}
		});
	});

});
