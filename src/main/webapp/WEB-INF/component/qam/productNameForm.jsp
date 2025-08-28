<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>제품명 등록/수정</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <link rel="stylesheet" href="../resources/css/qam/qamForm.css"/>
</head>
<body>
  <h5>[품질 관리] > [브랜드 조회] > [제품 정보 수정/등록]</h5>
  <h3>제품 정보 수정/등록</h3>

  <form id="productForm" class="filter-bar" action="${action}" method="post" novalidate>
    <input type="hidden" name="productCode" id="productCode" value="${productName.productCode}"/>

    <div class="box">
      <table>
        <tr>
          <th><i class="fi fi-rr-brand-badge"></i>&nbsp;&nbsp;브랜드</th>
          <td>
            <select name="brandCode" id="brandCode">
			<option value="" disabled selected>선택</option>
              <c:forEach var="brand" items="${brandList}">
                <option value="${brand.brandCode}" ${productName.brandCode == brand.brandCode ? 'selected' : ''}>${brand.brandName}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <th><i class="fi fi-rr-category-alt"></i>&nbsp;&nbsp;카테고리</th>
          <td>
            <select name="productCategory" id="productCategory">
			<option value="" disabled selected>선택</option>
              <c:forEach var="category" items="${categoryList}">
                <option value="${category}" ${productName.productCategory == category ? 'selected' : ''}>${category}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
		
<!--		<tr>-->
<!--          <th>제품 사진</th>-->
<!--		  <td><input type="file" name="productFile" id="productFile" accept="image/*"/></td>-->
<!--		  <td><img id="preview" style="display:none; max-width:160px; margin-top:8px;"/></td>-->
<!--        </tr>-->
		
        <tr>
          <th><i class="fi fi-rr-gift-card"></i>&nbsp;&nbsp;제품명</th>
          <td><input type="text" name="productName" id="productName" value="${productName.productName}"/></td>
        </tr>
        <tr>
          <th><i class="fi fi-rr-fill"></i>&nbsp;&nbsp;색상</th>
          <td><input type="text" name="productColor" id="productColor" value="${productName.productColor}"/></td>
        </tr>
        <tr>
          <th><i class="fi fi-rr-tags">&nbsp;&nbsp;</i>판매가</th>
          <td><input type="text" name="productPrice" id="productPrice" value="${productName.productPrice}"/></td>
        </tr>
        <tr>
          <th><i class="fi fi-rr-dollar"></i>&nbsp;&nbsp;단가</th>
          <td><input type="text" name="productCost" id="productCost" value="${productName.productCost}"/></td>
        </tr>
      </table>
    </div>

    <div>
      <button type="submit" class="btn" id="saveBtn">저장</button>
      <a href="/qam/productName" class="btn">목록으로</a>
    </div>
  </form>

  <script src="../resources/js/qam/productNameForm.js"></script>
  
</body>
</html>
