<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="../resources/css/resetPwd.css" />
</head>
<body>
	      <div class="filter-bar" id="resetpwd-card">
	        <h1>비밀번호 재설정</h1>
	        <div id="id-area">
	        <input type="text" id="username" placeholder="아이디를 입력하세요." />
	  		<button class="btn" id="idCheck">조회</button>
	        </div>
			<p id="result"></p>
	        <div class="filter-bar" id="pwd-area">
	        <input type="password" name="password" id="password" placeholder="비밀번호" />
	        <input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호 확인" />
	        <button id="resetPwd">재설정</button>
	        </div>
			
	      </div>
	    
	 <script>
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
			        $("#result").append("아이디가 존재하지 않습니다.");
			      } else {
			        $("#result").append("아이디 체크 완료");
					
			      }
			    },
			    error: function (xhr, status, error) {},
			  });
			});
		 
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