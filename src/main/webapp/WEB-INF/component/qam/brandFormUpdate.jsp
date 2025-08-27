<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>브랜드 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link rel="stylesheet" href="../resources/css/qamForm.css"/>
</head>

<body>
	<h5>[품질 관리] > [브랜드 조회] > [브랜드 수정]</h5>
	<h3>브랜드 수정</h3>

	<form id="brandFormUpdate" class="filter-bar">
		<div class="box">
			<table>
				<input type="hidden" name="brandCode" id="brandCode" value="${brand.brandCode}" />
				<tr>
					<th><i class="fi fi-rr-brand-badge"></i>&nbsp;&nbsp;브랜드명</th>
				   	<td><input type="text" name="brandName" id="brandName" value="${brand.brandName}"  /></td>
				</tr>
				<tr>
					<th><i class="fi fi-rr-phone-call"></i>&nbsp;&nbsp;전화번호</th>
				   	<td><input type="text" name="brandPhone" id="brandPhone" value="${brand.brandPhone}"  /></td>
				</tr>
				<tr>
					<th><i class="fi fi-rr-money-check-edit"></i>&nbsp;&nbsp;계좌번호</th>
				   	<td><input type="text" name="brandAccount" id="brandAccount" value="${brand.brandAccount}"  /></td>
				</tr>
				<tr>
					<th><i class="fi fi-rr-bank"></i>&nbsp;&nbsp;사용 은행</th>
				   	<td><input type="text" name="brandBank" id="brandBank" value="${brand.brandBank}"  /></td>
				</tr>
			</table>
		</div>
		
		<div>
			<button type="submit" class="btn" id="saveBtn">저장</button>
			<a href="/qam/brand" class="btn">목록으로</a>
		</div>
</form>

<script src="../resources/js/qam/brandFormUpdate.js"></script>

</body>
</html>
