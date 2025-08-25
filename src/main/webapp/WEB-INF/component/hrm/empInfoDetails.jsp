<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사원 정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h5>[인적자원관리] > [사원정보조회] > [상세정보]</h5>
	<h3>사원 상세 정보</h3>

	<div class="container">
		<div class="box">
			<div class="box2">
				<h4>사원 정보</h4>
			    <p>직원 번호 : <b> ${empInfo.empNo}</b></p>
			    <p>성명 : <b>${empInfo.empName}</b></p>
			    <p>직급 : <b>${empInfo.jobTitle}</b></p>
			    <p>부서 : <b>${empInfo.deptName}</b></p>
			    <p>입사일 : <b>${empInfo.hireDate}</b></p>
			    <p>퇴사일 : <b id="quitDate">${empInfo.quitDate}</b></p>
			</div>
			
			<div class="box3">
				<h4>개인 정보</h4>
				<img src="D:/assets/${empInfo.url}" width="200" height="120" />
				<p><b>주민등록번호 : </b>${empInfo.empIn}</p>
			    <p><b>주소 : </b>${empInfo.addr}</p>
			    <p><b>연락처 : </b>${empInfo.phone}</p>
			    <p><b>이메일 : </b>${empInfo.email}</p>
			</div>
			
			<div class="filter-bar">
				<button type="button" class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#updateModal" id="quitBtn">퇴직 처리</button>
			</div>
			
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
				    <input type="hidden" name="empNo" value="${empInfo.empNo}" >
				    <input type="hidden" name="salary" value="${empInfo.salary}" >
				    <label>퇴사일 : <input type="date" name="quitDate" value="${empInfo.quitDate}" ></label><br>
			  </div>
		      <div class="modal-footer">
		      	<p>퇴사 처리시 변경 불가능 합니다</p>
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        <button type="submit" class="btn btn-warning">등록</button>
		      </div>
			  </form>
		    </div>
		  </div>
		</div>
	</div>
	

<script>
	const quitDate = document.querySelector("#quitDate");
	if(quitDate.textContent){
		$("#quitBtn").prop('disabled', true);
	} 
	
	
</script>
</body>
</html>
