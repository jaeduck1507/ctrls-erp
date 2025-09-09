<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error page</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/reset.css" />
<link rel="stylesheet" href="../resources/css/error.css" />
</head>
<body>

	<div class="errorBox">
		<h1 id="code">${statusCode}</h1>
		<h2>${errorMessage}</h2>
		<div>
			<button type="button" id="movePrev" class="btn">이전 페이지로</button>
			<button type="button" id="moveMain">메인화면으로</button>
		</div>
	</div>
	<div class="ground" id="ground1">
		<div class="rain front-row"></div>
		<div class="rain back-row"></div>
	</div>
	<div class="man">
		<div class="head"></div>
		<div class="body">
			<input type="checkbox" class="toggle" id="myCheck">
			<figure class="umbrella">
				<div class="canopy"></div>
				<div class="shaft"></div>
				<div class="hand"></div>
			</figure>
		</div>
		<div class="feet">
			<div class="foot"></div>
			<div class="foot"></div>
		</div>
	</div>

	<script src="../resources/js/common/error.js"></script>
</body>
</html>