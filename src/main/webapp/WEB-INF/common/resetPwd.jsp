<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/3.0.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" href="../resources/css/resetPwd.css" />
</head>
<body>
	<div>
		<div class="logo-verde"><img src="/images/verde32big.png" alt=" " style="height: 80px;"/></div>
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
	        </div>
			
	      </div>
		  </div>
	 <script>
		let idValid = false;
		let idChecked = false;
		let pwValid = false;
		let pwMatch = false;
							
		// 모든 input 채웠는지 확인
		function checkAllValid() {
		   if (idValid && idChecked && pwValid && pwMatch) {
		     $("#resetPwd").prop("disabled", false);
		   } else {
		     $("#resetPwd").prop("disabled", true);
		   }
		 };
		 
		 // 아이디입력
		 		const id = document.querySelector("#username");
		 		const resultId = document.querySelector("#result");
		 		id.addEventListener("input", (e) => {
					const value = e.target.value; // 앞뒤 공백 제거
					idChecked = false; // 아이디 다시 입력하면 중복확인 다시 해야 함
		 		  if (value === "") {			
		 		    resultId.innerHTML = "필수 입력값입니다.";
		 		    resultId.style.color = "red";
					id.style.border = "solid red 1px"
					idValid = false;
		 		  } else {			
		 			resultId.innerHTML = "조회 버튼을 눌러주세요.";
		 		    resultId.style.color = "green";
					id.style.border = ""
					idValid = true;
		 		  }
				  
		 		  checkAllValid();
		 		});
		 
		 $("#idCheck").click(() => {
			  const formData = new FormData();
			  formData.append("username", $("#username").val());
			  $("#result").empty();
			  $.ajax({
			    type: "post",
			    url: "/idCheck",
			    data: formData,
			    processData: false,
			    contentType: false,
			    success: function (result) {
			      if (!result) {
			        $("#result").append("아이디가 존재하지 않습니다.").css("color", "red");
					$("#username").css("border", "red 1px solid");
					idChecked = false;
			      } else {
			        $("#result").append("아이디가 확인되었습니다. 새 비밀번호를 설정해주세요.").css("color", "blue");
					$("#username").css("border", "");
					idChecked = true;
					
			      }
				  checkAllValid();
			    },
			    error: function (xhr, status, error) {},
			  });
			});
			// 비밀번호 입력
			const pw = document.querySelector("#password");
			const resultPw = document.querySelector("#resultPw");
			pw.addEventListener("input", (e) => {
			  const pwExp =
			    /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,15}$/;
			 pwValid = pwExp.test(e.target.value);	  
			  if (pwValid) {	
			    resultPw.innerHTML = "사용가능한 비밀번호입니다.";
			    resultPw.style.color = "blue";
				pw.style.border = ""
			  } else {
				resultPw.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
			    resultPw.style.color = "red";
				pw.style.border = "red solid 1px"
			  }
			  checkPwMatch();
			  checkAllValid();
			});
			//console.log(pw.addEventListener);

			// 비밀번호 확인
			const pw2 = document.querySelector("#passwordCheck");
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
						pw2.style.border = ""
					  } else {
					    resultPw2.innerHTML = "위 비밀번호와 동일하게 입력해주세요.";
					    resultPw2.style.color = "red";
						pw2.style.border = "red solid 1px"
					  }			
				}
			
			$("#resetPwd").prop("disabled", true);
			
		 $("#resetPwd").click(() => {
			  const formData = new FormData();
			  formData.append("username", $("#username").val());
			  formData.append("password", $("#password").val());
			  $.ajax({
			    type: "post",
			    url: "/resetPwd",
			    data: formData,
			    processData: false,
			    contentType: false,
			    success: function (result) {
			    	Swal.fire({
						title: "비밀번호 재설정이 완료되었습니다!",
						confirmButtonText: '확인',
						width: 600,
						confirmButtonColor: "#90C67C",
						icon: "success",
						iconColor: "green"
						}).then((result) => {
							  if (result.isConfirmed) {
								  location.href='/login';	
								  }
							  if(result.dismiss == "backdrop") {
								  location.href='/login';	
							  }
								});
			    },
			    error: function (xhr, status, error) {
			    	alert("비밀번호 재설정 실패!");
			    	location.reload();
			    },
			  });
			});
			
			
			
	 </script>
</body>
</html>