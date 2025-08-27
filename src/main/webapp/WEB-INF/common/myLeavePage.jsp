<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 조회 및 신청</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/myLeavePage.css"/>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">

</head>
<body>
	<h5>[마이페이지] > [휴가 조회 및 신청]</h5>
	<h3>휴가 조회 및 신청</h3>
	<div class="box">
		<!-- &nbsp; : span에서 띄어쓰기 적용-->
		<span><i class='fi fi-rr-umbrella-beach'></i>&nbsp;&nbsp;올해 받은 휴가일수&nbsp;&nbsp;<b>12일</b>&nbsp;&nbsp;</span>
		<span id="result1"></span>
	</div>
	
		<div class="box2">
		<h4>휴가 신청</h4>

	   <div class="filter-bar">
	      <input type="hidden" class="empNo" value="${user.empNo}">
		  휴가 신청일 <input type="date" id="currentDate" disabled>
		  휴가 유형 <select id="select">
				       <option disabled>유형선택</option>
					   <option value="연차" selected>연차</option>
					   <option value="병가">병가</option>
					   <option value="경조사">경조사</option>
					   <option value="기타">기타</option>
			      </select>	  
		  휴가 시작일 <input type="date" id="startDate" class="leaveDate">
		  휴가 종료일 <input type="date" id="endDate" class="leaveDate">
		  사유 <input type="text" id="reason" value="휴가" placeholder="사유 입력"/>
		  <button id="btn2">휴가 등록</button>
		  </div>

		  </div>
		  <div class="box2">
		  		<h4>휴가 신청 내역</h4>
		     <div class="filter-bar">
		  	  휴가 처리 상태 <select name="status" id="status">
		  	   			<option value="all">전체</option>
		  	   			<option value="wait">대기</option>
		  	   			<option value="approve">승인</option>
		  	   			<option value="back">반려</option>
		  	   		</select>
		  	 	<input type="hidden" id="empNoSearch" value="${user.empNo}">
		  		</div>
		  		
		   		<table border="1" id="result2" class="data-table"></table>
				<nav>
						<ul class="pagination">
						</ul>
					</nav>
		  		
		  		</div>

				
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
				<script src="../resources/js/common/myLeavePage.js"></script>
</body>
</html>