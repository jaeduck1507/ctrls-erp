<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>제품명 등록/수정</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <link rel="stylesheet" href="../resources/css/qamForm.css"/>
</head>
<body>
  <h5>[품질 관리] > [브랜드 조회] > [제품 정보 수정/등록]</h5>
  <h3>제품 정보 수정/등록</h3>

  <form id="productForm" class="filter-bar" action="${action}" method="post" novalidate>
    <input type="hidden" name="productCode" id="productCode" value="${productName.productCode}"/>

    <div class="box">
      <table>
        <tr>
          <th>브랜드</th>
          <td>
            <select name="brandCode" id="brandCode">
              <c:forEach var="brand" items="${brandList}">
                <option value="${brand.brandCode}" ${productName.brandCode == brand.brandCode ? 'selected' : ''}>${brand.brandName}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <th>카테고리</th>
          <td>
            <select name="productCategory" id="productCategory">
              <c:forEach var="category" items="${categoryList}">
                <option value="${category}" ${productName.productCategory == category ? 'selected' : ''}>${category}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <th>제품명</th>
          <td><input type="text" name="productName" id="productName" value="${productName.productName}"/></td>
        </tr>
        <tr>
          <th>색상</th>
          <td><input type="text" name="productColor" id="productColor" value="${productName.productColor}"/></td>
        </tr>
        <tr>
          <th>판매가</th>
          <td><input type="text" name="productPrice" id="productPrice" value="${productName.productPrice}"/></td>
        </tr>
        <tr>
          <th>단가</th>
          <td><input type="text" name="productCost" id="productCost" value="${productName.productCost}"/></td>
        </tr>
      </table>
    </div>

    <div>
      <button type="submit" class="btn" id="saveBtn">저장</button>
      <a href="/qam/productName" class="btn">목록으로</a>
    </div>
  </form>

  <script>

    function collectMissingFields() {
      const labels = {
        brandCode: "브랜드",
        productCategory: "카테고리",
        productName: "제품명",
        productColor: "색상",
        productPrice: "판매가",
        productCost: "단가"
      };
	    const missing = [];
	    Object.keys(labels).forEach(k => {
	      const v = $("#" + k).val()?.trim();
		// 가격/단가 0일 시 상황 포함
	      if (!v || v === "0") {
	        missing.push(labels[k]);
	      }
	    });
	    return missing;
	  }

    function validateNumbers() {
      const price = $("#productPrice").val().trim();
      const cost  = $("#productCost").val().trim();

      if (!/^\d{1,20}$/.test(price)) {
        return { ok: false, msg: "판매가는 숫자로 입력해주세요." };
      }
      if (!/^\d{1,20}$/.test(cost)) {
        return { ok: false, msg: "단가는 숫자로 입력해주세요." };
      }
      if (parseInt(price, 20) <= 0 || parseInt(cost, 20) <= 0) {
        return { ok: false, msg: "판매가와 단가를 입력해주세요." };
      }
      // 판매가 >= 단가 제약
      if (parseInt(price, 20) < parseInt(cost, 20)) {
        return { ok: false, msg: "판매가는 단가 이상이어야 합니다." };
      }
      return { ok: true };
    }

    $("#productForm").on("submit", function (e) {
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

      const numCheck = validateNumbers();
      if (!numCheck.ok) {
        Swal.fire({
          icon: "error",
          title: "형식 오류",
          text: numCheck.msg,
          confirmButtonText: "확인",
          confirmButtonColor: "#90C67C"
        });
        return;
      }

      Swal.fire({
        icon: "question",
        iconColor: "green",
        title: "저장하시겠습니까?",
        text: "제품 정보를 저장합니다.",
        showCancelButton: true,
        confirmButtonText: "저장",
        cancelButtonText: "취소",
        confirmButtonColor: "green",
        cancelButtonColor: "red"
      }).then((res) => {
        if (!res.isConfirmed) return;

        const url = $("#productForm").attr("action");
        const payload = $("#productForm").serialize(); 
		// form-urlencoded, serialize시 이런식으로 뜸 "productName=청바지&productPrice=10000&productCost=7000"

        $.ajax({
          type: "post",
          url: url,
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
              window.location.href = "/qam/productName";
            });
          }
        });
      });
    });
  </script>
</body>
</html>
