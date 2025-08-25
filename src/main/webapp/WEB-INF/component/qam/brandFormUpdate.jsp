<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>브랜드 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link rel="stylesheet" href="../resources/css/qamForm.css"/>
</head>

<body>
	<h5>[품질 관리] > [브랜드 조회] > [브랜드 수정]</h5>
	<h3>브랜드 수정</h3>

	<form id="brandFormUpdate" class="filter-bar">
		<div class="box">
			<table>
				<input type="hidden" name="brandCode" id="brandCode" value="${brand.brandCode}" />
				<tr>
					<th>브랜드명</th>
				   	<td><input type="text" name="brandName" id="brandName" value="${brand.brandName}" required /></td>
				</tr>
				<tr>
					<th>전화번호</th>
				   	<td><input type="text" name="brandPhone" id="brandPhone" value="${brand.brandPhone}" required /></td>
				</tr>
				<tr>
					<th>계좌번호</th>
				   	<td><input type="text" name="brandAccount" id="brandAccount" value="${brand.brandAccount}" required /></td>
				</tr>
				<tr>
					<th>사용 은행</th>
				   	<td><input type="text" name="brandBank" id="brandBank" value="${brand.brandBank}" required /></td>
				</tr>
			</table>
		</div>
		
		<div>
			<button type="submit" class="btn" id="saveBtn">저장</button>
			<a href="/qam/brand" class="btn">목록으로</a>
		</div>
</form>

<script>
  function collectMissingFields() {
    const labels = {
      brandName: "브랜드명",
      brandPhone: "전화번호",
      brandAccount: "계좌번호",
      brandBank: "사용 은행"
    };
    const missing = [];
	  Object.keys(labels).forEach(k => {
	    const v = $("#" + k).val()?.trim();
	    if (!v) missing.push(labels[k]);
	  });
	  return missing;
	}

  $("#brandFormUpdate").on("submit", function (e) {
    e.preventDefault();

	const phone = $("#brandPhone").val().trim();
	const account = $("#brandAccount").val().trim();

    if (!/^\d{9,15}$/.test(phone)) {
      Swal.fire({
        icon: "error",
        title: "형식 오류",
        text: "전화번호는 숫자 9~15자리로 입력해주세요.",
        confirmButtonText: "확인",
        confirmButtonColor: "#90C67C"
      });
      return;
    }

    if (!/^\d{8,14}$/.test(account)) {
      Swal.fire({
        icon: "error",
        title: "형식 오류",
        text: "계좌번호는 숫자 8~14자리로 입력해주세요.",
        confirmButtonText: "확인",
        confirmButtonColor: "#90C67C"
      });
      return;
    }

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
      title: "수정하시겠습니까?",
      text: "수정된 브랜드 정보를 저장합니다.",
      showCancelButton: true,
      confirmButtonText: "수정",
      cancelButtonText: "취소",
      confirmButtonColor: "green",
      cancelButtonColor: "red"
    }).then((res) => {
      if (!res.isConfirmed) return;

      const payload = {
        brandCode:  $("#brandCode").val(), // include the id being updated
		brandName: $("#brandName").val().trim(),
		brandPhone: $("#brandPhone").val().trim(),
		brandAccount: $("#brandAccount").val().trim(),
		brandBank: $("#brandBank").val().trim()
      };

      $.ajax({
        type: "post",
        url: "/updateBrand",
        data: $.param(payload), // form-urlencoded
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function () {
          let timerInterval;
          Swal.fire({
            icon: "success",
            iconColor: "green",
            title: "수정 완료",
            html: '<span id="aa"></span>초 후 목록으로 이동합니다.',
            timer: 2000,
            timerProgressBar: true,
            didOpen: () => {
              Swal.showLoading();
              const span = Swal.getPopup().querySelector("#aa");
              timerInterval = setInterval(() => {
                span.textContent = Math.ceil(Swal.getTimerLeft() / 1000);
              }, 100);
            },
            willClose: () => clearInterval(timerInterval)
          }).then(() => {
            window.location.href = "/qam/brand";
          });
        }
      });
    });
  });
</script>



</body>
</html>
