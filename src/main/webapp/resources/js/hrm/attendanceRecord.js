$("#setAttendance").click(() => {

	console.log(($("#empNo").val() == -1) || !($("#workDate").val()));

	if (($("#empNo").val() == -1) || !($("#workDate").val())) {
		Swal.fire({
			title: "직원정보와 날짜를 선택해주세요!",
			confirmButtonText: '확인',
			width: 600,
			confirmButtonColor: "#90C67C",
			icon: "warning",
			iconColor: "green"
		});
	} else {


		Swal.fire({
			title: "변경하시겠습니까?",
			confirmButtonText: '변경',
			confirmButtonColor: "green",
			icon: "question",
			iconColor: "green",
			showCancelButton: true,
			cancelButtonText: '취소',
			cancelButtonColor: "red"
		}).then((result) => {
			if (result.isConfirmed) {
				const empNo = $("#empNo").val();
				const workDate = $("#workDate").val();
				const obj = {};
				obj.empNo = empNo;
				obj.workDate = workDate;
				$.ajax({
					// 요청
					type: "post",
					url: "/setAttendance",
					dataType: "json",
					data: JSON.stringify(obj),
					processData: false,
					contentType: 'application/json; charset=UTF-8',

					// 응답
					success: function(result) {
						let timerInterval;
						Swal.fire({
							icon: "success",
							iconColor: "green",
							title: "성공적으로 등록했습니다!",
							html: '<span id="aa"></span>초 후 자동으로 닫힙니다.',
							timer: 2000,
							timerProgressBar: true,
							didOpen: () => {
								Swal.showLoading();
								const timer = Swal.getPopup().querySelector("#aa");
								timerInterval = setInterval(() => {
									let remainSecond = parseInt(Swal.getTimerLeft() / 1000);
									timer.textContent = remainSecond + 1;
								}, 100);
							},
							willClose: () => {
								clearInterval(timerInterval);
							}
						}).then((result) => {

							if (result.dismiss == "backdrop") {
								location.reload();
							}
							if (result.dismiss === Swal.DismissReason.timer) {
								location.reload();
							}
						});
					},

					error: function(xhr, status, error) {

					}
				});

			}
		});

	}
});

