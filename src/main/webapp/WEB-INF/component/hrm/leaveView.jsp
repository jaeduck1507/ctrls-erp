<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 정보 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<div class="container">
		<form action="/leaveUpdate" method="post">
			<h1>휴가 수정</h1>
		<table border="1">
				<tr>
					
				<th>신청번호</th>
				<th>신청날짜</th>
				<th>유형</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>이유</th>
				<th>사번</th>
				<th>신청자</th>
				<th>상태</th>
				</tr>
					
				<c:forEach items="${leaveInfoList}" var="item">
				<tr>
				    <td>${item.leaveId}<input type="hidden" name="leaveId" value="${item.leaveId}"></td>
					<td>${item.requestDate}<input type="hidden" name="leaveId" value="${item.requestDate}"></td>
					<td>${item.leaveType}</td>
					<td><input type="date" name="startDate" value="${item.startDate}"></td>
					<td><input type="date" name="endDate" value="${item.endDate}"></td>
					<td><input type="title" name="reason" value="${item.reason}"></td>
					<td>${item.empNo}<input type="hidden" name="leaveId" value="${item.empNo}"></td>
					<td>${item.empName}<input type="hidden" name="leaveId" value="${item.empName}"></td>
					<td>${item.status}<input type="hidden" name="leaveId" value="${item.status}"></td>
					
				</tr>
				</c:forEach>
		</table>
		<button type="submit" id="update">수정</button>
		</form>

</body>
</html>