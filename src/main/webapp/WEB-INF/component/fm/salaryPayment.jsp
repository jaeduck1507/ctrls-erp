<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salary</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>급여 등록</h1>
	<div id="search">
		<input type="month" id = "yearMonth"  >
		<button id="btn">조회</button>
	</div>
		
	<div>	
		<table border="1" id="result">
				
		</table>
		<button id="submit" >등록하기</button>
	</div>
	
	<script>
		$("#btn").click(() => {
			const yearMonth = $("#yearMonth").val();
			$.ajax({
				type: "post",
				url: "/salaryPayment",
				data: {yearMonth : yearMonth},
				
				success: function(result) {
					
					$("#result").html("");
					$("#result").append("<tr><th>직원 번호</th><th>직원 이름</th><th>부서명</th><th>직급명</th><th>지급일</th><th>기본급</th><th>보너스</th><th>공제금</th><th>급여 총액</th></tr>");
					for (const s of result) {
						var text = "<tr><td>" + s.empNo + "</td><td>" + s.empName + "</td><td>" + s.deptName + "</td><td>" 
							+ s.jobTitle + "</td><td>" + (yearMonth +'-15') + "</td><td>" + s.baseSalary + "</td><td>" + s.bonus + "</td><td>" 
							+ '<input type="number" class= "deduction" value="'+ ((s.baseSalary+s.bonus)*0.1) +'">' +"</td><td>" + ((s.baseSalary+s.bonus)*0.9) + "</td></tr>";
						$("#result").append(text);
					}
				},
				error: function(xhr, status, error) {
							
				}
			});
		});	
		$(document).on('input', '.deduction', (e) => {
				const deduction = $(e.target).val();
				const baseSalary = $(e.target).parent().parent().find("td").eq(5).text();
				const bonus = $(e.target).parent().parent().find("td").eq(6).text();
				const total = Number(baseSalary) + Number(bonus) - deduction;
				console.log(total);
				$(e.target).parent().parent().find("td").eq(8).html("");
				$(e.target).parent().parent().find("td").eq(8).text(total);
			});
		
		$("#purchase-register").click(() => { // 제출 버튼
	        const table = $("#result tr"); // 테이블 정보 획득
	        const prList = []; // 객체를 담을 배열
	    	
	        for(var i = 1; i < table.length; i++){ // i가 1부터 시작하는 이유는 첫번째 열은 th(열의 설명)부분이라 데이터가 아님
	            const obj ={}; // 직원 하나당 하나의 객체로 생성
	            obj.productNo=$("#result tr").eq(i).find("td").eq(1).text(); 
	            obj.unitPrice=$("#result tr").eq(i).find("td").eq(4).text(); 
	            obj.quantity=$("#result tr").eq(i).find("td").eq(6).find("input").val(); 
	            obj.varAmount=$("#result tr").eq(i).find("td").eq(7).text(); 
	            obj.totalAmount=$("#result tr").eq(i).find("td").eq(8).text(); 
	            obj.purchaseDate=$("#result tr").eq(i).find("td").eq(9).find("input").val();  
	            prList.push(obj); // 정보 저장한 객체를 배열에 삽입
	        }
	        console.log(JSON.stringify(prList));
	        
	        /*
	        $.ajax({
	            // 요청
	            type : "post",
	            url : "/purchaseRegister",
	            dataType : "json", // dataType 지정해줘야 자바에서 인식하는 듯?
	            data : JSON.stringify(prList), // json문자열로 변환해서 전송
				processData: false,
				contentType: 'application/json; charset=UTF-8', // formData에서는 false였으나 여기서는 contentType을 지정해줘야함
	            // 응답
	            success : function(result) {
					
	            },
	            
				error:function(xhr,status,error) {
					
				} 
	        });*/
	    });
	</script>
</body>
</html>