<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/register.css" />
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/3.0.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
</head>
<body>
	
	<form action="/register" method="post" id="register">
		<div class="filter-bar" id="register-card">
			<h1>회원가입</h1>
			<div class="id-area">
	<i class="fi fi-rr-user"></i>&nbsp;&nbsp;아이디<input type="text" name="username" id="id" placeholder="아이디">
	<p id="resultId">영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내</p>
	</div>
	<div class="pwd-area">
	<i class="fi fi-rr-lock"></i>&nbsp;&nbsp;비밀번호<input type="password" name="password" id="pw" placeholder="비밀번호">
	 <p id="resultPw">영문자, 숫자, 특수문자 조합으로 8~15자 이내</p>
	 </div>
	 <div class="no-area">
		<i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;사번
	<div class="emp-check">
	<input type="number" name="empNo" id ="empNo" placeholder="직원번호">
	<button type="button" id = "noCheck">번호확인</button>
	</div>
	<span id="noCkeckMessage">직원번호 입력 후 번호 확인을 눌러주세요.</span>
	</div>
	
	<button type="submit">회원가입</button>
	</div>
	</form>
	
	<script>
		// 아이디입력
		const id = document.querySelector("#id");
		const resultId = document.querySelector("#resultId");
		id.addEventListener("input", (e) => {
		  const idExp = /^[a-zA-Z][a-zA-Z0-9]{3,11}$/;
		  const iEt = idExp.test(e.target.value);
		  if (iEt) {
		    resultId.innerHTML = "OK!";
		    resultId.style.color = "blue";
		  } else {
			resultId.innerHTML = "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내";
		    resultId.style.color = "red";
		  }
		});

		// 비밀번호 입력
		const pw = document.querySelector("#pw");
		const resultPw = document.querySelector("#resultPw");
		pw.addEventListener("input", (e) => {
		  const pwExp =
		    /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,15}$/;
		  const pEt = pwExp.test(e.target.value);
		  if (pEt) {
		    resultPw.innerHTML = "OK!";
		    resultPw.style.color = "blue";
		  } else {
			resultPw.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
		    resultPw.style.color = "red";
		  }
		});
		console.log(pw.addEventListener);

		// 로그인 할때 수정할 부분입니당
		$("#noCheck").click(() =>{
        	const empNo = $("#empNo").val();
            $.ajax({
                // 요청
                type : "post",
                url : "/noCheck",
                data : "empNo=" + empNo,
                // 응답
                success : function(result) {
					if(result == 0) {
						$("#noCkeckMessage").text("아이디 생성 가능!");
						$("#noCkeckMessage").css("color","blue");
					} else {
						$("#noCkeckMessage").text("아이디 생성 불가능!");
						$("#noCkeckMessage").css("color","red");
					}
                },
                
				error:function(xhr,status,error) {
					
				}
            });
        });
		
	</script>
</body>
</html>