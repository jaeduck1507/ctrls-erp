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

<form id = "searchForm">
		제품 조회: <select id ="productName">
				<option value="">제품 선택</option>
		</select>
		카테고리 조회: <select id="productCategory">
		    <option value="">카테고리 선택</option>
		    <option value="상의">상의</option>
		    <option value="하의">하의</option>
		    <option value="악세사리">악세사리</option>
		    <option value="신발">신발</option>
		</select>
		검사자 사번: <select id="empNo">
		        <option value="">사번 선택</option>
		        <c:forEach var="e" items="${empList}">
		            <option value="${e.empNo}">
		                [${e.empNo}] ${e.empName}
		            </option>
		        </c:forEach>
		    </select>
		<br>
		생산일 조회 (시작일): <input type="date" id="startDate">
		(종료일): <input type="date" id="endDate">
		<button type="submit">검색</button> <!-- button type 지정 안할 시 default => submit -->
</form>

<!-- 테이블 -->
<table border="1" id="qcResult">
    <tr>
        <th>제품번호</th>
		<th>qc코드</th>
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
	let tableHead = "<tr><th>제품번호</th><th>qc코드</th><th>생산일</th><th>제품코드</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>카테고리</th><th>부자재검사 여부</th><th>색상검사 여부</th><th>손상검사 여부</th><th>검사 설명</th><th>검사일</th><th>검사자</th><th>수정</th></tr>"
	$("#qcResult").html(tableHead);
	
	// QC읭 각 행 기입 (전부 보여주는 페이지기에 product와 qc leftJoin으로 합침)
	for (let q of data) {
		let row = "<tr>";
		row += "<td>" + q.productNo + "</td>";
		row += "<td>" + q.qcCode + "</td>";
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
	
	$("#searchForm").submit(function (e) {
	     e.preventDefault();
		 console.log("작동 확인용");

		$.ajax({
		 type: "get",
		 url: "/qam/searchQc", // 서버에서 /qam/searchQc JSON을 받아 필터링하도록 구현
		 data: { 
			productName: $("#productName").val(),
			productCategory: $("#productCategory").val(),
			empNo: $("#empNo").val(),
			startDate: $("#startDate").val(),
			endDate: $("#endDate").val()
		},  
		 success: function (result) { 
			displayQc(result); 
		},
		 error: function (xhr, status, err) {
		         }
		    });
		});
	});
	</script>


</body>
</html>
