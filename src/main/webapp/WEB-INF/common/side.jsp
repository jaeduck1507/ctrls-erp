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
	        <sec:authorize access="hasAnyRole('HRM','ADMIN','MANAGEMENT')">
	          <div class="menu-group">
	            <div class="menu-title">인사 관리</div>
	            <div class="submenu">
	              <a href="/hrm/empInfo">사원 정보 조회</a>
	              <a href="/hrm/empAdd">사원 정보 추가</a>
	              <a href="/hrm/quitShow">퇴사자 정보 조회</a>
	              <a href="/hrm/empEval">인사/성과 평가</a>
	            </div>
	          </div>
	        </sec:authorize>
		  
		  	<sec:authorize access="hasAnyRole('HRM','ADMIN','MANAGEMENT')">
			    <div class="menu-group">
	              <div class="menu-title">근태 관리</div>
	              <div class="submenu">
	  			    <a href="/hrm/showAttendance">출근/퇴근 조회</a>
	  			    <a href="/hrm/attendanceStats">출근/퇴근 통계</a>
	  			    <a href="/hrm/attendanceRecord">출근/퇴근 기록 수정</a>
				    <a href="/hrm/leaveAdd">휴가 신청</a>
				  	<a href="/hrm/leaveInfo">휴가 조회</a>
				  	<a href="/hrm/leaveDays">휴가일수 조회</a>
				  	<a href="/hrm/leaveStatus">휴가 상태 처리</a>
				  </div>
	            </div>
		  	</sec:authorize>
			
			<sec:authorize access="hasAnyRole('HRM','ADMIN','MANAGEMENT','FM')">
				<div class="menu-group">
		            <div class="menu-title">급여 관리</div>
		            <div class="submenu">
		            	<sec:authorize access="hasAnyRole('ADMIN','MANAGEMENT','FM')">
							<a href="/fm/salary">급여 조회</a>
							<a href="/fm/salaryPayment">급여 등록</a>
		            	</sec:authorize>
		            	<sec:authorize access="hasAnyRole('ADMIN','MANAGEMENT','FM','HRM')">
							<a href="/fm/showBonusPayment">사원 보너스 조회</a>
							<a href="/fm/addBonusPayment">사원 보너스 입력</a>
		            	</sec:authorize>
		            </div>
				</div>
			</sec:authorize>

			<sec:authorize access="hasAnyRole('HRM','ADMIN','MANAGEMENT','FM')">
				<div class="menu-group">
		            <div class="menu-title">재무 관리</div>
		            <div class="submenu">
		            	<sec:authorize access="hasAnyRole('ADMIN','MANAGEMENT','FM')">
							<a href="/fm/budget">예산 조회</a>
							<a href="/fm/budgetRegister">예산 등록</a>
						    <a href="/fm/saleManage">매출 조회</a>
							<a href="/fm/saleRegister">매출 등록</a>
						    <a href="/fm/purchase">매입 내역 조회</a>
						    <a href="/fm/purchaseRegister">매입 일괄 등록</a>
						    <a href="/fm/transaction">거래내역 조회</a>
							<a href="/fm/transRegister">거래내역 입력</a>
		            	</sec:authorize>
		            </div>
				</div>
			</sec:authorize>
		  
			<sec:authorize access="hasAnyRole('HRM','ADMIN','MANAGEMENT','HEADQUARTER','SALE')">
	          <div class="menu-group">
	            <div class="menu-title">제품 관리</div>
	            <div class="submenu">
					<a href="/qam/brand">브랜드 조회</a>
				    <a href="/qam/product">상품 조회</a>
				    <a href="/qam/productName">제품 조회</a>
					<a href="/qam/saleReady">판매 대기 제품 조회</a>
					<a href="/qam/saleDone">판매 완료 제품 조회</a>
	            </div>
	          </div>
			</sec:authorize>
			<sec:authorize access="hasAnyRole('HRM','ADMIN','MANAGEMENT','HEADQUARTER')">
	          <div class="menu-group">
	            <div class="menu-title">품질 관리</div>
	            <div class="submenu">
				    <a href="/qam/qc">품질 검수 조회</a>
				    <a href="/qam/defective">불량 제품 조회</a>
	            </div>
	          </div>
			</sec:authorize>
		  
		  <!-- 로그인 및 로그아웃 버튼 위에다가 기능 작성해주세요 -->
		  
        </nav>
      </div>
    </div>