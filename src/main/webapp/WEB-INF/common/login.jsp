<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>
	<h1>로그인</h1>
	<form action="login" method="post">
	아이디 <input type="text" name="username"> <br>
	비밀번호 <input type="password" name="password"> <br>
	<button type="submit">로그인</button>
	<button type="button" onclick="location.href='/findId'">아이디 찾기</button>
	</form>
</body>
</html>