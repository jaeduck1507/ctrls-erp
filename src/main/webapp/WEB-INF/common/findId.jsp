<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/findid.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/3.0.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
</head>
<body>
	<div>
	<div class="logo-verde"><img src="/images/verde33.png" alt=" " style="height: 80px;"/></div>
	<div id="find-card">
	<div id="find" class="filter-bar" >
	  <h2>아이디 찾기</h2>
	  <input type="text" id="empNo" placeholder="사번을 입력하세요." />
	  <button id="btn"><i class="fi fi-rr-search"></i>&nbsp;&nbsp;조회</button>
	  <h3 id="result"></h3>
	</div>
	<div class="btn">
	  
	  <button id="btn1" onclick="location.href='/resetPwd'"><i class="fi fi-rr-pen-field"></i>&nbsp;&nbsp;비밀번호 재설정</button>
	  <button id="btn2" onclick="location.href='/login'"><i class="fi fi-rr-sign-in-alt"></i>&nbsp;&nbsp;로그인</button>
	</div>

	  </div>
	
	</div>
	
	<div id="container"></div>
	<script src="../resources/js/common/findid.js"></script>
</body>
</html>
