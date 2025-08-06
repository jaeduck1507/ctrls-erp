<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>회원가입</h1>
	<form action="/register" method="post" id="register">
	아이디 <input type="text" name="username"> <br>
	비밀번호 <input type="password" name="password"> <br>
	직원번호 <input type="number" name="empNo" id ="empNo">
	<button type="button" id = "noCheck">번호확인</button>
	<span id="noCkeckMessage"></span> <br> 
	<button type="submit">회원가입</button>
	</form>
	
	<script>
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