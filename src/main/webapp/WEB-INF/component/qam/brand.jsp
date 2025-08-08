<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>브랜드 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>브랜드 조회</h2>

<a href="/brandForm">
    <button>브랜드 신규 등록</button>
</a>

<form id="searchBrand">
</form>

<table border="1" id="result">
	<tr>
		<th>브랜드코드</th>
		<th>브랜드명</th>
		<th>전화번호</th>
		<th>계좌번호</th>
		<th>사용 은행</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	
	<c:forEach items="${brandList}" var="b">
		<tr>
		    <td>${b.brandCode}</td>
		    <td>${b.brandName}</td>
		    <td>${b.brandPhone}</td>
		    <td>${b.brandAccount}</td>
		    <td>${b.brandBank}</td>
		    <td><a href='/brandFormUpdate?brandCode=${b.brandCode}'>수정</a></td>
		    <td><a href='/deleteBrand?productNo=${b.brandCode}'>삭제</a></td>
		</tr>
	</c:forEach>
</table>
</table>

<script>

</script>

</body>
</html>
