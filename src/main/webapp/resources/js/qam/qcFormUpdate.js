function collectMissingFields() {
  const labels = {
    productNo: "상품",
    empNo: "검사자 사번",
    checkMaterial: "부자재 검사",
    checkColor: "색상 검사",
    checkDamage: "손상 검사",
  };
  const missing = [];
  Object.keys(labels).forEach(k => {
  	const v = $("#" + k).val()?.trim();
	if (!v) missing.push(labels[k]);
  });
  return missing;
  }

$("#qcFormUpdate").on("submit", function (e) {
	e.preventDefault();
	
const missing = collectMissingFields();
if (missing.length > 0) {
  Swal.fire({
    icon: "warning",
    iconColor: "green",
    title: "입력 누락",
    html: "다음 항목을 모두 입력해주세요:<br>" + missing.join(", "),
    confirmButtonText: "확인",
    confirmButtonColor: "#90C67C"
  });
  return;
}

Swal.fire({
  icon: "question",
  iconColor: "green",
  title: "등록하시겠습니까?",
  text: "신규 검사를 저장합니다.",
  showCancelButton: true,
  confirmButtonText: "등록",
  cancelButtonText: "취소",
  confirmButtonColor: "green",
  cancelButtonColor: "red"
}).then((res) => {
  if (!res.isConfirmed) return;

const payload = $("#qcFormUpdate").serialize(); 
// form-urlencoded, serialize시 이런식으로 뜸 "productName=청바지&productPrice=10000&productCost=7000"

$.ajax({
      type: "post",
      url: "/qam/updateQc",
      data: payload,
      contentType: "application/x-www-form-urlencoded; charset=UTF-8",
      success: function () {
        let timerInterval;
        Swal.fire({
          icon: "success",
          iconColor: "green",
          title: "저장 완료",
          html: '<span id="remainSec"></span>초 후 목록으로 이동합니다.',
          timer: 2000,
          timerProgressBar: true,
          didOpen: () => {
            Swal.showLoading();
            const span = Swal.getPopup().querySelector("#remainSec");
            timerInterval = setInterval(() => {
              span.textContent = Math.ceil(Swal.getTimerLeft() / 1000);
            }, 100);
          },
          willClose: () => clearInterval(timerInterval)
        }).then(() => {
          window.location.href = "/qam/qc";
        });
       }
    });
  });
});