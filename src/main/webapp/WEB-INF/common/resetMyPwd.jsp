<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="../resources/css/modifypage.css"/>
</head>
<body>
	<h5>[마이페이지] > [비밀번호 재설정]</h5>
			<h3>비밀번호 재설정</h3>

	      <div class="filter-bar box">
	        <table>
	        <tr>
				<th><i class="fi fi-rr-lock"></i>&nbsp;&nbsp;새로운 비밀번호</th>
				  <td><input type="password" name="password" id="password" placeholder="새 비밀번호 입력" /></td>
			      <td><p class="resultPw">영문자, 숫자, 특수문자 조합으로 8~15자 이내</p></td>
			</tr>
			<tr>
				<th><i class="fi fi-rr-padlock-check"></i>&nbsp;&nbsp;비밀번호 확인</th>
				   <td><input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호 확인" /></td>
			       <td><p class="resultPw2">위 비밀번호와 동일하게 입력</p></td>
			</tr>
			</table>
			</div>
			<div class="filter-bar">
	        <button class="btn" id="btn">재설정</button>
			</div>
      
<script>
	let pwValid = false;
	let pwMatch = false;
	function checkAllValid() {
			   if (pwValid && pwMatch) {
			     $("#btn").prop("disabled", false);
			   } else {
			     $("#btn").prop("disabled", true);
			   }
			 }
	    // 비밀번호 입력
		const pw = document.querySelector("#password");
		const resultPw = document.querySelector(".resultPw");
		pw.addEventListener("input", (e) => {
		  const pwExp =
		    /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,15}$/;
		 pwValid = pwExp.test(e.target.value);	  
		  if (pwValid) {	
		    resultPw.innerHTML = "사용가능한 비밀번호입니다.";
		    resultPw.style.color = "blue";
			pw.style.border = "";
		  } else {
			resultPw.innerHTML = "영문자, 숫자, 특수문자 조합 8~15자 이내";
		    resultPw.style.color = "red";
			pw.style.border = "red solid 1px";
		  }
		  checkPwMatch();
		  checkAllValid();
		});
		//console.log(pw.addEventListener);

		// 비밀번호 확인
		const pw2 = document.querySelector("#passwordCheck");
		const resultPw2 = document.querySelector(".resultPw2");
		pw2.addEventListener("input", () => {
		  checkPwMatch();
		  checkAllValid();
		});
			
		function checkPwMatch(){
			pwMatch = pw.value === pw2.value && pw.value.length > 0;
						  if (pwMatch) {
						    resultPw2.innerHTML = "비밀번호가 일치합니다.";
						    resultPw2.style.color = "blue";
							pw2.style.border = "";
						  } else {
						    resultPw2.innerHTML = "위 비밀번호와 동일하게 입력";
						    resultPw2.style.color = "red";
							pw2.style.border = "red solid 1px";
						  }
		}
			
$("#btn").click(() => {
	  Swal.fire({
			title: "변경하시겠습니까?",
			confirmButtonText: '등록',
			confirmButtonColor: "green",
			icon: "question",
			iconColor: "green",
			showCancelButton: true,
			cancelButtonText: '취소',
			cancelButtonColor: "red"
			}).then((result) => {
				  if (result.isConfirmed) {
					  	
					    const obj = {};
					    obj.password = $("#password").val();
					    $.ajax({
					        // 요청
					        type : "post",
					        url : "/resetMyPwd",
					        dataType : "json", 
					        data : JSON.stringify(obj),
							processData: false,
							contentType: 'application/json; charset=UTF-8',
							
					        // 응답
					        success : function(result) {
					        	let timerInterval;
								Swal.fire({
									icon: "success",
									iconColor: "green",
								  title: "비밀번호 재설정이 완료되었습니다!",
								  html: '<span id="aa"></span>초 후 자동으로 닫힙니다.',
								  timer: 2000,
								  timerProgressBar: true,
								  didOpen: () => {
								    Swal.showLoading();
								    const timer = Swal.getPopup().querySelector("#aa");
								    timerInterval = setInterval(() => {
										let remainSecond = parseInt(Swal.getTimerLeft() / 1000) ;
								      timer.textContent = remainSecond +1;
								    }, 100);
								  },
								  willClose: () => {
								    clearInterval(timerInterval);
								  }
								}).then((result) => {
								  /* Read more about handling dismissals below */
								  if(result.dismiss == "backdrop") {
									  location.href='/mypage';
								  }
								  if (result.dismiss === Swal.DismissReason.timer) {
									  location.href='/mypage';
								  }
								});
					        },
					        
							error:function(xhr,status,error) {
								
							}
					    });
					 
					  }
					});
	});
	$("#btn").prop("disabled", true);
</script>
</body>
</html>