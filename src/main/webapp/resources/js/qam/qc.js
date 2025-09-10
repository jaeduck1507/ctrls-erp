function displayQc(result) {
	// 테이블 헤더 초기화
	let tableHead = "<tr><th>상품번호</th><th>qc코드</th><th>입고일</th><th>제품코드</th><th>브랜드명</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>카테고리</th><th>부자재검사</th><th>색상검사</th><th>손상검사</th><th>검사 설명</th><th>검사일</th><th>검사자</th><th>수정</th></tr>"
	$("#qcResult").html(tableHead);
	
	// QC읭 각 행 기입 (전부 보여주는 페이지기에 product와 qc leftJoin으로 합침)
	for (let q of result.list) {
		
		let row = "<tr>";
		row += "<td>" + q.productNo + "</td>";
		row += "<td>" + q.qcCode + "</td>";
		row += "<td>" + q.productionDate + "</td>";
		row += "<td>" + q.productCode + "</td>";
		row += "<td>" + q.brandName + "</td>";
		row += "<td>" + q.productColor + "</td>";
		row += "<td>" + q.productName + "</td>";
		row += "<td>" + q.productPrice.toLocaleString() + "</td>";
		row += "<td>" + q.productCost.toLocaleString() + "</td>";
		row += "<td>" + q.productCategory + "</td>";
		row += "<td>" + q.checkMaterial + "</td>";
		row += "<td>" + q.checkColor + "</td>";
		row += "<td>" + q.checkDamage + "</td>";
		row += "<td>" + q.qcDesc + "</td>";
		row += "<td>" + q.qcDate + "</td>";
		row += "<td>" + q.empNo + "</td>";
		row += "<td><a href='/qam/qcFormUpdate?productNo=" + q.productNo + "' class='btnO'>수정</a></td>";
		row += "</tr>"
		$("#qcResult").append(row);
	}
	
	$(".pagination").html('');
		$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
		for(var i =result.startPage; i<=result.endPage; i++) {
			$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="#" data-page="' + i +'">' + i + '</a></li>');
		}
		$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');

		$(".pagination").off("click").on("click", "a.page-link", function(e) {
		        e.preventDefault();
		        const page = $(this).data("page");
		        $.ajax({
		            type: "get",
		            url: "/qam/searchQc",
		            data: {
		                productName: $("#productName").val(),
		                productCategory: $("#productCategory").val(),
		                empNo: $("#empNo").val(),
		                startDate: $("#startDate").val(),
		                endDate: $("#endDate").val(),
		                page: page
		            },
		            success: displayQc,
		        });
		    });
	}

$(document).ready(function() {
	// 초기 로딩 - 전부 불러오기
	$.ajax({
		type: "get",
		url: "/qam/searchQc",
		data: { 
			productName: $("#productName").val(),
			productCategory: $("#productCategory").val(),
			empNo: $("#empNo").val(),
			startDate: $("#startDate").val(),
			endDate: $("#endDate").val()
		},  
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
		
	$('#resetBtn').click(function() {
		$("#productName").val("");
		$("#productCategory").val("");
		$("#empNo").val("");
		$("#startDate").val("");
		$("#endDate").val("");

		$.ajax({
		 type: "get",
		 url: "/qam/searchQc", // 서버에서 /qam/searchQc JSON을 받아 필터링하도록 구현	
		 success: function (result) { 
			displayQc(result); 
		},
		 error: function (xhr, status, err) {
		         }
		    });
	})
	
});