<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>마이 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/3.0.0/uicons-bold-rounded/css/uicons-bold-rounded.css'>
<link rel="stylesheet" href="../resources/css/mypage.css" />
</head>
<body>
	
	<!-- get, /mypage: 인증된 사람만 즉! 로그인된 사람만 -->
	<h3>마이페이지</h3>
	<div class="mypage">
		
		<div class="box1">
			<h4><i class="fi fi-br-smiley-comment-alt"  style="color:#67ae6e;"></i>&nbsp;&nbsp;${user.empName}님, 반갑습니다!</h4>
			<div id="date-timer" class="filter-bar">
				<p class="date" id="ymd"></p>
			    <p id="timer"></p>
			    <sec:authorize access="hasAnyRole('HRM','FM', 'QAM','MANAGEMENT','HEADQUARTER','SALE')">
					<button id="start_work">출근</button>
					<button id="finish_work">퇴근</button>
					<p id="status"><span id = "checkIn">00:00:00</span> ~ <span id="checkOut">00:00:00</span></p>
			    </sec:authorize>

			</div>
			
		</div>	
		<div class="box">
		<div class="box2">
			<h4>사원 정보</h4>
			<table>
				<tr>
		    <th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;&nbsp;&nbsp;사번</th><td><b> ${user.empNo}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-letter-case"></i>&nbsp;&nbsp;&nbsp;&nbsp;성명</th><td><b>${user.empName}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-sitemap"></i>&nbsp;&nbsp;&nbsp;&nbsp;직급</th><td><b>${user.jobTitle}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-briefcase"></i>&nbsp;&nbsp;&nbsp;&nbsp;부서</th><td><b>${user.deptName}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;&nbsp;&nbsp;입사일</th><td><b>${user.hireDate}</b></td>
			</tr>
			</table>
		</div>
		
		<div class="box2">
			<h4>개인 정보</h4>
		<table>
			 <tr>
			 <th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;사진</th><td><img src="/images/${user.url}" width="70" height="100" onerror="this.onerror=null; this.src='/images/default.jpg';"/></td>
			 <tr>
			<tr>
			<th><i class="fi fi-rr-hastag"></i>&nbsp;&nbsp;&nbsp;&nbsp;주민등록번호</th><td><b>${user.empIn}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-home-location-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;주소</th><td><b>${user.addr}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-phone-call"></i>&nbsp;&nbsp;&nbsp;&nbsp;연락처</th><td><b>${user.phone}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-envelope"></i>&nbsp;&nbsp;&nbsp;&nbsp;이메일</th><td><b>${user.email}</b></td>
			</tr>
		</table>
		</div>
		
	</div>
	
	<div class="filter-bar">
		<sec:authorize access="hasAnyRole('HRM','FM', 'QAM','MANAGEMENT','HEADQUARTER','SALE')">
			<button onclick="location.href='/modifyMyInfo'">개인정보 수정</button>
			<button onclick="location.href='/myLeavePage'">나의 휴가페이지</button>
			<button onclick="location.href='/myAttendance'">나의 출근 현황</button>
		</sec:authorize>
	<button onclick="location.href='/resetMyPwd'">비밀번호 재설정</button>
	</div>

	</div>
	<script src="../resources/js/common/mypage.js"></script>
</body>
</html>