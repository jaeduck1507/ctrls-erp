<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>상품 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  </head>

  <body>
    <h5>[품질 관리] > [상품 조회]</h5>
    <h3>상품 조회</h3>
      <!-- 검색창 -->
      <form action="product" method="get">
		<div class="filter-bar">
	        제품명: <input type="text" name="productName" value="${productName}" />
			<select name="productCategory">
				<option value="">카테고리 선택</option>
				<c:forEach items="${categoryList}" var="category">
					<option value="${category}">${category}</option>
				</c:forEach>
			</select>
	        <button type="submit">검색</button>
	        <button type="button" id="resetBtn">전체보기</button>
		</div>
      </form>
   

    <!-- 제품 목록 테이블 -->
    <table border="1" id="result" class="data-table">
      <tr>
        <th>제품 번호</th>
        <th>입고일</th>
        <th>제품 코드</th>
        <th>카테고리</th>
        <th>색상</th>
        <th>제품명</th>
        <th>판매가</th>
        <th>단가</th>
        <th>삭제</th>
      </tr>

      <c:forEach items="${productList}" var="p">
        <tr>
          <td>${p.productNo}</td>
          <td>${p.productionDate}</td>
          <td>${p.productCode}</td>
          <td>${p.productCategory}</td>
          <td>${p.productColor}</td>
          <td>${p.productName}</td>
          <td>${p.productPrice}</td>
          <td>${p.productCost}</td>
          <td>
            <a href="/deleteProduct?productNo=${p.productNo}" class="btnX">삭제</a>
          </td>
        </tr>
      </c:forEach>
    </table>

    <nav>
      <ul class="pagination">
        <li class="page-item ${paging.prev ? '' : 'disabled'}">
          <a
            class="page-link"
            href="/qam/product?page=${paging.startPage - 1}&productName=${productName}&productCategory=${productCategory}"
            >Previous</a
          >
        </li>
        <c:forEach
          begin="${paging.startPage}"
          end="${paging.endPage}"
          var="page"
        >
          <li class="page-item">
            <a
              class="page-link ${paging.page == page ? 'active' : ''}"
              href="/qam/product?page=${page}&productName=${productName}&productCategory=${productCategory}"
              >${page}</a
            >
          </li>
        </c:forEach>
        <li class="page-item ${paging.next ? '' : 'disabled'}">
          <a
            class="page-link"
            href="/qam/product?page=${paging.endPage + 1}&productName=${productName}&productCategory=${productCategory}"
            >Next</a
          >
        </li>
      </ul>
    </nav>

    <script src="../resources/js/qam/product.js"></script>
  </body>
</html>
