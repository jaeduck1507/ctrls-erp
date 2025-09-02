<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 정보 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="../resources/css/modifypage.css"/>
</head>
<body>
	<h5>[근태 관리] > [휴가 조회] > [휴가 수정]</h5>
	<h3>휴가 수정</h3>
	<form action="/leaveUpdate" method="post" class="filter-bar">
		<div class="box">
			<table border="1" >
				<c:forEach items="${leaveInfoList}" var="item">
				<tr><th><i class="fi fi-rr-hastag"></i>&nbsp;&nbsp;신청번호</th><td>${item.leaveId}<input type="hidden" name="leaveId" value="${item.leaveId}"></td></tr>
				<tr><th><i class="fi fi-rr-calendar-pen"></i>&nbsp;&nbsp;신청날짜</th><td>${item.requestDate}<input type="hidden" name="requestDate" value="${item.requestDate}"></td></tr>
					<!--휴가 신청 시 유형이 고정되도록, 하지만 다시 선택할 수 있도록 ${item.leaveType eq '연차' ? 'selected' : ''} 추가-->
				<tr><th><i class="fi fi-rr-umbrella-beach"></i>&nbsp;&nbsp;유형</th><td><select name="leaveType"><option disabled selected>유형선택</option><option value="연차" ${item.leaveType eq '연차' ? 'selected' : ''}>연차</option><option value="병가" ${item.leaveType eq '병가' ? 'selected' : ''}>병가</option><option value="경조사" ${item.leaveType eq '경조사' ? 'selected' : ''}>경조사</option><option value="기타" ${item.leaveType eq '기타' ? 'selected' : ''}>기타</option></select></td></tr>
				<tr><th><i class="fi fi-rr-check-in-calendar"></i>&nbsp;&nbsp;시작일</th><td><input type="date" name="startDate" value="${item.startDate}" class="leaveDate"></td></tr>
				<tr><th><i class="fi fi-rr-check-out-calendar"></i>&nbsp;&nbsp;종료일</th><td><input type="date" name="endDate" value="${item.endDate}" class="leaveDate" id="endDate"></td></tr>
				<tr><th><i class="fi fi-rr-pen-field"></i>&nbsp;&nbsp;사유</th><td><input type="text" name="reason" value="${item.reason}" placeholder="사유 입력"></td></tr>
					<input type="hidden" name="leaveId" value="${item.empNo}">
					<input type="hidden" name="leaveId" value="${item.empName}">
					<input type="hidden" name="leaveId" value="${item.status}">
				</c:forEach>
		    </table>
		</div>
		
		<div id="btn" class="filter-bar">
			<button type="submit" id="update">수정</button>
			<button onclick="location.href='/hrm/leavePage'">취소</button>
		</div>
	</form>

<script src="../resources/js/hrm/leaveView.js"></script>
</body>
</html>