<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>개인정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link rel="stylesheet" href="../resources/css/modifypage.css"/>
</head>
<body>

	<h5>[마이페이지] > [개인정보 수정]</h5>
		<h3>개인정보 수정</h3>

<form action="modifyMyInfo" method="post" class="filter-bar">
	<div class="box">
		<table>
			<tr>
			 <th><i class="fi fi-rr-picture"></i>&nbsp;&nbsp;사진</th><td><img src="/images/${user.url}" width="80" height="120" onerror="this.onerror=null; this.src='/images/default.jpg';"/><input type="hidden" value="${user.url}" id="url"></td>
			<tr>
			<tr>
		    <th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;&nbsp;&nbsp;사번</th><td><input type="text" name="empNo" value="${user.empNo}" readonly="readonly" id="empNo"></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-letter-case"></i>&nbsp;&nbsp;&nbsp;&nbsp;성명</th><td><input type="text" name="empName" id="empName" value="${user.empName}"></td>
			<td><p id="resultName">한글 두 글자 이상</p></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-hastag"></i>&nbsp;&nbsp;&nbsp;&nbsp;주민등록번호</th><td><input type="text" name="empIn" value="${user.empIn}" readonly="readonly"></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-sitemap"></i>&nbsp;&nbsp;&nbsp;&nbsp;직급</th><td><input type="text" name="jobTitle" value="${user.jobTitle}" readonly="readonly"></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-briefcase"></i>&nbsp;&nbsp;&nbsp;&nbsp;부서</th><td><input type="text" name="deptName" value="${user.deptName}" readonly="readonly"></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;&nbsp;&nbsp;입사일</th><td><input type="date" name="hireDate" value="${user.hireDate}" readonly="readonly"></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;&nbsp;&nbsp;퇴사일</th><td><input type="date" name="quitDate" value="${user.quitDate}" readonly="readonly"></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-home-location-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;주소</th><td><input type="text" name="addr" value="${user.addr}"></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-phone-call"></i>&nbsp;&nbsp;&nbsp;&nbsp;연락처</th><td><input type="text" name="phone" id="phone" value="${user.phone}"></td>
			<td><p id="resultTel">010-0000-0000 형식</p></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-envelope"></i>&nbsp;&nbsp;&nbsp;&nbsp;이메일</th><td><input type="text" name="email" id="email" value="${user.email}"></td>
			<td><p id="resultEmail">이메일 형식(@포함)</p></td>
			</tr>
			</table>
   </div>
   <div>
	<button onclick="location.href='/mypage'">취소</button>
    <button type="button"  data-bs-toggle="modal" data-bs-target="#updateImg">사진 변경/삭제</button>
    <button type="submit" id="submit">수정</button>
	</div>
	
	<div class="modal fade filter-bar" id="updateImg" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">사진 수정/삭제</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
			  
			  <div class="modal-body img-div">
					<img src="/images/${user.url}" width="80" height="120" style="border: #ccc solid 1px" onerror="this.onerror=null; this.src='/images/default.jpg';" />
					<div>
					<input type="file" class="file" id="file">
					<button type="button" class="btn" id ="deleteImg">사진 삭제</button>
					</div>
			  </div>
		      <div class="modal-footer">
		      	<p>사진 변경시 이전 사진은 확인 불가능합니다</p>
		        <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
		        
		        <button type="button" class="btn" id ="modifyImg">수정</button>
		      </div>
			  
		    </div>
		  </div>
		</div>
</form>
<script src="../resources/js/common/modifyMyInfo.js"></script>
</body>
</html>
