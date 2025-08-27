function displaySale(result) {
	let tableHead = "<tr><th>판매코드</th><th>제품번호</th><th>제품코드</th><th>브랜드명</th><th>카테고리</th><th>제품명</th><th>가격</th><th>판매날짜</th></tr>";
	$("#saleResult").html(tableHead); // 테이블 헤더 설정

	let total = 0;

	for (let s of result.list) {
		
		total += s.productPrice;

		let row = "<tr>";
		row += "<td>" + s.saleNo + "</td>";
		row += "<td>" + s.productNo + "</td>";
		row += "<td>" + s.productCode + "</td>";
		row += "<td>" + s.brandName + "</td>";
		row += "<td>" + s.productCategory + "</td>";
		row += "<td>" + s.productName + "</td>";
		row += "<td>" + s.productPrice + "</td>";
		row += "<td>" + s.saleDate + "</td>";
		row += "</tr>";

		$("#saleResult").append(row);
	}
	
	$(".pagination").html('');
	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
	for(var i =result.startPage; i<=result.endPage; i++) {
		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
	}
	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');

	document.getElementById("salePriceSum").innerText = "매출 총합: " + total.toLocaleString() + "원";
	}

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
				if (!result.list || result.list.length === 0) {
					alert("조회된 결과가 없습니다");
					location.reload();
				} else {
					console.log(result);
					displaySale(result);
				}
			}
		});
	});
	
	$("#resetBtn").click(function () {
		
		$("#productCategory").val("");
		$("#startDate").val("");
		$("#endDate").val("");
		
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
	
	$(document).on('click', 'a.page-link', function(e) {
        e.preventDefault();        
        // a 태그 기본 동작(페이지 이동) 차단
            
    	$.ajax({
            // 요청
            type: "get",
			url: "/qam/searchSaleDone", 
			data: {
				productCategory: $("#productCategory").val(),
				startDate: $("#startDate").val(),
				endDate: $("#endDate").val(),
				page: $(this).attr('href')
			},
			success: function (result) {
				displaySale(result);
			}
        });
      });
	  
	  $(function () {
	    $("#resetBtn").trigger("click"); // 페이지 접속 시 바로 전체보기 가능하도록 
	  });