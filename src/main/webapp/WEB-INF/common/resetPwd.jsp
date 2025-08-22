<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	      <div class="filter-bar">
	        <h1>비밀번호 재설정</h1>
	        <div>
	        <input type="text" id="username" placeholder="아이디를 입력하세요." />
	  		<button class="btn" id="idCheck">조회</button>
	  		<p id="result"></p>
	        </div>
	        <div>
	        <input type="password" name="password" id="password" placeholder="비밀번호" />
	        <input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호 확인" />
	        <button type="submit">재설정</button>
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
	 </script>
</body>
</html>