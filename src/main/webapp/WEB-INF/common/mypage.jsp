<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
	<!-- get, /mypage: 인증된 사람만 즉! 로그인된 사람만 -->
	<h1>마이페이지</h1>
	<div>
	날짜 : <input type="date" id="workDate">
	출근 : <input type="time" id = "checkIn">
	퇴근 : <input type="time" id = "checkOut">
	<button id="start_work">출근</button>
	<button id="finish_work">퇴근</button>
	</div>
	<p>${user.empName}</p>
	<div>
		
	</div>
	<a href="/logout">로그아웃</a>
</body>
</html>