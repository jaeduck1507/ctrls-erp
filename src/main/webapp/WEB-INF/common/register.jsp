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
	<i class="fi fi-rr-user"></i>&nbsp;&nbsp;아이디
	<div class="emp-check">
		<input type="text" name="username" id="id" placeholder="아이디">
		<button type="button" id = "idCheck">중복확인</button>
	</div>
	
	<p id="resultId">영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내</p>
	</div>
	<div class="pwd-area">
	 <i class="fi fi-rr-lock"></i>&nbsp;&nbsp;비밀번호<input type="password" name="password" id="pw" placeholder="비밀번호">
	 <p id="resultPw">영문자, 숫자, 특수문자 조합으로 8~15자 이내</p>
	 </div>
	 <div class="pwd-area">
	 <i class="fi fi-rr-padlock-check"></i>&nbsp;&nbsp;비밀번호 확인<input type="password" id="pw2" placeholder=" 비밀번호 확인"/>
	 <p id="resultPw2">위 비밀번호와 동일하게</p>
	 </div>
	 <div class="no-area">
		<i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;사번
	<div class="emp-check">
	<input type="number" name="empNo" id ="empNo" placeholder="사번 입력">
	<button type="button" id = "noCheck">번호확인</button>
	</div>
	<span id="noCkeckMessage">사번 입력 후 번호 확인을 눌러주세요.</span>
	</div>
	
	<button type="submit" id="submit">회원가입</button>
	</div>
	</form>
	
	<script>
		let idValid = false;
		let idChecked = false;
		let pwValid = false;
		let pwMatch = false;
		let empNoChecked = false;
		
		// 아이디입력
		const id = document.querySelector("#id");
		const resultId = document.querySelector("#resultId");
		id.addEventListener("input", (e) => {
		  const idExp = /^[a-zA-Z][a-zA-Z0-9]{3,11}$/;
		  const iEt = idExp.test(e.target.value);
		  if (iEt) {
			$("#submit").prop("disabled", false);
		    resultId.innerHTML = "OK!";
		    resultId.style.color = "blue";
		  } else {
			$("#submit").prop("disabled", true);
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
			$("#submit").prop("disabled", false);
		    resultPw.innerHTML = "OK!";
		    resultPw.style.color = "blue";
		  } else {
			$("#submit").prop("disabled", true);
			resultPw.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
		    resultPw.style.color = "red";
		  }
		});
		//console.log(pw.addEventListener);
		// 비밀번호 확인
		const pw2 = document.querySelector("#pw2");
		const resultPw2 = document.querySelector("#resultPw2");
		pw2.addEventListener("input", (e) => {
		  const pwExp =
		    /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,15}$/;
		  // 앞에서 입력한 비밀번호와 현재 입력한 비밀번호가 일치할 때만 OK!=>value이용!
		  const pwOk = pw.value === pw2.value;
		  if (pwOk) {
		    resultPw2.innerHTML = "OK!";
		    resultPw2.style.color = "blue";
		  } else {
			resultPw.innerHTML = "위 비밀번호와 동일하게";
		    resultPw2.style.color = "red";
		  }
		});
	

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