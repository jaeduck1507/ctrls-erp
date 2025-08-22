$("#btn").click(() => {
	const formData = new FormData();
	formData.append("brandName", $("#brandName").val());
	formData.append("productCategory", $("#productCategory").val());
	formData.append("productName", $("#productName").val());
	
	const startDate = $("#startDate").val();
	const endDate = $("#endDate").val();
	formData.append("startDate", startDate);
	formData.append("endDate", endDate);
	
	if (startDate && !endDate) {
		alert("조회 종료일을 선택해주세요!");
		return;
	} else if (!startDate && endDate) {
		alert("조회 시작일을 선택해주세요!");
		return;
	} else if (startDate > endDate) {
		alert("조회 기간을 다시 선택해주세요!");
		return;
	}
	
	$.ajax({
		type: "post",
		url: "/showPurchase",
		data: formData,
		processData: false,
		contentType : false,
		success: function(result) {
			//console.log($("#brandName").val());
			//console.log($("#productCategory").val());
			//console.log($("#productName").val());
			//console.log($("#startDate").val());
			//console.log($("#endDate").val());
			
			if (!result.purchaseList || result.purchaseList.length === 0) {
				alert("조회된 결과가 없습니다");
				location.reload();
			}
			
			$("#result").html("");
			$("#result").append("<tr><th>매입 번호</th><th>브랜드</th><th>제품명</th><th>카테고리</th><th>단가</th><th>수량</th><th>부가세</th><th>총액</th><th>매입 날짜</th></tr>");
			for (const purchase of result.purchaseList) {
				var text = "<tr><td>"  + purchase.purchaseNo + "</td><td>"  + purchase.brandName + "</td><td>"  + purchase.productName + "</td><td>" + purchase.productCategory 
					+ "</td><td>" + purchase.unitPrice.toLocaleString() + "</td><td>" + purchase.quantity + "</td><td>" + purchase.varAmount.toLocaleString() 
					+ "</td><td>" + purchase.totalAmount.toLocaleString() + "</td><td>" + purchase.purchaseDate + "</td></tr>"
				$("#result").append(text);
			}
			
			$(".pagination").html('');
        	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
        	for (var i = result.startPage; i <= result.endPage; i++) {
        		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
        	}
        	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
		},
		error: function(xhr, status, error) {
			
		}
	});
});

$(document).on('click', 'a.page-link', function(e) {
	e.preventDefault();
	
	const formData = new FormData();
	formData.append("brandName", $("#brandName").val());
	formData.append("productCategory", $("#productCategory").val());
	formData.append("productName", $("#productName").val());
	formData.append("startDate", $("#startDate").val());
	formData.append("endDate", $("#endDate").val());
	formData.append("page", $(this).attr('href'));
	
	$.ajax({
		type: "post",
		url: "/showPurchase",
		data: formData,
		processData: false,
		contentType : false,
		success: function(result) {
			$("#result").html("");
			$("#result").append("<tr><th>매입 번호</th><th>브랜드</th><th>제품명</th><th>카테고리</th><th>단가</th><th>수량</th><th>부가세</th><th>총액</th><th>매입 날짜</th></tr>");
			for (const purchase of result.purchaseList) {
				var text = "<tr><td>"  + purchase.purchaseNo + "</td><td>"  + purchase.brandName + "</td><td>"  + purchase.productName + "</td><td>" + purchase.productCategory 
					+ "</td><td>" + purchase.unitPrice.toLocaleString() + "</td><td>" + purchase.quantity + "</td><td>" + purchase.varAmount.toLocaleString() 
					+ "</td><td>" + purchase.totalAmount.toLocaleString() + "</td><td>" + purchase.purchaseDate + "</td></tr>"
				$("#result").append(text);
			}
			
			$(".pagination").html('');
        	$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
        	for (var i = result.startPage; i <= result.endPage; i++) {
        		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
        	}
        	$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
		},
		error: function(xhr, status, error) {
			
		}
	});
});