<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="../resources/css/findid.css" />
</head>
<body>
	<div id="find-card">
	<div id="find" class="filter-bar" >
	  <h2>아이디 찾기</h2>
	  <input type="text" id="empNo" placeholder="사번을 입력하세요." />
	  <button id="btn">조회</button>
	</div>
	<div class="data-table">
	  <table id="result"></table>
	</div>

	  </div>
	</form>
	</div>
	<script src="../resources/js/findid.js"></script>
</body>
</html>
