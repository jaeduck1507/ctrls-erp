<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error page</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/reset.css" />
<style>

	* {
		font-family: "Pretendard", sans-serif;
	}	
	h1 {
		font-size: 200px;
  		font-weight: 900;
  		color: white;
  		text-shadow: 0px 0px 20px #90C67C;
  		margin-bottom: 20px;
	}
	h2 {
		font-size: 50px;
  		color: #90C67C;
  		margin-bottom: 20px;
	}
	.errorBox {
		width: 100%;
  		height: 90vh;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	
	button {
		color: white;
  background-color: #90c67c;
  padding: 6px 10px;
  border-radius: 4px;
  text-decoration: none;
  transition: background 0.2s;
  box-shadow: #33333362 0 5px 5px -5px;
  border: none;
	} 
	
	button:hover {
	background-color: #328e6e;
	}
</style>
</head>
<body>
	<div class="errorBox">
		<h1>${statusCode}</h1>
		<h2>${errorMessage}</h2>
		<div>
			<button type="button" id="movePrev">이전 페이지로</button>
			<button type="button" id="moveMain">메인화면으로</button>
		</div>
	</div>
	
	<script>
		$("#movePrev").click(() =>{
			history.back();
	    });
		$("#moveMain").click(() =>{
			location.href = "/";
	    });
	</script>
</body>
</html>