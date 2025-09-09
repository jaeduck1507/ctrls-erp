<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="../resources/css/login.css" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/3.0.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
</head>
<body>
	    <form action="login" method="post">
			<div class="logo-verde"><img src="/images/verde32big.png" alt=" " style="height: 80px;"/></div>
	      <div class="filter-bar" id="login-card">
	        <h1>로그인</h1>
	        <input type="text" name="username" placeholder="아이디" />
	        <input type="password" name="password" placeholder="비밀번호" />
	        <button type="submit"><i class="fi fi-rr-sign-in-alt"></i>&nbsp;&nbsp;로그인</button>
			<div class="btn">
	        <button type="button" onclick="location.href='/findId'">
	          <i class="fi fi-rr-search"></i>&nbsp;&nbsp;아이디 찾기
	        </button>
			<button type="button" onclick="location.href='/register'">
				          <i class="fi fi-rr-user-add"></i>&nbsp;&nbsp;회원가입
				        </button>
						</div>
	      </div>
	    </form>
<script src="../resources/js/common/login.js"></script>
</body>
</html>