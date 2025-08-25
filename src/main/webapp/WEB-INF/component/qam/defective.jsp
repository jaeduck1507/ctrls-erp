<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>불량품 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>

<body>
	<h5>[품질 관리] > [불량품 조회]</h5>
		<h3>불량품 조회</h3>
<h4 id="defectivePriceSum"></h4>
<div class="filter-bar">
<form id="defectiveSearchForm">
	<!-- 불량 유형 필터 체크박스 -->
	불량 유형:
	<label><input type="checkbox" class="defectiveFilter" id="checkMaterial" value="material" checked> 부자재 불량</label>
	<label><input type="checkbox" class="defectiveFilter" id="checkColor" value="color" checked> 색상 불량</label>
	<label><input type="checkbox" class="defectiveFilter" id="checkDamage" value="damage" checked> 손상 불량</label>
	
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
</div>
<table border="1" id="defectiveResult" class="data-table">
    <thead>
        <tr>
            <th>불량코드</th>
            <th>제품번호</th>
            <th>제품코드</th>
            <th>부자재검사 여부</th>
            <th>색상검사 여부</th>
            <th>손상검사 여부</th>
			<th>브랜드명</th>
			<th>카테고리</th>
            <th>제품명</th>
            <th>가격</th>
            <th>불량사유</th>
			<th>검사일</th>
        </tr>
    </thead>
    <tbody></tbody>
	
	

	
</table>

<nav>
	<ul class="pagination">
		
	</ul>
</nav>

<script>
function displayDefective(data) {
	
	let selectedFilter = [];
	
	$(".defectiveFilter:checked").each(function () {
	    selectedFilter.push($(this).val());
	});
	
	let tableHead = "<tr><th>불량코드</th><th>제품번호</th><th>제품코드</th><th>부자재검사 여부</th><th>색상검사 여부</th><th>손상검사 여부</th><th>브랜드명</th><th>카테고리</th><th>제품명</th><th>가격</th><th>불량사유</th><th>검사일</th></tr>";
	$("#defectiveResult thead").html(tableHead);
	$("#defectiveResult tbody").html("");
	
	console.log(selectedFilter);

    var total = 0;

	for (let d of data) {
	   
		
		total += d.productPrice;

        let row = "<tr>";
        row += "<td>" + d.defectiveNo + "</td>";
        row += "<td>" + d.productNo + "</td>";
        row += "<td>" + d.productCode + "</td>";
        row += "<td>" + d.checkMaterial + "</td>";
        row += "<td>" + d.checkColor + "</td>";
        row += "<td>" + d.checkDamage + "</td>";
		row += "<td>" + d.brandName + "</td>";
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
	
	/*
	// 최초 전체 불량품 조회
	$.ajax({
	    type: "get",
	    url: "/qam/showDefective",
	    success: function (result) {
	        displayDefective(result);
	    }
	});
	*/

	// 검색 버튼 클릭 시
	$("#searchBtn").click(function () {

	    $.ajax({
	        type: "get",
	        url: "/qam/searchDefective",
	        data: {
	            productCategory: $("#productCategory").val(),
	            startDate: $("#startDate").val(),
	            endDate: $("#endDate").val(),
	            checkMaterial: ($("#checkMaterial").is(":checked")? "불합격" : "합격"),
	            checkColor: ($("#checkColor").is(":checked")? "불합격" : "합격"),
	            checkDamage: ($("#checkDamage").is(":checked")? "불합격" : "합격")
	        },
	        success: function (result) {
	            displayDefective(result.list);
				$(".pagination").html('');
				$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
				for(var i =result.startPage; i<=result.endPage; i++) {
					$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
				}
				$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
	        }
	    });
	});

	// 전체보기 버튼 클릭 시
	$("#resetBtn").click(function () {
	  // 1) reset the UI
	  $("#productCategory").val("");
	  $("#startDate").val("");
	  $("#endDate").val("");
	  $("#checkMaterial").prop("checked", true);
	  $("#checkColor").prop("checked", true);
	  $("#checkDamage").prop("checked", true);

	  $.ajax({
	    type: "get",
	    url: "/qam/searchDefective",
	    data: {
	      productCategory: "",
	      startDate: "",
	      endDate: "",
	      checkMaterial: "불합격",
	      checkColor: "불합격",
	      checkDamage: "불합격"
	    },
	    success: function (result) {
	      displayDefective(result.list);
	      $(".pagination").html("");
	      $(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
	      for (var i = result.startPage; i <= result.endPage; i++) {
	        $(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i + '">' + i + '</a></li>');
	      }
	      $(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
	    },
	    error: function (xhr) {
	      console.error("reset error", xhr.responseText);
	    }
	  });
	});


	
	
	
});

$(document).on('change', '.defectiveFilter', function(e) {
	if(!($("#checkMaterial").is(":checked") || $("#checkColor").is(":checked") || $("#checkDamage").is(":checked"))) {
		Swal.fire({
			title: "적어도 1개 이상의 불량사유를 체크해야합니다!",
			confirmButtonText: '확인',
			width: 750,
			confirmButtonColor: "#90C67C",
			icon: "warning",
			iconColor: "green"
			});
		$(e.target).prop("checked", true);
	}
});

$(document).on('click', 'a.page-link', function(e) {
    e.preventDefault();        
    // a 태그 기본 동작(페이지 이동) 차단
    /*
    const formData = new FormData();
	formData.append("empName", $('#empName').val());
	formData.append("jobNo",$('#jobTitle').val());
	formData.append("deptNo", $('#deptName').val());
	formData.append("page",$(this).attr('href')); */
        
	// 링크 URL 읽기
	
	$.ajax({
        // 요청
        type: "get",
	        url: "/qam/searchDefective",
	        data: {
	            productCategory: $("#productCategory").val(),
	            startDate: $("#startDate").val(),
	            endDate: $("#endDate").val(),
	            page: $(this).attr('href'),
	            checkMaterial: ($("#checkMaterial").is(":checked")? "불합격" : "합격"),
	            checkColor: ($("#checkColor").is(":checked")? "불합격" : "합격"),
	            checkDamage: ($("#checkDamage").is(":checked")? "불합격" : "합격")
	        },
	       	success: function (result) {
		        displayDefective(result.list);
				$(".pagination").html('');
				$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
				for(var i =result.startPage; i<=result.endPage; i++) {
					$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
				}
				$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
	       }
	    });
	  });
</script>

</body>
</html>
