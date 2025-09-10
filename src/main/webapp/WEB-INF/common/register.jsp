<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/register.css" />
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/3.0.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
</head>
<body>
	
	<form action="/register" method="post" id="register">
		<div class="logo-verde"><img src="/images/verde33.png" alt=" " style="height: 80px;"/></div>
		<div class="filter-bar" id="register-card">
			<h1>회원가입</h1>
			<div class="no-area">
					<i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;사번
				<div class="row">
				<input type="number" name="empNo" id ="empNo" placeholder="사번 입력">
				<button type="button" id = "noCheck">사번확인</button>
				</div>
				<span id="noCkeckMessage">사번 입력 후 사번확인을 눌러주세요.</span>
				</div>
			<div class="id-area">
	<i class="fi fi-rr-user"></i>&nbsp;&nbsp;아이디
	<div class="row">
		<input type="text" name="username" id="id" placeholder="아이디">
		<button type="button" id = "idCheck">중복확인</button>
	</div>
	
	<p id="resultId">영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내</p>
	</div>
	<div class="pwd-area">
	 <i class="fi fi-rr-lock"></i>&nbsp;&nbsp;비밀번호
	 <input type="password" name="password" id="pw" placeholder="비밀번호">
	 <p id="resultPw">영문자, 숫자, 특수문자 조합으로 8~15자 이내</p>
	 </div>
	 <div class="pwd-area">
	 <i class="fi fi-rr-padlock-check"></i>&nbsp;&nbsp;비밀번호 확인
	 <input type="password" id="pw2" placeholder="비밀번호 확인"/>
	 <p id="resultPw2">위 비밀번호와 동일하게 입력</p>
	 </div>
	 <button type="submit" id="submit"><i class="fi fi-rr-user-add"></i>&nbsp;&nbsp;회원가입</button>
	 <div>
    <button type="reset" id="reset"><i class="fi fi-rr-eraser"></i>&nbsp;&nbsp;초기화</button>
	<button type="button" id="login"><i class="fi fi-rr-sign-in-alt"></i>&nbsp;&nbsp;로그인으로 돌아가기</button>
	</div>
	</div>
	</form>
	<div id="container"></div>
	<script src="../resources/js/common/register.js"></script>
</body>
</html>