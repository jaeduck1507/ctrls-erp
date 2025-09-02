<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="side">
      <div class="logo">
        <h1><a href="/">ctrl S</a></h1>
      </div>
	  <!-- 여기다가 각자 링크 작성하시면 됩니다! -->
      <div class="menu">
        <nav>
          <div class="menu-group">
            <div class="menu-title">인적 자원 관리</div>
            <div class="submenu">
              <a href="/hrm/empInfo">사원 정보 조회 /hrm/empInfo 페이징 처리 완료</a>
              <a href="/hrm/empAdd">사원 정보 추가 /hrm/empAdd</a>
              <a href="/hrm/quitShow">퇴사자 정보 조회 /hrm/quitShow 페이징 처리 완료</a>
              <a href="/hrm/empEval">인사/성과 평가 /hrm/empEval</a>
            </div>
          </div>
		  
		  <div class="menu-group">
              <div class="menu-title">근태 관리</div>
              <div class="submenu">
  			    <a href="/hrm/attendanceRecord">출근/퇴근 기록 /hrm/attendanceRecord</a>
  			    <a href="/hrm/showAttendance">출근/퇴근 조회 /hrm/attendanceRecord</a>
  			    <a href="/hrm/attendanceStats">출근/퇴근 통계 /hrm/attendanceStats</a>
			    <a href="/hrm/leaveAdd">휴가 신청 /hrm/leaveAdd</a>
			  	<a href="/hrm/leaveInfo">휴가 조회 /hrm/leaveInfo</a>
			  	<a href="/hrm/leaveDays">휴가일수 조회 /hrm/leaveDays</a>
			  	<a href="/hrm/leaveStatus">휴가 상태 처리 /hrm/leaveStatus 페이징 처리 완료</a>
			  </div>
            </div>

          <div class="menu-group">
            <div class="menu-title">재무 관리</div>
            <div class="submenu">
				<a href="/modalTest">**모달 테스트 /modalTest</a> <!-- 테스트용 -->
				<a href="/fm/budget">예산 조회 /fm/budget 페이징 처리 완료</a>
			    <a href="/fm/saleManage">매출 조회 /fm/saleManage 페이징 처리 완료</a>
			    <a href="/fm/purchase">매입 내역 조회 /fm/purchase 페이징 처리 완료</a>
			    <a href="/fm/purchaseRegister">매입 일괄 등록 /fm/purchaseRegister</a>
			    <a href="/fm/transaction">거래내역 조회 /fm/transaction 페이징 처리 완료</a>
				<a href="/fm/salary">급여 조회 /fm/salary 페이징 처리 완료</a>
				<a href="/fm/salaryPayment">급여 등록 /fm/salaryPayment</a>
				<a href="/fm/budgetRegister">예산 등록 /fm/budgetRegister</a>
				<a href="/fm/saleRegister">매출 등록 /fm/saleRegister</a>
				<a href="/fm/transRegister">거래내역 입력 /fm/transRegister</a>
				<a href="/fm/addBonusPayment">사원 보너스 입력 /fm/addBonusPayment</a>
				<a href="/fm/showBonusPayment">사원 보너스 조회 /fm/showBonusPayment 페이징 처리 완료</a>
            </div>
          </div>
		  
          <div class="menu-group">
            <div class="menu-title">품질 관리</div>
            <div class="submenu">
				<a href="/qam/brand">브랜드 조회 /qam/brand 페이징 처리 완료</a>
			    <a href="/qam/product">상품(Product) 조회 /qam/product 페이징 처리 완료</a>
			    <a href="/qam/productName">제품(ProductName) 조회/등록/수정/삭제 /qam/productName</a>
			    <a href="/qam/qc">제품 품질 검수 전체조회 /qam/qc 페이징 처리 필요</a>
				<a href="/qam/saleReady">판매 전 제품 조회 /qam/saleReady 페이징 처리 필요</a>
				<a href="/qam/saleDone">판매 완료 제품 조회 /qam/saleDone 페이징 처리 완료</a>
				<a href="/qam/defective">불량 제품 조회 /qam/defective 페이징 처리 필요</a>
            </div>
          </div>
		  
		  <!-- 로그인 및 로그아웃 버튼 위에다가 기능 작성해주세요 -->
		  
        </nav>
      </div>
    </div>