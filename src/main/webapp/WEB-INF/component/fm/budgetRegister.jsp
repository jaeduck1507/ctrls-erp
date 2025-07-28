<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budgetRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>예산 등록</h1>
	<div id="register">
		<button id = "add-row">열 추가</button>
		<table border="1" id="result">
			<tr>
				<th>부서 선택</th>
				<th>부서 번호</th>
				<th>연/분기/월</th>
				<th>예산 금액</th>
				<th>계획 상세</th>
				<th>삭제</th>
			</tr>
			
			<tr>
				<td>
					<select id="deptName">
						<option value="dept" disabled selected>부서 선택</option>
						<c:forEach items="${department}" var="dept">
							<option value="${dept.deptName}">${dept.deptName}</option>
						</c:forEach>
					</select>
				</td>
				<td></td>
				<td>
					<select id="deptName">
						<option value="dept" disabled selected>연/분기/월</option>
						<option value="Y">연(Y)</option>
						<option value="Q">분기(Q)</option>
						<option value="M">월(M)</option>
					</select>
				</td>
				<td></td>
				<td>
					<input type="number" id="budget-amount">
				</td>
				<td>
					<input type="text" id="plan">
				</td>
				<td>
					<button>삭제</button>
				</td>
			</tr>
		</table>
		<button id="budget-register">예산 등록</button>
	</div>
	
	<script>
		var count = 0;
		/*	
		function addRow() { // 열 추가 함수
			$("#result").append('<tr></tr>'); // 기본 열 추가
			for(var i = 0; i < 5; i++) { // 열에 데이터 추가
				if(i == 0) $("#result tr").eq(-1).append('<td><input list="List'+ (++count) +'" class="deptName" placeholder="부서 선택" /><datalist id="List'+ count +'"><c:forEach items="${department}" var="dept"><option value="${dept.deptName}" data-dept_no ="${dept.deptNo}" ></option></c:forEach></datalist></td>');
				else $("#result tr").eq(-1).append('<td></td>');
			}
			$("#result tr").eq(-1).append('<td><button class="remove-row">열 삭제</button></td>'); // 열 삭제 버튼 추가
		}
		
		addRow();
		
		$("#add-row").click(() => { // 열 추가 버튼 클릭시 열 추가 함수 addRow 함수 실행
			addRow();
		});
		
		$(document).on("click", ".remove-row", function() { // 열 삭제 함수
			if($("#result tr").length > 2) $(this).parent().parent().remove();
		});
		*/
	</script>
</body>
</html>