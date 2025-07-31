<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사원 정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

	<h1>사원 정보 수정</h1>

<form action="/empModify" method="post">
    <label>
    직원 번호 : <input type="text" name="empNo" value="${empInfo.empNo}" readonly="readonly"></label><br>
    <label>성명 : <input type="text" name="empName" value="${empInfo.empName}"></label><br>
    <label>아이디 : <input type="text" name="empId" value="${empInfo.empId}"></label><br>
    <label>주민등록번호 : <input type="text" name="empIn" value="${empInfo.empIn}" readonly="readonly"></label><br>
    <label>직급 : <input type="text" name="jobTitle" value="${empInfo.jobTitle}" readonly="readonly"></label><br>
    <label>부서 : <input type="text" name="deptName" value="${empInfo.deptName}" readonly="readonly"></label><br>
    <label>입사일 : <input type="date" name="hireDate" value="${empInfo.hireDate}" readonly="readonly"></label><br>
    <label>퇴사일 : <input type="date" name="quitDate" value="${empInfo.quitDate}" readonly="readonly"></label><br>
    <label>주소 : <input type="text" name="addr" value="${empInfo.addr}"></label><br>
    <label>연락처 : <input type="text" name="phone" value="${empInfo.phone}"></label><br>
    <label>이메일 : <input type="text" name="email" value="${empInfo.email}"></label><br>
    <button type="submit">수정</button>
</form>


</body>
</html>
