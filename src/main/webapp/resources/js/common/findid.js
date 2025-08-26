$("#btn").click(() => {
  const formData = new FormData();
  formData.append("empNo", $("#empNo").val());
  $("#result").empty();
  $.ajax({
    type: "post",
    url: "/findId",
    data: formData,
    processData: false,
    contentType: false,
    success: function (result) {
      if (result == "") {
        $("#result").append("아이디가 존재하지 않습니다.");
      } else {
        $("#result").append("아이디는 " + result + "입니다.");
		
      }
    },
    error: function (xhr, status, error) {	
		Swal.fire({
			title: "사번을 입력해주세요!",
			confirmButtonText: '확인',
			width: 600,
			confirmButtonColor: "#90C67C",
			icon: "warning",
			iconColor: "green"
			});
		},
  });
});
