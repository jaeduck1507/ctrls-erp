<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 결과 목록</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<h2>품질검사 결과 목록</h2>

<!-- QC 등록 버튼 -->
<a href="/qam/qcForm"><button>신규 검사 등록</button></a>
<br/><br/>

<div id = "search">
<!--	이름 : <input type="text" id="empName">-->
		<select id = "productName">
				<option value="a">제품 선택</option>
		</select>
		
<!--		<select id = "jobTitle">-->
<!--				<option value="a">카테고리 선택</option>-->
<!--		</select>-->
<!--		<button id = "btn">검색</button>-->
	</div>

<!-- 테이블 -->
<table border="1" id="qcResult">
    <tr>
        <th>제품번호</th>
        <th>생산일</th>
        <th>제품코드</th>
        <th>색상</th>
        <th>제품명</th>
        <th>판매가</th>
		<th>단가</th>
		<th>카테고리</th>
		<th>부자재검사 여부</th>
		<th>색상검사 여부</th>
		<th>손상검사 여부</th>
		<th>검사 설명</th>
        <th>검사일</th>
		<th>검사자</th>
        <th>수정</th>
    </tr>
</table>

<script>
function displayQc(data) {
	// 테이블 헤더 초기화
	let tableHead = "<tr><th>제품번호</th><th>생산일</th><th>제품코드</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>카테고리</th><th>부자재검사 여부</th><th>색상검사 여부</th><th>손상검사 여부</th><th>검사 설명</th><th>검사일</th><th>검사자</th><th>수정</th>"
	$("#qcResult").html(tableHead);
	
	// QC읭 각 행 기입 (전부 보여주는 페이지기에 product와 qc leftJoin으로 합침)
	for (let q of data) {
		let row = "<tr>";
		row += "<td>" + q.productNo + "</td>";
		row += "<td>" + q.productionDate + "</td>";
		row += "<td>" + q.productCode + "</td>";
		row += "<td>" + q.productColor + "</td>";
		row += "<td>" + q.productName + "</td>";
		row += "<td>" + q.productPrice + "</td>";
		row += "<td>" + q.productCost + "</td>";
		row += "<td>" + q.productCategory + "</td>";
		row += "<td>" + q.checkMaterial + "</td>";
		row += "<td>" + q.checkColor + "</td>";
		row += "<td>" + q.checkDamage + "</td>";
		row += "<td>" + q.qcDesc + "</td>";
		row += "<td>" + q.qcDate + "</td>";
		row += "<td>" + q.empNo + "</td>";
		row += "<td><a href='/qam/qcFormUpdate?productNo=" + q.productNo + "'>수정</a></td>";
		row += "</tr>"
		$("#qcResult").append(row);
	}
}	

$(document).ready(function() {
	// 초기 로딩 - 전부 불러오기
	$.ajax({
		type: "get",
		url: "/qam/showQc",
		success: function (result) {
			displayQc(result);
		}
	});



	$.ajax({
        // 요청
        type : "get",
        url : "/showProductName",
        // 응답
        success : function(result) {
            for(const i of result) {
				var text = '<option value="'+ i.productName +'">'+ i.productName +'</option>';
            	$("#productName").append(text);
            	
            }
        },
        
		error:function(xhr,status,error) {
			
		}
    });
	
	
	// 여기서부터 수정 필요
	$.ajax({
        // 요청
        type : "get",
        url : "/showJob",
        // 응답
        success : function(result) {
        	for(const i of result) {
				var text = '<option value="'+ i.jobTitle +'">'+ i.jobTitle +'</option>';
				console.log(text);
            	$("#jobTitle").append(text);
            	
            }
        },
        
		error:function(xhr,status,error) {
			
		}
    });
	
	$("#btn").click(() =>{

		const formData = new FormData();
		formData.append("empName", $('#empName').val());
		formData.append("jobTitle",$('#jobTitle').val());
		formData.append("deptName", $('#deptName').val());
	    $.ajax({
	        // 요청
	        type : "post",
	        url : "/infoShow",
	        data : formData,
			processData: false,
			contentType : false,
	        // 응답
	        success : function(result) {
				//$("#result").text("");
	        	$("#result").append("<tr><th>이름</th><th>직급</th><th>부서</th></tr>");
	        	for(const emp of result) {
				var text = "<tr><td>"+ emp.empName +"</td><td>"+emp.jobTitle+"</td><td>"+emp.deptName+"</td></tr>"
				$("#result").append(text);
	        	
	        	}
	        },
	        
			error:function(xhr,status,error) {
				
			}
	    });
	});
});
</script>


</body>
</html>
