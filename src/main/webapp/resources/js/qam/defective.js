function displayDefective(data) {
	
	let selectedFilter = [];
	
	$(".defectiveFilter:checked").each(function () {
	    selectedFilter.push($(this).val());
	});
	
	let tableHead = "<tr><th>불량코드</th><th>제품번호</th><th>제품코드</th><th>부자재검사</th><th>색상검사</th><th>손상검사</th><th>브랜드명</th><th>카테고리</th><th>제품명</th><th>가격</th><th>불량사유</th><th>검사일</th></tr>";
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
	  
	  $(function () {
	    $("#resetBtn").trigger("click"); // 페이지 접속 시 바로 전체보기 가능하도록 
	  });