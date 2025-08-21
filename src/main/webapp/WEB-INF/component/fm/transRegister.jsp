<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>transRegister</title>
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
	<h5>[재무 관리] > [기타 지출 내역 입력]</h5>
	<h3>기타 지출 내역 입력</h3>
	<div id="register" class="filter-bar">
		<button id="add-row">열 추가</button>
		<table border="1" id="result" class="data-table">
			<tr>
				<th>부서 선택</th>
				<th>부서 코드</th>
				<th>수입/지출</th>
				<th>분류</th>
				<th>금액</th>
				<th>상세내역</th>
				<th>발생일자</th>
				<th>삭제</th>
			</tr>
		</table>
		<button id="trans-register" disabled>등록</button>
	</div>
	
	<script>
		var transAmountCheckValue = false;
		var transDateCheckValue = false;
		
		const transAmountCheck = /^[1-9]\d*$/;
		$(document).on("input", "#transAmount", (e) => {
			console.log(e.target.value);
			console.log(transAmountCheck.test(e.target.value));
			
			if (!transAmountCheck.test(e.target.value)) {
				//alert("숫자만 입력!");
				e.target.parentElement.classList.add("red");
				transAmountCheckValue = false;
			} else {
				e.target.parentElement.classList.remove("red");
				transAmountCheckValue = true;
			}
			checkAll();
		});
		
		const transDateCheck = /.+/;
		$(document).on("input", "#transDate", (e) => {
			console.log(e.target.value);
			console.log(transDateCheck.test(e.target.value));
			
			if (!transDateCheck.test(e.target.value)) {
				e.target.parentElement.classList.add("red");
				transDateCheckValue = false;
			} else {
				e.target.parentElement.classList.remove("red");
				transDateCheckValue = true;
			}
			checkAll();
		});
		
		function checkAll() {
		    if (transAmountCheckValue && transDateCheckValue) {
		        $("#trans-register").prop("disabled", false);
		    } else {
		        $("#trans-register").prop("disabled", true);
		    }
		}
		
		var count = 0;
		
		function addRow() {
			$("#result").append("<tr></tr>");
			for (var i = 0; i < 7; i++) {
				if (i == 0) $("#result tr").eq(-1).append('<td><input list="List'+ (++count) +'" class="deptName" placeholder="부서 선택" /><datalist id="List'+ count + '"><c:forEach items="${department}" var="dept"><option value="${dept.deptName}" data-dept_no ="${dept.deptNo}" ></option></c:forEach></datalist></td>');
				else $("#result tr").eq(-1).append('<td></td>');
			}
			$("#result tr").eq(-1).append('<td><button class="remove-row">열 삭제</button></td>')
		}
		
		addRow();
		
		$("#add-row").click(() => {
			addRow();
		});
		
		$(document).on("click", ".remove-row", function() {
			if ($("#result tr").length > 2) $(this).parent().parent().remove();
		});
		
		$(document).on("change", ".deptName", (e) => {
			$(e.target).parent().parent().find("td").eq(3).html("");
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
			$(e.target).parent().parent().find("td").eq(2).text("지출");
			$(e.target).parent().parent().find("td").eq(3).text("기타 비용");
			$(e.target).parent().parent().find("td").eq(4).html('<input type="number" min="0" name="trans-amount" id="transAmount">');
			$(e.target).parent().parent().find("td").eq(5).html('<input type="text" name="trans-desc" value="기타 비용 지출">');
			$(e.target).parent().parent().find("td").eq(6).html('<input type="date" name="trans-date" id="transDate">');
		});
		
		$("#trans-register").click(() => {
			const table = $("#result tr");
			const tList = [];
			
			for (var i = 1; i < table.length; i++) {
				const obj ={};
				obj.deptNo=$("#result tr").eq(i).find("td").eq(1).text();
				obj.transType=$("#result tr").eq(i).find("td").eq(2).text();
				obj.category=$("#result tr").eq(i).find("td").eq(3).text();
				obj.transAmount=$("#result tr").eq(i).find("td").eq(4).find("input").val();
				obj.transDesc=$("#result tr").eq(i).find("td").eq(5).find("input").val();
				obj.transDate=$("#result tr").eq(i).find("td").eq(6).find("input").val();
				
				tList.push(obj);
			}
			console.log(JSON.stringify(tList));
			
			$.ajax({
				type : "post",
				url: "/transRegister",
				dataType : "json",
				data : JSON.stringify(tList),
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