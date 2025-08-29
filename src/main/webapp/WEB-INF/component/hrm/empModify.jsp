<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사원 정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link rel="stylesheet" href="../resources/css/modifypage.css"/>
</head>
<body>
	<h5>[인적자원관리] > [사원정보조회] > [사원정보수정]</h5>
		<h3>사원정보수정</h3>




	<div class="box filter-bar">
	<table>
    <tr><th><i class="fi fi-rr-picture"></i>&nbsp;&nbsp;사진<th><td><img src="/images/${empInfo.url}" width="100" height="150" onerror="this.onerror=null; this.src='/images/default.jpg';" /><input type="hidden" value="${empInfo.url}" id="url"></td><tr>
    <tr><th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;사번<th><td><input type="text" name="empNo" value="${empInfo.empNo}" readonly="readonly" id="empNo"></td><tr>
    <tr><th><i class="fi fi-rr-letter-case"></i>&nbsp;&nbsp;성명<th><td><input type="text" name="empName" value="${empInfo.empName}" id ="empName"></label><br>
    <tr><th><i class="fi fi-rr-hastag"></i>&nbsp;&nbsp;주민등록번호<th><td><input type="text" name="empIn" value="${empInfo.empIn}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-sitemap"></i>&nbsp;&nbsp;직급<th><td><input type="text" name="jobTitle" value="${empInfo.jobTitle}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-briefcase"></i>&nbsp;&nbsp;부서<th><td><input type="text" name="deptName" value="${empInfo.deptName}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-usd-circle"></i>&nbsp;&nbsp;급여<th><td><input type="text" name="salary" value="${empInfo.salary}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;입사일<th><td><input type="date" name="hireDate" value="${empInfo.hireDate}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;퇴사일<th><td><input type="date" name="quitDate" value="${empInfo.quitDate}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-home-location-alt"></i>&nbsp;&nbsp;주소<th><td><input type="text" name="addr" value="${empInfo.addr}" id="addr"></td><tr>
    <tr><th><i class="fi fi-rr-phone-call"></i>&nbsp;&nbsp;연락처<th><td><input type="text" name="phone" value="${empInfo.phone}" id="phone"></td><tr>
    <tr><th><i class="fi fi-rr-envelope"></i>&nbsp;&nbsp;이메일<th><td><input type="text" name="email" value="${empInfo.email}" id="email"></td><tr>
	</table>
	</div>
	<div class="filter-bar">
    <button type="button" id="empModifyBtn">수정</button>
	<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#updateModal" id="quitBtn">직급/부서 변경</button>
	<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#updateSalary">급여 변경</button>
	<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#updateImg">사진 변경/삭제</button>
	</div>

		<div class="modal fade filter-bar" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">직급/부서 변경</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
			  
			  <div class="modal-body">
					<select id="job">
					<option value="-1" disabled selected>직무 선택</option>
					<c:forEach items="${jobPosition}" var="job">
					<option value="${job.jobNo}">${job.jobTitle}</option>
					</c:forEach>
					</select>
					<select id="dept">
					<option value="-1" disabled selected>부서 선택</option>
					<c:forEach items="${department}" var="dept">
					<option value="${dept.deptNo}">${dept.deptName}</option>
					</c:forEach>
					</select>
			  </div>
		      <div class="modal-footer">
		        <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
		        <button type="button" class="btn" id ="modifyJobDept">등록</button>
		      </div>
			  
		    </div>
		  </div>
		</div>
		
		<div class="modal fade filter-bar" id="updateSalary" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">급여 변경</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
			  
			  <div class="modal-body">
					<i class="fi fi-rr-department"></i>&nbsp;&nbsp;급여<th><td><input type="text" name="salary" value="${empInfo.salary}" id="salary">
			  </div>
		      <div class="modal-footer">
		      	<p>급여 변경시 이전 급여는 확인 불가능 합니다</p>
		        <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
		        <button type="button" class="btn" id ="modifySalary">등록</button>
		      </div>
			  
		    </div>
		  </div>
		</div>
		
		<div class="modal fade filter-bar" id="updateImg" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">사진 수정/삭제</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
			  
			  <div class="modal-body">
					<img src="/images/${empInfo.url}" width="200" height="120" onerror="this.onerror=null; this.src='/images/default.jpg';" />
					<input type="file" class="file" id="file">
					<button type="button" class="btn" id ="deleteImg">삭제</button>
			  </div>
		      <div class="modal-footer">
		      	<p>사진 변경시 이전 사진은 확인 불가능합니다</p>
		        <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
		        
		        <button type="button" class="btn" id ="modifyImg">수정</button>
		      </div>
			  
		    </div>
		  </div>
		</div>


<script src="../resources/js/hrm/empModify.js"></script>
</body>

</html>
