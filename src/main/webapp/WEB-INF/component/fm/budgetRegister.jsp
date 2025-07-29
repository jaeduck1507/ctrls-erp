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
				<th>예산 집행 날짜</th>
				<th>삭제</th>
			</tr>
		</table>
		<button id="budget-register">예산 등록</button>
	</div>
	
	<script>
		var count = 0;
		
		function addRow() { // 열 추가 함수
			$("#result").append('<tr></tr>'); // 기본 열 추가
			for(var i = 0; i < 6; i++) { // 열에 데이터 추가
				if(i == 0) $("#result tr").eq(-1).append('<td><input list="deptList'+ (++count) +'" class="deptName" placeholder="부서 선택" /><datalist id="deptList'+ count + '"><c:forEach items="${department}" var="dept"><option value="${dept.deptName}" data-dept_no ="${dept.deptNo}" ></option></c:forEach></datalist></td>');
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
		
		$(document).on("change", ".deptName", (e) => {
			const deptInfo = {};
			const val = $(e.target).val();
			console.log(val);
			const opt = $('#result tr').eq(1).find('td').eq(0).find('datalist').find('option').filter((a, o) => o.value === val);
			
			if (!opt.length) {
				alert("없는 부서입니다");
				return;
			}
			
			deptInfo.deptNo = opt.data('dept_no');
			$(e.target).parent().parent().find("td").eq(1).text(deptInfo.deptNo);
			$(e.target).parent().parent().find("td").eq(2).html('<select id="periodType"><option value="period" disabled selected>연/분기/월</option><option value="Y">연(Y)</option><option value="Q">분기(Q)</option><option value="M">월(M)</option></select>');
			$(e.target).parent().parent().find("td").eq(3).html('<input type="number" name="budget-amount">');
			$(e.target).parent().parent().find("td").eq(4).html('<input type="text" name="plan">');
			$(e.target).parent().parent().find("td").eq(5).html('<input type="date" name="purchase-date">');
		});
		
		$("#budget-register").click(() => {
			const table = $("#result tr");
			const bList = [];
			
			for (var i = 1; i < table.length; i++) {
				const obj ={};
				obj.deptNo=$("#result tr").eq(i).find("td").eq(1).text();
				obj.periodType=$("#result tr").eq(i).find("td").eq(2).find("select").val();
				obj.annualBudget=$("#result tr").eq(i).find("td").eq(3).find("input").val();
				obj.plan=$("#result tr").eq(i).find("td").eq(4).find("input").val();
				obj.createdAt=$("#result tr").eq(i).find("td").eq(5).find("input").val();
				
				bList.push(obj);
			}
			console.log(JSON.stringify(bList));
			
			$.ajax({
				type : "post",
				url: "/budgetRegister",
				dataType : "json",
				data : JSON.stringify(bList),
				processData: false,
				contentType: 'application/json; charset=UTF-8',
				success: function(response) {
					
				},
				error: function(xhr, status, error) {
					
				}
			});
		});
	</script>
</body>
</html>