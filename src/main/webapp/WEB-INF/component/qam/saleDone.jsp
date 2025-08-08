<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>판매완료 제품 조회</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!--		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>-->
</head>

<body>
<h2>판매완료 제품 조회</h2>

<h3 id="salePriceSum">
	<!-- 총 가격 출력 영역 -->
</h3>

<form id="saleSearchForm">
	카테고리 조회:
	<select id="productCategory">
	    <option value="">카테고리 선택</option>
	    <option value="상의">상의</option>
	    <option value="하의">하의</option>
	    <option value="악세사리">악세사리</option>
	    <option value="신발">신발</option>
	</select>
	<br>
	판매일 조회 (시작일): <input type="date" id="startDate">
	(종료일): <input type="date" id="endDate"> 
	
	<button type="button" id="searchBtn">조회</button>
	<button type="button" id="resetBtn">전체보기</button>
</form>

<table border="1" id="saleResult">
    <tr>
		<th>판매코드</th>
        <th>제품번호</th>
        <th>제품코드</th>
		<th>카테고리</th>
		<th>제품명</th>
        <th>가격</th>
		<th>판매날짜</th>
	</tr>
</table>

<!--<nav>-->
<!--	<ul class="pagination">-->
<!--		<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/qam/saleDone?page=${paging.startPage - 1}">Previous</a></li>-->
							
<!--		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">-->
<!--			<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/qam/saleDone?page=${page}">${page}</a></li>-->
<!--		</c:forEach>-->
		
<!--		<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/qam/saleDone?page=${paging.endPage + 1}">Next</a></li>-->
<!--	</ul>-->
<!--</nav>-->

<!--<nav>
	<ul class="pagination">
		<li class="page-item ${paging.prev ? '' : 'disabled'}">
		    <a class="page-link" href="#" data-page="${paging.startPage - 1}">Previous</a>
		</li>
							
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
			<li class="page-item">
			    <a class="page-link ${paging.page == page ? 'active' : ''}" href="#" data-page="${page}">${page}</a>
			</li>
		</c:forEach>
		
		<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/qam/saleDone?page=${paging.endPage + 1}">Next</a></li>
	</ul>
</nav>-->

<script>
function displaySale(data) {
	let tableHead = "<tr><th>판매코드</th><th>제품번호</th><th>제품코드</th><th>카테고리</th><th>제품명</th><th>가격</th><th>판매날짜</th></tr>";
	$("#saleResult").html(tableHead); // 테이블 헤더 설정

	let total = 0;

	for (let i = 0; i < data.length; i++) {
		let s = data[i];
		total += s.productPrice;

		let row = "<tr>";
		row += "<td>" + s.saleNo + "</td>";
		row += "<td>" + s.productNo + "</td>";
		row += "<td>" + s.productCode + "</td>";
		row += "<td>" + s.productCategory + "</td>";
		row += "<td>" + s.productName + "</td>";
		row += "<td>" + s.productPrice + "</td>";
		row += "<td>" + s.saleDate + "</td>";
		row += "</tr>";

		$("#saleResult").append(row);
	}

	document.getElementById("salePriceSum").innerText = "매출 총합: " + total.toLocaleString() + "원";
	}

	$(document).ready(function() {
		
		// 페이징 버튼 클릭 시
/*		$(".pagination").on("click", ".page-link", function (e) {
		    e.preventDefault(); // 링크 이동 방지
		    const page = $(this).data("page");

		    $.ajax({
		        type: "get",
		        url: "/qam/showSaleDone",
		        data: { page: page },
		        success: function (result) {
		            displaySale(result); // same rendering logic
		        }
		    });
		}); 
		*/
		
		$.ajax({
			type: "get",
			url: "/qam/showSaleDone",
			success: function (result) {
				displaySale(result);
				console.log(result.length > 0);
			}
		}); 
		
		// 조회 버튼 이벤트
		$("#searchBtn").click(function () {
			
			$.ajax({
				type: "get",
				url: "/qam/searchSaleDone", 
				data: {
					productCategory: $("#productCategory").val(),
					startDate: $("#startDate").val(),
					endDate: $("#endDate").val()
				},
				success: function (result) {
					displaySale(result);
				}
			});
		});

		// 전체보기 버튼 이벤트
		$("#resetBtn").click(function () {
			
			$("#productCategory").val("");
			$("#startDate").val("");
			$("#endDate").val("");
			
			$.ajax({
				type: "get",
				url: "/qam/showSaleDone",
				success: function (result) {
					displaySale(result);
				}
			});
		});
	});
</script>

</body>
</html>
