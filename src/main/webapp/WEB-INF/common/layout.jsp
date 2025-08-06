<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ERP</title>

    <!-- 
    <link rel="stylesheet" href="../resources/css/reset.css">
    <link rel="stylesheet" href="../resources/css/layout.css">
    
     -->
  </head>
  <body>
    <!-- 여기다가 각자 링크 작성하시면 됩니다! -->

    <a href="/hrm/empInfo">사원정보조회 /hrm/empInfo</a><br />
    <a href="/hrm/empAdd">사원정보추가 /hrm/empAdd</a><br />
    <a href="/hrm/quitShow">퇴사자정보조회 /hrm/quitShow</a><br />
    <a href="/hrm/empEval">인사/성과평가 /hrm/empEval</a><br />
	<a href="/hrm/attendanceRecord">출근/퇴근 기록 /hrm/attendanceRecord</a><br />
	<a href="/hrm/showAttendance">출근/퇴근 조회 /hrm/attendanceRecord</a><br />
	<a href="/hrm/attendanceStats">출근/퇴근 통계 /hrm/attendanceStats</a><br />
	
	<a href="/hrm/leaveAdd">휴가 신청 /hrm/leaveAdd</a><br />
	<a href="/hrm/leaveInfo">휴가 조회 /hrm/leaveInfo</a><br />
	<a href="/hrm/leaveDays">휴가 누적 사용일, 남은 휴가일 조회 /hrm/leaveDays</a></br>
	<a href="/hrm/leaveStatus">휴가 상태 처리 /hrm/leaveStatus</a><br />

    <a href="/fm/budget">예산 조회 /fm/budget</a><br />
    <a href="/fm/saleManage">매출 조회 /fm/saleManage</a><br />
    <a href="/fm/purchase">매입 내역 조회 /fm/purchase</a><br />
    <a href="/fm/purchaseRegister">매입 일괄 등록 /fm/purchaseRegister</a><br />
    <a href="/fm/transaction">거래내역 조회 /fm/transaction</a><br />
	<a href="/fm/salary">급여 조회 /fm/salary</a><br />
	<a href="/fm/salaryPayment">급여 등록 /fm/salaryPayment</a><br />
	<a href="/fm/budgetRegister">예산 등록 /fm/budgetRegister</a><br />
	<a href="/fm/saleRegister">매출 등록 /fm/saleRegister</a><br />
	<a href="/fm/transRegister">거래내역 입력 /fm/transRegister</a><br />
	<a href="/fm/addBonusPayment">사원 보너스 입력 /fm/addBonusPayment</a><br />
	<a href="/fm/showBonusPayment">사원 보너스 조회 /fm/showBonusPayment</a><br />

    <a href="/qam/product">상품(Product) 조회 /qam/product</a><br />
    <a href="/qam/productName">제품(ProductName) 조회/등록/수정/삭제 /qam/productName</a><br />
    <a href="/qam/qc">제품 품질 검수 전체조회 /qam/qc</a><br />
	<a href="/qam/saleReady">판매 전 제품 조회 /qam/saleReady</a><br />
	<a href="/qam/saleDone">판매 완료 제품 조회 /qam/saleDone</a><br />
	<a href="/qam/defective">불량 제품 조회 /qam/defective</a><br />
	
	<!-- 로그인 및 로그아웃 버튼 위에다가 기능 작성해주세요 -->
	<br><br><br><br>
	<sec:authorize access="isAnonymous()">
	<a href="/login">로그인</a><br>
	<a href="/register">회원가입</a><br>
	</sec:authorize>
	
	<sec:authorize access="isAuthenticated()">
	<a href="/logout">로그아웃</a><br>
	<a href="/mypage">마이페이지</a><br>
	</sec:authorize>
	
	<!-- 
    <script src = "../resources/js/layout.js"></script>
    
     -->
  </body>
</html>
