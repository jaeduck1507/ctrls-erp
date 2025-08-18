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

	<h1>개인 정보 수정</h1>

<form action="modifyMyInfo" method="post" class="filter-bar">
	<div class="box">
		<div class="a">
		    <label>사번</label><input type="text" name="empNo" value="${user.empNo}" readonly="readonly"><br>
		    <label>성명</label><input type="text" id="empName" value="${user.empName}"><br>
			<p id="resultName">한글 2자 이상</p>
		    <label>주민등록번호</label><input type="text" name="empIn" value="${user.empIn}" readonly="readonly"><br>
		</div>
		<div class="b">
		    <label>직급</label><input type="text" name="jobTitle" value="${user.jobTitle}" readonly="readonly"><br>
		    <label>부서</label><input type="text" name="deptName" value="${user.deptName}" readonly="readonly"><br>
		</div>
		<div class="c">
		    <label>입사일</label><input type="date" name="hireDate" value="${user.hireDate}" readonly="readonly"><br>
		    <label>퇴사일</label><input type="date" name="quitDate" value="${user.quitDate}" readonly="readonly"><br>
		</div>
		<div class="d">
		    <label>주소</label><input type="text" name="addr" value="${user.addr}"><br>
			<p id="resultName">한글 2자 이상</p>
		    <label>연락처</label><input type="text" id="phone" value="${user.phone}"><br>
			<p id="resultTel">010-0000-0000 형식이어야 합니다.</p>
		    <label>이메일</label><input type="text" id="email" value="${user.email}"><br>
			<p id="resultEmail">@가 포함되어야 합니다.</p>
		</div>
   </div>
    <button type="submit">수정</button>
</form>
<script>
	// 이름 입력
	const name = document.querySelector("#empName");
	const resultIName = document.querySelector("#resultName");
	name.addEventListener("input", (e) => {
	  const nameExp = /^[가-힣]{2,}$/;
	  const nEt = nameExp.test(e.target.value);
	  if (nEt) {
	    resultName.innerHTML = "OK!";
	    resultName.style.color = "blue";
	  } else {
		resultName.innerHTML = "한글 2자 이상";
	    resultName.style.color = "red";
	  }
	});
	// 전화번호 입력
	const tel = document.querySelector("#phone");
	const resultTel = document.querySelector("#resultTel");
	tel.addEventListener("input", (e) => {
	  const telExp = /^010-\d{4}-\d{4}$/;
	  const tEt = telExp.test(e.target.value);
	  if (tEt) {
	    resultTel.innerHTML = "OK!";
	    resultTel.style.color = "blue";
	  } else {
		resultName.innerHTML = "010-0000-0000 형식이어야 합니다.";
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
	    resultEmail.innerHTML = "OK!";
	    resultEmail.style.color = "blue";
	  } else {
		resultName.innerHTML = "@가 포함되어야 합니다.";
	    resultEmail.style.color = "red";
	  }
	});
</script>
</body>
</html>
