<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>브랜드 등록</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>브랜드 등록</h2>

	<form action="/registerBrand" method="post">
	
		<label>브랜드명: 
		    <input type="text" name="brandName" required />
		</label><br/>
		
		<label>전화번호: 
		    <input type="number" name="brandPhone" required />
		</label><br/>
		
		<label>계좌번호: 
		    <input type="number" name="brandAccount" required />
		</label><br/>
		
		<label>사용 은행: 
		    <input type="text" name="brandBank" required />
		</label><br/>
			
		<button type="submit">저장</button>
	</form>

<button><a href="/qam/brand">목록으로</a></button>

</body>
</html>
