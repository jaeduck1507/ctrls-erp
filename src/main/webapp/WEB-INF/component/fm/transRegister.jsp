<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>transRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>거래내역 입력</h1>
	<div id="register">
		<button id="add-row">열 추가</button>
		<table border="1" id="result">
			<tr>
				<th>부서 선택</th>
				<th>부서 코드</th>
				<th>수입/지출</th>
				<th>금액</th>
				<th>분류</th>
				<th>상세내역</th>
				<th>발생일자</th>
				<th>삭제</th>
			</tr>
			
			<tr>
				<td></td>
				<td></td>
				<td>
					<select id="transType">
						<option value="" disabled selected>선택</option>
						<option value="수입">수입</option>
						<option value="지출">지출</option>
					</select>
				</td>
				<td>
					<input type="number" name="trans-amount"/>
				</td>
				<td></td>
				<td></td>
				<td>
					<input type="date" name="trans-date"/>
				</td>
				<td></td>
			</tr>
		</table>
		<button id="trans-register">등록</button>
	</div>
	
	<script>
		
	</script>
</body>
</html>