<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사원 정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" href="../resources/css/modifyMyInfo.css"/>
</head>
<body>

	<h5>[마이페이지] > [개인정보수정]</h5>
		<h3>개인정보수정</h3>

<form action="modifyMyInfo" method="post" class="filter-bar">
	<div class="box">
		<table>
			<tr>
		    <th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;&nbsp;&nbsp;사번</th><td><input type="text" name="empNo" value="${user.empNo}" readonly="readonly"></td>
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
		    <th><i class="fi fi-rr-department"></i>&nbsp;&nbsp;&nbsp;&nbsp;부서</th><td><input type="text" name="deptName" value="${user.deptName}" readonly="readonly"></td>
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
    <button type="submit" id="submit">수정</button>
	</div>
</form>
<script>
	// 이름 입력
	const name = document.querySelector("#empName");
	const resultIName = document.querySelector("#resultName");
	name.addEventListener("input", (e) => {
	  const nameExp = /^[가-힣]{2,}$/;
	  const nEt = nameExp.test(e.target.value);
	  if (nEt) {
		$("#submit").prop("disabled", false);
	    resultName.innerHTML = "OK!";
	    resultName.style.color = "blue";
	  } else {
		$("#submit").prop("disabled", true);
		resultName.innerHTML = "한글 2자 이상";
	    resultName.style.color = "red";
	  }
	});
	// 전화번호 입력
	const tel = document.querySelector("#phone");
	const resultTel = document.querySelector("#resultTel");
	tel.addEventListener("input", (e) => {
	  const telExp = /^\d{3}-\d{3,4}-\d{4}$/;
	  const tEt = telExp.test(e.target.value);
	  if (tEt) {
		$("#submit").prop("disabled", false);
	    resultTel.innerHTML = "OK!";
	    resultTel.style.color = "blue";

	  } else {
		$("#submit").prop("disabled", true);
		resultTel.innerHTML = "010-0000-0000 형식";
	    resultTel.style.color = "red";

	  }
	});
	// 이메일 입력
	const email = document.querySelector("#email");
	const resultIEmail = document.querySelector("#resultEmail");
	email.addEventListener("input", (e) => {
	  const emailExp = /^[\w.-]+@[\w.-]+\.[A-Za-z]{2,}$/;
	  const eEt = emailExp.test(e.target.value);

	  if (eEt) {
		$("#submit").prop("disabled", false);
	    resultEmail.innerHTML = "OK!";
	    resultEmail.style.color = "blue";

	  } else {
		$("#submit").prop("disabled", true);
		resultEmail.innerHTML = "이메일 형식(@포함)";
	    resultEmail.style.color = "red";

	  }
	});
</script>
</body>
</html>
