<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>판매대기 제품 리스트</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>

<body>
<h2>판매대기 제품 리스트</h2>

<button id = "sellRegister">판매 등록</button> <!-- 누를 시 입력된 날짜대로 판매날짜가 등록되는 버튼 -->

<table border="1" id="saleReady"> <!-- saleReady 테이블 -->
    <tr>
		<th>판매코드</th>
		<th>제품번호</th>
		<th>제품코드</th>
		<th>카테고리</th>
		<th>제품명</th>
        <th>가격</th>
<!--		<th>판매날짜(확인용)</th>-->
		<th>날짜입력</th>
	</tr>
	
	<c:forEach items="${saleList}" var="sale">
		<tr>
			<td>${sale.saleNo}</td>
			<td>${sale.productNo}</td>
			<td>${sale.productCode}</td>
			<td>${sale.productCategory}</td>
			<td>${sale.productName}</td>
			<td>${sale.productPrice}</td>
<!--			<td>${sale.saleDate}</td>-->
			<td><input type="date" class="sellDate" data-no="${sale.saleNo}"></td>
		</tr>
	</c:forEach>
</table>

<nav>
	<ul class="pagination">
		<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/qam/saleReady?page=${paging.startPage - 1}">Previous</a></li>
							
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
			<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/qam/saleReady?page=${page}">${page}</a></li>
		</c:forEach>
		
		<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/qam/saleReady?page=${paging.endPage + 1}">Next</a></li>
	</ul>
</nav>
	
<script>
	$(document).ready(function() {
		$('.sellDate').val(new Date().toISOString().substring(0, 10)).trigger('change');
	});
	/*
	function displaySale(data) {
		let tableHead = "<tr><th>판매코드</th><th>제품번호</th><th>제품코드</th><th>카테고리</th><th>제품명</th><th>가격</th><th>판매날짜(확인용)</th><th>날짜입력</th></tr>"
		$("#saleReady").html(tableHead); // tableHead (첫 헤더 줄) 작성용
		
		for (let s of data) {
				let row = "<tr>";
				row += "<td>" + s.saleNo + "</td>";
				row += "<td>" + s.productNo + "</td>";
				row += "<td>" + s.productCode + "</td>";
				row += "<td>" + s.productCategory + "</td>";
				row += "<td>" + s.productName + "</td>";
				row += "<td>" + s.productPrice + "</td>";
				row += "<td>" + s.saleDate + "</td>";
				row += "<td><input type='date' class='sellDate'></td>";
				row += "</tr>"
				$("#saleReady").append(row);
				}
				$("#saleReady tr").find(".sellDate").val(new Date().toISOString().substring(0, 10)); // 입력된 sellDate는 saleDate를 위한 인풋값!
			}
		*/	
		/*
	$(document).ready(function() {
		
		/*
		$.ajax({ // null한 sale 항목 전부 보여주기
				type: "get", // 값을 보여주는것이기에 GET
				url: "/qam/showSaleNull", // HSDController의 showSaleNull()를 GET 호출, @GetMapping("/showSaleNull")
				success: function (result) {
					displaySale(result); // 위의 function displaySale(data)를 시전, success값인 result값으로!
				}
			});
			
		
	});*/
	
	let sellList = JSON.parse(sessionStorage.getItem("sellList")) || [];
		
	$(document).on("change", ".sellDate", function () {
		const saleNo = $(this).data('no');
		const saleDate = $(this).val();
	
		sellList = sellList.filter(item => item.saleNo !== saleNo);
		if(saleDate) {
			sellList.push({ saleNo, saleDate });
		}
		sessionStorage.setItem('sellList', JSON.stringify(sellList));
		
		console.log(sellList);
	})
	
	$("#sellRegister").click(() => { // 판매 등록 버튼 trigger
		//const table = $("#saleReady tr"); // 위의 id=saleReady테이블에 생성된 <tr><td></td></th> 줄들 모두!
		//let sellList = []; // saleNo, saleDate(입력값)을 넣어둘 []

		//for (let i = 1; i < table.length; i++) { // 위에서 생성된 $("#saleReady tr") 테이블 tr줄 개수 (1부터 시작하는 이유는 첫줄이 tableHead이기 때문)
		//	let row = table.eq(i); // row를 그때그때 row(1부터 시작하는)로 선언

		//	let saleNos = row.find("td").eq(0).text(); // row에서 td항목들을 찾고, 그중 첫번째(index 0번째)로 있는 s.saleNo값을 let saleNos에 대입
		//	let saleDates = row.find("td").eq(7).find("input").val(); // row에서 td항목들을 위와 같이 찾고, 그중 8번째(index 7번째)로 입력된 class='sellDate' 값을 let saleDates에 대입

		//	if (saleDates) { // saleDates 입력값이 존재하는 경우(만!), 입력값 없어도 됨, 그럴 시 판매날짜 null로 유지됨
		//		sellList.push({ // 위에서 만들어둔 let sellList = [];에 saleNos와 saleDates 넣기 
		//			saleNo: saleNos, // 이때 saleNo: XXX(saleNos 값), saleDate: XXX(saleDates 값) 포멧으로 리스트에 저장됨
		//			saleDate: saleDates // sellList [] 안에 saleNo, saleDate 삽입, s를 끝에 붙임으로 어느게 어느건지 가시화
		//		});
		//	}
		//}
		console.log("Submitting:", JSON.parse(sessionStorage.getItem("sellList")));
		$.ajax({
			type: "post", // .jsp에서 받아진 값을 DB로 보내기에 POST
			url: "/qam/registerSaleDate", // HSDController의 registerSaleDate(@RequestBody List<SaleReadyDTO> sellList)를 POST 호출, @PostMapping("/registerSaleDate")
			contentType: "application/json", // Ajax 요청을 보낼 때, 요청 본문(RequestBody)에 담긴 데이터가 JSON 형식임을 서버에 알리는 역할
			data: JSON.stringify(sellList), // sellList를 JSON'화'해두기 (HSDController의 registerSaleDate에서 @RequestBody로 JSON 데이터 Java 객체로 변환 예정)
			success: function (result) {
				console.log(sellList)
				sessionStorage.removeItem("sellList");
				location.reload(); // 성공적으로 요청이 처리되면 페이지를 새로고침, saleDate가 등록된 제품(=판매 완료된 제품)은 리스트에서 사라지고, saleDate가 여전히 null인 제품만 화면에 남음
				
			},
			error: function (xhr, status, error) {
			}
		});
	});
</script>

</body>
</html>
