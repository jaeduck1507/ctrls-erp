<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용 위한 태그 라이브러리 설정 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>브랜드 수정</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<h2>브랜드 수정</h2>

	<form action="/updateBrand" method="post">
	
		<input type="hidden" name="brandCode" value="${brand.brandCode}" />
	
		<label>브랜드명: 
		    <input type="text" name="brandName" value="${brand.brandName}" required />
		</label><br/>
		
		<label>전화번호: 
		    <input type="number" name="brandPhone" value="${brand.brandPhone}" required />
		</label><br/>
		
		<label>계좌번호: 
		    <input type="number" name="brandAccount" value="${brand.brandAccount}" required />
		</label><br/>
		
		<label>사용 은행: 
		    <input type="text" name="brandBank" value="${brand.brandBank}" required />
		</label><br/>
			
		<button type="submit">저장</button>
	</form>

<button><a href="/qam/brand">목록으로</a></button>

</body>
</html>
