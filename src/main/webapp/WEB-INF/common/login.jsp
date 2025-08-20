<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="../resources/css/login.css" />
</head>
<body>
	    <form action="login" method="post">
	      <div class="filter-bar" id="login-card">
	        <h1>로그인</h1>
	        <input type="text" name="username" placeholder="아이디" />
	        <input type="password" name="password" placeholder="비밀번호" />
	        <button type="submit">로그인</button>
			<div class="btn">
	        <button type="button" onclick="location.href='/findId'">
	          아이디 찾기
	        </button>
			<button type="button" onclick="location.href='/register'">
				          회원가입
				        </button>
						</div>
	      </div>
	    </form>
	  </body>
	</html>