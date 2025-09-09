<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>브랜드 등록</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <link rel="stylesheet" href="../resources/css/qam/qamForm.css"/>
</head>

<body>
  <h5>[제품 관리] > [브랜드 조회] > [브랜드 등록]</h5>
  <h3>브랜드 등록</h3>

  <form id="brandForm" class="filter-bar">
    <div class="box">
      <table>
        <tr>
          <th>브랜드명</th>
          <td><input type="text" name="brandName" id="brandName" ></td>
        </tr>
        <tr>
          <th>전화번호</th>
          <td><input type="text" name="brandPhone" id="brandPhone" ></td>
        </tr>
        <tr>
          <th>계좌번호</th>
          <td><input type="text" name="brandAccount" id="brandAccount" ></td>
        </tr>
        <tr>
          <th>사용 은행</th>
          <td><input type="text" name="brandBank" id="brandBank" ></td>
        </tr>
      </table>
    </div>

    <div>
      <button type="submit" class="btn" id="saveBtn">저장</button>
      <a href="/qam/brand" class="btn">목록으로</a>
    </div>
  </form>
  
  <script src="../resources/js/qam/brandForm.js"></script>

</body>
</html>
