<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 수정</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link rel="stylesheet" href="../resources/css/qamForm.css"/>
</head>
<body>
	<h5>[품질 관리] > [품질검사 결과 목록] > [품질 검사 수정]</h5>
	<h3>품질 검사 수정</h3>

<form id="qcFormUpdate" class="filter-bar">
	<div class="box">
		<table>
			<tr>
				<th>제품 번호</th>
				<td><input type="number" name="productNo"  id="productNo" value="${qc.productNo}" readonly /></td>
			</tr>
			<tr>
				<th>검사자 사번</th>
				<td>
					<select name="empNo" id="empNo">
						<option value="">사번 선택</option> 
						  <c:forEach var="e" items="${empList}">
						    <option value="${e.empNo}" <c:if test="${qc.empNo == e.empNo}">selected</c:if>>
						      [${e.empNo}] ${e.empName}
						    </option>
						  </c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>부자재 검사</th>
				<td>
			        <select name="checkMaterial" id="checkMaterial">
			            <option value="합격" ${qc.checkMaterial == '합격' ? 'selected' : ''}>합격</option>
			            <option value="불합격" ${qc.checkMaterial == '불합격' ? 'selected' : ''}>불합격</option>
			        </select>
				</td>
			</tr>
			<tr>
				<th>색상 검사</th>
				<td>
			        <select name="checkColor" id="checkColor">
			            <option value="합격" ${qc.checkColor == '합격' ? 'selected' : ''}>합격</option>
			            <option value="불합격" ${qc.checkColor == '불합격' ? 'selected' : ''}>불합격</option>
			        </select>
				</td>
			</tr>
			<tr>
				<th>손상 검사</th>
				<td>
			        <select name="checkDamage" id="checkDamage">
			            <option value="합격" ${qc.checkDamage == '합격' ? 'selected' : ''}>합격</option>
			            <option value="불합격" ${qc.checkDamage == '불합격' ? 'selected' : ''}>불합격</option>
			        </select>
				</td>
			</tr>
			<tr>
				<th>검사 설명</th>
				<td>
					<textarea name="qcDesc" id="qcDesc">${qc.qcDesc}</textarea>
				</td>
			</tr>
		</table>
	</div>
	
	<div>
    	<button type="submit" class="btn">수정</button>
		<a href="/qam/qc" class="btn">목록으로</a>
	</div>
</form>

<script>
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
</script>

</body>
</html>
