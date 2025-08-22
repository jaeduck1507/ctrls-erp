<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>budgetRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
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
	<h5>[재무 관리] > [예산 등록]</h5>
	<h3>예산 등록</h3>
	<div id="register" class="filter-bar">
		<button id="add-row">열 추가</button>
		<table border="1" id="result" class="data-table">
			<tr>
				<th>부서 선택</th>
				<th>부서 번호</th>
				<th>연/분기/월</th>
				<th>예산 금액</th>
				<th>계획 상세</th>
				<th>예산 집행일</th>
				<th>삭제</th>
			</tr>
		</table>
		<button id="budget-register" disabled>예산 등록</button>
	</div>
	
	<script>
		var periodTypeCheckValue = false;
		var budgetAmountCheckValue = false;
		var executionDateCheckValue = false;
		
		const periodTypeCheck = /^[A-Z]$/;
		$(document).on("click", ".periodType", (e) => {
			console.log(e.target.value);
			console.log(periodTypeCheck.test(e.target.value));
			
			if (!periodTypeCheck.test(e.target.value)) {
				e.target.parentElement.classList.add("red");
				periodTypeCheckValue = false;
			} else {
				e.target.parentElement.classList.remove("red");
				periodTypeCheckValue = true;
			}
			checkAll();
		});
		
		const budgetAmountCheck = /^[1-9]\d*$/;
		$(document).on("input", ".budgetAmount", (e) => {
			console.log(e.target.value);
			console.log(budgetAmountCheck.test(e.target.value));
			
			if (!budgetAmountCheck.test(e.target.value)) {
				//alert("숫자만 입력!");
				e.target.parentElement.classList.add("red");
				budgetAmountCheckValue = false;
			} else {
				e.target.parentElement.classList.remove("red");
				budgetAmountCheckValue = true;
			}
			checkAll();
		});
		
		const executionDateCheck = /.+/;
		$(document).on("input", ".executionDate", (e) => {
			console.log(e.target.value);
			console.log(executionDateCheck.test(e.target.value));
			
			if (!executionDateCheck.test(e.target.value)) {
				e.target.parentElement.classList.add("red");
				executionDateCheckValue = false;
			} else {
				e.target.parentElement.classList.remove("red");
				executionDateCheckValue = true;
			}
			checkAll();
		});
		
		function checkAll() {
		    if (periodTypeCheckValue && budgetAmountCheckValue && executionDateCheckValue) {
		        $("#budget-register").prop("disabled", false);
		    } else {
		        $("#budget-register").prop("disabled", true);
		    }
		}
		
		var count = 0;
		
		function addRow() { // 열 추가 함수
			$("#result").append('<tr></tr>'); // 기본 열 추가
			for(var i = 0; i < 6; i++) { // 열에 데이터 추가
				if(i == 0) $("#result tr").eq(-1).append('<td><input list="List'+ (++count) +'" class="deptName" placeholder="부서 선택" /><datalist id="List'+ count + '"><c:forEach items="${department}" var="dept"><option value="${dept.deptName}" data-dept_no ="${dept.deptNo}" ></option></c:forEach></datalist></td>');
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
			$(e.target).parent().parent().find("td").eq(2).html('<select class="periodType"><option value="" disabled selected>연/분기/월</option><option value="Y">연(Y)</option><option value="Q">분기(Q)</option><option value="M">월(M)</option></select>');
			$(e.target).parent().parent().find("td").eq(3).html('<input type="number" min="0" name="budget-amount" class="budgetAmount">');
			$(e.target).parent().parent().find("td").eq(4).html('<input type="text" name="plan">');
			$(e.target).parent().parent().find("td").eq(5).html('<input type="date" name="execution-date" class="executionDate">');
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
				obj.executionDate=$("#result tr").eq(i).find("td").eq(5).find("input").val();
				
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
					if (response) {
						alert("등록되었습니다!");
						location.reload();
					}
				},
				error: function(xhr, status, error) {
					
				}
			});
		});
	</script>
</body>
</html>