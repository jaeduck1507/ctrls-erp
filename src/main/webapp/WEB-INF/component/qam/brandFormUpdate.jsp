<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>브랜드 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<link rel="stylesheet" href="../resources/css/qamForm.css"/>
</head>

<body>
	<h5>[품질 관리] > [브랜드 조회] > [브랜드 수정]</h5>
	<h3>브랜드 수정</h3>

	<form action="/updateBrand" method="post" class="filter-bar">
		<div class="box">
			<table>
				<input type="hidden" name="brandCode" value="${brand.brandCode}" />
				<tr>
					<th>브랜드명</th>
				   	<td><input type="text" name="brandName" value="${brand.brandName}" required /></td>
				</tr>
				<tr>
					<th>전화번호</th>
				   	<td><input type="text" name="brandPhone" value="${brand.brandPhone}" required /></td>
				</tr>
				<tr>
					<th>계좌번호</th>
				   	<td><input type="text" name="brandAccount" value="${brand.brandAccount}" required /></td>
				</tr>
				<tr>
					<th>사용 은행</th>
				   	<td><input type="text" name="brandBank" value="${brand.brandBank}" required /></td>
				</tr>
			</table>
		</div>
		
		<div>
			<button type="submit" class="btn">저장</button>
			<a href="/qam/brand" class="btn">목록으로</a>
		</div>
</form>

</body>
</html>
