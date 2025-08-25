<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<form action="resetMyPwd" method="post">
	      <div class="filter-bar">
	        <h1>비밀번호 재설정</h1>
	        <input type="password" name="password" id="password" placeholder="비밀번호" />
	        <input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호 확인" />
	        <button class="btn" id="btn">재설정</button>
			
	      </div>
	    </form>
<script>
$("#btn").click(() => {
	  const formData = new FormData();
	  formData.append("password", $("#password").val());
	  location.href='/mypage';	 
	});
</script>
</body>
</html>