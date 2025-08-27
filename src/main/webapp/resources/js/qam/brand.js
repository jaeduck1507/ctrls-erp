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
				timer: 2000,
				timerProgressBar: true,
				didClose: () => {
					location.href = $(this).attr("href");
				}
			});
		}
	});
});