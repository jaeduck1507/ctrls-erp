<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사원 정보 수정</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" href="../resources/css/empInfoDetail.css" />
</head>
<body>
	<h5>[인적자원관리] > [사원정보조회] > [사원상세정보]</h5>
	<h3>사원 상세 정보</h3>

		<div class="box">
			<div class="box2">
				<h4>사원 정보</h4>
				<table>
			    <tr><th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;사번</th><td><b>${empInfo.empNo}</b></td></tr>
			    <tr><th><i class="fi fi-rr-letter-case"></i>&nbsp;&nbsp;성명</th><td><b>${empInfo.empName}</b></td></tr>
			    <tr><th><i class="fi fi-rr-sitemap"></i>&nbsp;&nbsp;직급</th><td><b>${empInfo.jobTitle}</b></td></tr>
			    <tr><th><i class="fi fi-rr-briefcase"></i>&nbsp;&nbsp;&nbsp;&nbsp;부서</th><td><b>${empInfo.deptName}</b></td></tr>
			    <tr><th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;입사일</th><td><b>${empInfo.hireDate}</b></td></tr>
			    <tr><th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;퇴사일</th><td><b id="quitDate">${empInfo.quitDate}</b></td></tr>
				</table>
			</div>
			
			<div class="box2">
				<h4>개인 정보</h4>
				<table>
				<img src="/images/${empInfo.url}" width="200" height="120" onerror="this.onerror=null; this.src='/images/default.jpg';" />
				<tr><th><i class="fi fi-rr-hastag"></i>&nbsp;&nbsp;주민등록번호</th><td><b>${empInfo.empIn}</b></td></tr>
			    <tr><th><i class="fi fi-rr-home-location-alt"></i>&nbsp;&nbsp;주소</th><td><b>${empInfo.addr}</b></td></tr>
			    <tr><th><i class="fi fi-rr-phone-call"></i>&nbsp;&nbsp;연락처</th><td><b>${empInfo.phone}</b></td></tr>
			    <tr><th><i class="fi fi-rr-envelope"></i>&nbsp;&nbsp;이메일</th><td><b>${empInfo.email}</b></td></tr>
				</table>
			</div>
			</div>
			<div class="filter-bar">
				<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#updateModal" id="quitBtn">퇴직 처리</button>
				<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#evalShowModal" id="quitBtn">평가 조회</button>
			</div>
			
		
	
		<div class="modal fade filter-bar" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">퇴직 처리</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
			  <form action="/empQuit" method="post" enctype="multipart/form-data">
			  <div class="modal-body">
					<p>직원 번호 : <b> ${empInfo.empNo}</b></p>
				    <p>성명 : <b>${empInfo.empName}</b></p>
				    <p>직급 : <b>${empInfo.jobTitle}</b></p>
				    <p>부서 : <b>${empInfo.deptName}</b></p>
				    <p>입사일 : <b>${empInfo.hireDate}</b></p>
				    <input type="hidden" name="hireDate" value="${empInfo.hireDate}" >
				    <input type="hidden" name="empNo" value="${empInfo.empNo}" id="empNo">
				    <input type="hidden" name="salary" value="${empInfo.salary}" >
				    <label>퇴사일 : <input type="date" name="quitDate" value="${empInfo.quitDate}" ></label><br>
			  </div>
		      <div class="modal-footer">
		      	<p>퇴사 처리시 변경 불가능 합니다</p>
		        <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
		        <button type="submit" class="btn">등록</button>
		      </div>
			  </form>
		    </div>
		  </div>
		</div>
		
		<div class="modal fade filter-bar" id="evalShowModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">평가 조회</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div>
			  <div class="modal-body">
			 <select id="year" name="year">
		      <option value="0">년도 선택</option>
		      <option value="2023">2023년</option>
		      <option value="2024">2024년</option>
		      <option value="2025">2025년</option>
		    </select>
			  <div id="showEval"></div>
					
			  </div>
			  <div id="showCommentsPage">
			  </div>
			  </div>
		      <div class="modal-footer">
		      <p>퇴사 처리시 변경 불가능 합니다</p>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		      </div>
		    </div>
		  </div>
		  
		
	

<script src="../resources/js/hrm/empInfoDetails.js"></script>
</body>
</html>
