var saleReadyPagingDTO = {};
function inint_Paing() {
	saleReadyPagingDTO = {
		offset: 0,
		limit: 10,
		page: 1,
		pageSize: 10,
		endPage: this.pageSize,
		startPage: this.endPage - this.pageSize + 1,
		prev: false,
		next: false,
		total: 0,

		setTotal(total) {
			this.total = total;
			this.offset = (this.page - 1) * this.limit;

			this.endPage = Math.ceil(this.page / this.pageSize) * this.pageSize;
			this.startPage = this.endPage - this.pageSize + 1;

			const lastPage = Math.ceil(this.total / this.limit);

			if (lastPage < this.endPage) {
				this.endPage = lastPage;
			};

			this.prev = this.startPage > 1;
			this.next = this.endPage < lastPage;
		}
	};
};

function saleReadyPaingFuc() {

	let today = new Date();

	let year = today.getFullYear();
	let month = String(today.getMonth() + 1).padStart(2, "0");
	let day = String(today.getDate()).padStart(2, "0");

	let ymd = year + "-" + month + "-" + day;

	$("#saleReady").html("");
	$("#saleReady").append("<tr><th>판매코드</th><th>상품번호</th><th>제품코드</th><th>브랜드명</th><th>카테고리</th><th>제품명</th><th>가격</th><th>판매일 입력</th><th>선택</th></tr>");
	for (var i = saleReadyPagingDTO.offset; i < ((saleReadyPagingDTO.offset + saleReadyPagingDTO.limit) > saleReadyPagingDTO.result.length ? saleReadyPagingDTO.result.length : (saleReadyPagingDTO.offset + saleReadyPagingDTO.limit)); i++) {
		var text =
			'<tr id="index_' + i + '">' +
			'<td>' + saleReadyPagingDTO.result[i].saleNo + '</td>' +
			'<td>' + saleReadyPagingDTO.result[i].productNo + '</td>' +
			'<td>' + saleReadyPagingDTO.result[i].productCode + '</td>' +
			'<td>' + saleReadyPagingDTO.result[i].brandName + '</td>' +
			'<td>' + saleReadyPagingDTO.result[i].productCategory + '</td>' +
			'<td>' + saleReadyPagingDTO.result[i].productName + '</td>' +
			'<td>' + saleReadyPagingDTO.result[i].productPrice.toLocaleString() + '</td>' +
			'<td>' + '<input type="date" class="sellDate" value="' + (saleReadyPagingDTO.result[i].saleDate == null || saleReadyPagingDTO.result[i].saleDate == '' ? ymd : saleReadyPagingDTO.result[i].saleDate) + '">' + '</td>' +
			'<td>' + '<input type="checkbox" class="checking " ' + (saleReadyPagingDTO.result[i].checking ? 'checked' : '') + '>' + '</td>' +
			'</tr>';
		$("#saleReady").append(text);
	}

	$(".pagination").html('');
	$(".pagination").append('<li class="page-item ' + (saleReadyPagingDTO.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (saleReadyPagingDTO.startPage - 1) + '">Previous</a></li>');
	for (var i = saleReadyPagingDTO.startPage; i <= saleReadyPagingDTO.endPage; i++) {
		$(".pagination").append('<li class="page-item"><a class="page-link ' + (saleReadyPagingDTO.page == i ? 'active' : '') + '" href="' + i + '">' + i + '</a></li>');
	}
	$(".pagination").append('<li class="page-item ' + (saleReadyPagingDTO.next ? '' : 'disabled') + '"><a class="page-link" href="' + (saleReadyPagingDTO.endPage + 1) + '">Next</a></li>');
}

$.ajax({
	type: "post",
	url: "/qam/saleReady",
	success: function(result) {
		inint_Paing();
		saleReadyPagingDTO.result = result;
		saleReadyPagingDTO.setTotal(result.length);
		saleReadyPaingFuc();

	}
});

$(document).on('click', 'a.page-link', function(e) {
	e.preventDefault();

	const page = $(this).attr('href');
	saleReadyPagingDTO.offset = (page - 1) * saleReadyPagingDTO.limit;
	saleReadyPagingDTO.page = page;
	saleReadyPagingDTO.setTotal(saleReadyPagingDTO.result.length);

	saleReadyPaingFuc();
});

$(document).on('change', '.checking', (e) => {
	const idx = $(e.target).parent().parent().attr("id").split("_")[1];
	if ($(e.target).is(":checked")) {
		saleReadyPagingDTO.result[idx].checking = true;
	} else {
		saleReadyPagingDTO.result[idx].checking = false;
	}
	
});

$(document).on('input', '.sellDate', (e) => {

	const idx = $(e.target).parent().parent().attr("id").split("_")[1];
	saleReadyPagingDTO.result[idx].saleDate = e.target.value;
	
});

$(document).on('click', '#selectCurrentTable', function(e) {
	for (var i = saleReadyPagingDTO.offset; i < ((saleReadyPagingDTO.offset + saleReadyPagingDTO.limit) > saleReadyPagingDTO.result.length ? saleReadyPagingDTO.result.length : (saleReadyPagingDTO.offset + saleReadyPagingDTO.limit)); i++) {
		saleReadyPagingDTO.result[i].checking = true;
	}

	saleReadyPaingFuc();
});

$(document).on('click', '#selectAlldata', function(e) {
	for (var i = 0; i < saleReadyPagingDTO.result.length; i++) {
		saleReadyPagingDTO.result[i].checking = true;
	}
	saleReadyPaingFuc();
});
$(document).on('click', '#selectCancelCurrentTable', function(e) {
	for (var i = saleReadyPagingDTO.offset; i < ((saleReadyPagingDTO.offset + saleReadyPagingDTO.limit) > saleReadyPagingDTO.result.length ? saleReadyPagingDTO.result.length : (saleReadyPagingDTO.offset + saleReadyPagingDTO.limit)); i++) {
		saleReadyPagingDTO.result[i].checking = false;
	}

	saleReadyPaingFuc();
});

$(document).on('click', '#selectCancelAlldata', function(e) {
	for (var i = 0; i < saleReadyPagingDTO.result.length; i++) {
		saleReadyPagingDTO.result[i].checking = false;
	}
	saleReadyPaingFuc();
});

$(document).on('click', '#sellRegister', function(e) {
	var a = 0;
	const sellList = [];
	for (var i = 0; i < saleReadyPagingDTO.result.length; i++) {
		const obj = {};
		if (saleReadyPagingDTO.result[i].checking) {
			obj.saleNo = saleReadyPagingDTO.result[i].saleNo;
			if (saleReadyPagingDTO.result[i].saleDate == null || saleReadyPagingDTO.result[i].saleDate == '') {
				let today = new Date();

				let year = today.getFullYear();
				let month = String(today.getMonth() + 1).padStart(2, "0"); // 0부터 시작하므로 +1
				let day = String(today.getDate()).padStart(2, "0");

				let ymd = year + "-" + month + "-" + day;
				obj.saleDate = ymd;
			} else obj.saleDate = saleReadyPagingDTO.result[i].saleDate;
			sellList.push(obj);
		}
	}
	
	if (sellList.length == 0) {
		Swal.fire({
			title: "1개 이상의 제품을 선택해주세요!",
			confirmButtonText: '확인',
			width: 600,
			confirmButtonColor: "#90C67C",
			icon: "warning",
			iconColor: "green"
		});
	} else {
		Swal.fire({
			title: "등록하시겠습니까?",
			text: "총 " + sellList.length + "개의 상품을 선택하셨습니다!",
			confirmButtonText: '등록',
			confirmButtonColor: "green",
			icon: "question",
			iconColor: "green",
			showCancelButton: true,
			cancelButtonText: '취소',
			cancelButtonColor: "red"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type: "post", // .jsp에서 받아진 값을 DB로 보내기에 POST
					url: "/qam/registerSaleDate", // HSDController의 registerSaleDate(@RequestBody List<SaleReadyDTO> sellList)를 POST 호출, @PostMapping("/registerSaleDate")
					contentType: "application/json", // Ajax 요청을 보낼 때, 요청 본문(RequestBody)에 담긴 데이터가 JSON 형식임을 서버에 알리는 역할
					data: JSON.stringify(sellList), // sellList를 JSON'화'해두기 (HSDController의 registerSaleDate에서 @RequestBody로 JSON 데이터 Java 객체로 변환 예정)
					success: function(result) {

						let timerInterval;
						Swal.fire({
							icon: "success",
							iconColor: "green",
							title: "성공적으로 등록했습니다!",
							html: '<span id="aa"></span>초 후 자동으로 닫힙니다.',
							timer: 2000,
							timerProgressBar: true,
							didOpen: () => {
								Swal.showLoading();
								const timer = Swal.getPopup().querySelector("#aa");
								timerInterval = setInterval(() => {
									let remainSecond = parseInt(Swal.getTimerLeft() / 1000);
									timer.textContent = remainSecond + 1;
								}, 100);
							},
							willClose: () => {
								clearInterval(timerInterval);
							}
						}).then((result) => {
							/* Read more about handling dismissals below */
							if (result.dismiss == "backdrop") {
								location.reload();
							}
							if (result.dismiss === Swal.DismissReason.timer) {
								location.reload();
							}
						});
						//location.reload(); // 성공적으로 요청이 처리되면 페이지를 새로고침, saleDate가 등록된 제품(=판매 완료된 제품)은 리스트에서 사라지고, saleDate가 여전히 null인 제품만 화면에 남음	
					}
				});
			}
		});
	}
});
