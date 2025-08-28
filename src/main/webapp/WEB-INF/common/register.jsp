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
			<div class="no-area">
					<i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;사번
				<div class="row">
				<input type="number" name="empNo" id ="empNo" placeholder="사번 입력">
				<button type="button" id = "noCheck">사번확인</button>
				</div>
				<span id="noCkeckMessage">사번 입력 후 번호 확인을 눌러주세요.</span>
				</div>
			<div class="id-area">
	<i class="fi fi-rr-user"></i>&nbsp;&nbsp;아이디
	<div class="row">
		<input type="text" name="username" id="id" placeholder="아이디">
		<button type="button" id = "idCheck">중복확인</button>
	</div>
	
	<p id="resultId">영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내</p>
	</div>
	<div class="pwd-area">
	 <i class="fi fi-rr-lock"></i>&nbsp;&nbsp;비밀번호
	 <input type="password" name="password" id="pw" placeholder="비밀번호">
	 <p id="resultPw">영문자, 숫자, 특수문자 조합으로 8~15자 이내</p>
	 </div>
	 <div class="pwd-area">
	 <i class="fi fi-rr-padlock-check"></i>&nbsp;&nbsp;비밀번호 확인
	 <input type="password" id="pw2" placeholder="비밀번호 확인"/>
	 <p id="resultPw2">위 비밀번호와 동일하게</p>
	 </div>
	 <button type="submit" id="submit"><i class="fi fi-rr-user-add"></i>&nbsp;&nbsp;회원가입</button>
	 <div>
    <button type="reset" id="reset"><i class="fi fi-rr-eraser"></i>&nbsp;&nbsp;초기화</button>
	<button type="button" id="login"><i class="fi fi-rr-sign-in-alt"></i>&nbsp;&nbsp;로그인으로 돌아가기</button>
	</div>
	</div>
	</form>
	
	<script>
		let idValid = false;
		let idChecked = false;
		let pwValid = false;
		let pwMatch = false;
		let empNoChecked = false;
		
		// 모든 input 채웠는지 확인
		function checkAllValid() {
		   if (idValid && idChecked && pwValid && pwMatch && empNoChecked) {
		     $("#submit").prop("disabled", false);
		   } else {
		     $("#submit").prop("disabled", true);
		   }
		 }
		 // 아이디 생성 가능한 사번인지 확인
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
 						$("#noCkeckMessage").text("아이디 생성이 가능합니다.");
 						$("#noCkeckMessage").css("color","blue");
						empNoChecked = true;
 					} else {
 						$("#noCkeckMessage").text("아이디 생성이 불가능합니다.");
 						$("#noCkeckMessage").css("color","red");
						empNoChecked = false;
 					}
 					checkAllValid();
                 },
                 
 				error:function(xhr,status,error) {
 					
 				}
             });
         });
		 
		
		 
		// 아이디입력
		const id = document.querySelector("#id");
		const resultId = document.querySelector("#resultId");
		id.addEventListener("input", (e) => {
		  const idExp = /^[a-zA-Z][a-zA-Z0-9]{3,11}$/;
		  idValid = idExp.test(e.target.value);
		  idChecked = false; // 아이디 다시 입력하면 중복확인 다시 해야 함
		  if (idValid) {			
		    resultId.innerHTML = "OK! 중복확인을 해주세요.";
		    resultId.style.color = "blue";
		  } else {			
			resultId.innerHTML = "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내";
		    resultId.style.color = "red";
		  }
		  checkAllValid();
		});
		
		// 아이디 중복 확인 버튼
		  $("#idCheck").click(() => {
		    const username = $("#id").val();
		    if (!idValid) {
		      resultId.innerHTML = "아이디 형식이 올바르지 않습니다.";
		      resultId.style.color = "red";
		      return;
		    }
		    $.ajax({
		      type: "post",
		      url: "/idCheck",
		      data: { username: username },
		      success: function (result) {
		        if (result == 0) {
		          resultId.innerHTML = "사용 가능한 아이디입니다!";
		          resultId.style.color = "blue";
		          idChecked = true;
		        } else {
		          resultId.innerHTML = "이미 사용 중인 아이디입니다.";
		          resultId.style.color = "red";
		          idChecked = false;
		        }
		        checkAllValid();
		      },
		    });
		  });

		// 비밀번호 입력
		const pw = document.querySelector("#pw");
		const resultPw = document.querySelector("#resultPw");
		pw.addEventListener("input", (e) => {
		  const pwExp =
		    /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,15}$/;
		 pwValid = pwExp.test(e.target.value);	  
		  if (pwValid) {	
		    resultPw.innerHTML = "사용가능한 비밀번호입니다.";
		    resultPw.style.color = "blue";
		  } else {
			resultPw.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
		    resultPw.style.color = "red";
		  }
		  checkPwMatch();
		  checkAllValid();
		});
		//console.log(pw.addEventListener);

		// 비밀번호 확인
		const pw2 = document.querySelector("#pw2");
		const resultPw2 = document.querySelector("#resultPw2");
		pw2.addEventListener("input", () => {
			checkPwMatch();

		  checkAllValid();
		});
		function checkPwMatch() {
			pwMatch = pw.value === pw2.value && pw.value.length > 0;
			if (pwMatch) {
			  resultPw2.innerHTML = "비밀번호가 일치합니다.";
			  resultPw2.style.color = "blue";
			} else {
			  resultPw2.innerHTML = "위 비밀번호와 동일하게 입력";
			  resultPw2.style.color = "red";
			}
		}
		
		// reset 버튼 클릭 시 메시지 초기화
		$("#register").on("reset", function () {
		  // 사번 안내
		  $("#noCkeckMessage").text("사번 입력 후 번호 확인을 눌러주세요.").css("color", "");

		  // 아이디 안내
		  $("#resultId").text("영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내").css("color", "");

		  // 비밀번호 안내
		  $("#resultPw").text("영문자, 숫자, 특수문자 조합으로 8~15자 이내").css("color", "");

		  // 비밀번호 확인 안내
		  $("#resultPw2").text("위 비밀번호와 동일하게").css("color", "");

		  // 상태값 전부 false로 초기화
		  idValid = false;
		  idChecked = false;
		  pwValid = false;
		  pwMatch = false;
		  empNoChecked = false;
		  $("#submit").prop("disabled", true);
		});
		$("#submit").prop("disabled", true);
		// 로그인 페이지로 이동
		$("#login").click((e) => {
		  e.preventDefault(); // 기본 submit 막기
		  window.location.href = "/login"; // 로그인 페이지 경로에 맞게 수정
		});
	</script>
</body>
</html>