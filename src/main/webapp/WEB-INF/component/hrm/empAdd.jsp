<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
  
.arrow_box {
	position: absolute;
	background: #b73434;
	border-radius: .4em;
	bottom: 0;
	width: 180px;
	height: 30px;
	top: 131%;
	color: white;
	z-index: 9999;
}

.arrow_box:after {
	content: '';
	position: absolute;
	top: 0;
	left: 50%;
	width: 0;
	height: 0;
	border: 20px solid transparent;
	border-bottom-color: #b73434;
	border-top: 0;
	border-left: 0;
	margin-left: -10px;
	margin-top: -20px;
	bottom: 0;
	z-index: 9999;
}
td {
	position: relative;
	box-sizing: border-box;

}

.red {
	border-color: red;
	border-width: 2px;

}

table {
  border-collapse: separate;  
}
</style>
</head>
<body>
	<h5>[인사 관리] > [사원 정보 추가]</h5>
	<h3>사원 정보 추가</h3>
    <div id = "test" class="filter-bar">
        <button id = "btn2">열 추가</button>
        <!-- <button id = "btn3">removeRowTest</button> -->
        <table border="1" id = "result" class="data-table">
            <tr>
                <th>사원명</th>
                <th>주민등록번호</th>
                <th>직급</th>
                <th>부서</th>
                <th>입사일</th>
                <th>급여</th>
                <th>주소</th>
                <th>연락처</th>
                <th>이메일</th>
                <th>사진</th>
                <th>삭제</th>

            </tr>
           
            
        </table>
        <button id = "btn">사원 등록</button>
        
    </div>
	
    <script src="../resources/js/hrm/empAdd.js"></script>
</body>
</html>