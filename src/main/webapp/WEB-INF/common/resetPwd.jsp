<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/3.0.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" href="../resources/css/resetPwd.css" />
</head>
<body>
	<div>
		<a href="/"><div class="logo-verde"><img src="/images/verde33.png" alt=" " style="height: 80px;"/></div></a>
	      <div class="filter-bar" id="register-card">
			
	        <h1>비밀번호 재설정</h1>
			
			<div class="id-area">
			 <i class="fi fi-rr-user"></i>&nbsp;&nbsp;아이디
		        <div class="row">
		         <input type="text" id="username" placeholder="아이디를 입력하세요." />
		  		 <button type="button" class="btn" id="idCheck">조회</button>
				   
			 </div>
			 <p id="result"></p>
			</div>
			
	        <div class="pwd-area" id="pwd-area">
				<i class="fi fi-rr-lock"></i>&nbsp;&nbsp;비밀번호	
	        <input type="password" name="password" id="password" placeholder="비밀번호" />
			<p id="resultPw">영문자, 숫자, 특수문자 조합으로 8~15자 이내</p>	
		</div>
			
			<div class="pwd-area" id="pwd-area">
				<i class="fi fi-rr-padlock-check"></i>&nbsp;&nbsp;비밀번호 확인
			<input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호 확인" />
			<p id="resultPw2">위 비밀번호와 동일하게 입력해주세요.</p>	
		   </div>
			
			<button id="resetPwd">재설정</button>
			<button id="btn2" onclick="location.href='/login'"><i class="fi fi-rr-sign-in-alt"></i>&nbsp;&nbsp;로그인으로 돌아가기</button>
	        </div>
			
	      </div>
	      <div id="container"></div>
<script src="../resources/js/common/resetPwd.js"></script>
</body>
</html>