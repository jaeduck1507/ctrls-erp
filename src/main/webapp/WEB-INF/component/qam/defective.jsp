<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>불량품 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
<h2>불량품 조회</h2>
<h3 id="defectivePriceSum"></h3>

<form id="defectiveSearchForm">
	<!-- 불량 유형 필터 체크박스 -->
	불량 유형:
	<label><input type="checkbox" class="defectiveFilter" value="material"> 부자재 불량</label>
	<label><input type="checkbox" class="defectiveFilter" value="color"> 색상 불량</label>
	<label><input type="checkbox" class="defectiveFilter" value="damage"> 손상 불량</label>
	
	<br>
	
	카테고리 조회: <select id="productCategory">
	    <option value="">카테고리 선택</option>
	    <option value="상의">상의</option>
	    <option value="하의">하의</option>
	    <option value="악세사리">악세사리</option>
	    <option value="신발">신발</option>
	</select>
	
	검사일 조회 (시작일): <input type="date" id="startDate">
	(종료일): <input type="date" id="endDate"> 
	
	<button type="button" id="searchBtn">검색</button>
	<button type="button" id="resetBtn">전체보기</button>
</form>

<table border="1" id="defectiveResult">
    <thead>
        <tr>
            <th>불량코드</th>
            <th>제품번호</th>
            <th>제품코드</th>
            <th>부자재검사 여부</th>
            <th>색상검사 여부</th>
            <th>손상검사 여부</th>
			<th>카테고리</th>
            <th>제품명</th>
            <th>가격</th>
            <th>불량사유</th>
			<th>검사일</th>
        </tr>
    </thead>
    <tbody></tbody>
</table>

<script>
function displayDefective(data) {
	
	let selectedFilter = [];
	
	$(".defectiveFilter:checked").each(function () {
	    selectedFilter.push($(this).val());
	});
	
	let tableHead = "<tr><th>불량코드</th><th>제품번호</th><th>제품코드</th><th>부자재검사 여부</th><th>색상검사 여부</th><th>손상검사 여부</th><th>카테고리</th><th>제품명</th><th>가격</th><th>불량사유</th><th>검사일</th></tr>";
	$("#defectiveResult thead").html(tableHead);
	$("#defectiveResult tbody").html("");
	
	console.log(selectedFilter);

    var total = 0;

	for (let d of data) {
	    let include = true;

		for (let filter of selectedFilter) {
		        if (filter === "material" && d.checkMaterial === "합격") include = false;
		        if (filter === "color" && d.checkColor === "합격") include = false;
		        if (filter === "damage" && d.checkDamage === "합격") include = false;
		    }
	    	if (!include) continue;
		
		total += d.productPrice;

        let row = "<tr>";
        row += "<td>" + d.defectiveNo + "</td>";
        row += "<td>" + d.productNo + "</td>";
        row += "<td>" + d.productCode + "</td>";
        row += "<td>" + d.checkMaterial + "</td>";
        row += "<td>" + d.checkColor + "</td>";
        row += "<td>" + d.checkDamage + "</td>";
		row += "<td>" + d.productCategory + "</td>";
        row += "<td>" + d.productName + "</td>";
        row += "<td>" + d.productPrice + "</td>";
        row += "<td>" + (d.reason == null || d.reason == '' ? "미작성" : d.reason) + "</td>";
		row += "<td>" + d.qcDate + "</td>";
		row += "</tr>";

        $("#defectiveResult tbody").append(row);
    }
    $("#defectivePriceSum").text("손실액 총합: " + total.toLocaleString() + "원");
}

$(document).ready(function() {
	
	// 최초 전체 불량품 조회
	$.ajax({
	    type: "get",
	    url: "/qam/showDefective",
	    success: function (result) {
	        displayDefective(result);
	    }
	});

	// 검색 버튼 클릭 시
	$("#searchBtn").click(function () {

	    $.ajax({
	        type: "get",
	        url: "/qam/searchDefective",
	        data: {
	            productCategory: $("#productCategory").val(),
	            startDate: $("#startDate").val(),
	            endDate: $("#endDate").val()
	        },
	        success: function (result) {
	            displayDefective(result);
	        }
	    });
	});
	
	// 전체보기 버튼 클릭 시
	$("#resetBtn").click(function () {
	    // 필터 초기화
	    $("#productCategory").val("");
	    $("#startDate").val("");
	    $("#endDate").val("");
	    $(".defectiveFilter").prop("checked", false);

	    // 전체 조회 재요청
	    $.ajax({
	        type: "get",
	        url: "/qam/showDefective",
	        success: function (result) {
	            displayDefective(result);
	        }
	    });
	});
});
</script>

</body>
</html>
