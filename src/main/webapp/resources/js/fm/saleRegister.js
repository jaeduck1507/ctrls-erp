$(document).ready(() => {
	const now = new Date();
	const today = now.getFullYear() + '-' 
	                    + String(now.getMonth() + 1).padStart(2, '0') + '-' 
	                    + String(now.getDate()).padStart(2, '0');
	//console.log(today);
	
	$("#saleDate").val(today);
	console.log($("#saleDate").val());
});

$("#search").click(() => {
	const formData = new FormData();
	formData.append("saleDate", $("#saleDate").val());
	console.log($("#saleDate").val());
	
	$.ajax({
		type: "post",
		url: "/dailySale",
		data: formData,
		processData: false,
		contentType: false,
		success: function(result) {
			if (!result || result.length === 0) {
				$("#sale-register").prop("disabled", true);
				//alert("조회된 결과가 없습니다");
				//location.reload();
				Swal.fire({
					position: "top",
					icon: "error",
					title: "조회된 결과가 없습니다!",
					showConfirmButton: false,
					timer: 1500
				});
				return;
			} else {
				$("#sale-register").prop("disabled", false);
			}
			
			$("#result").html("");
			$("#result").append("<tr><th>상품명</th><th>상품 코드</th><th>가격</th><th>수량</th><th>부가세</th><th>총액</th><th>매출 발생일자</th></tr>");
			for (const sale of result) {
				const totalAmount = sale.productPrice * sale.quantity;
				const varAmount = Math.floor(totalAmount - (totalAmount / 1.1));
				$("#result").append("<tr><td>" + sale.productName + "</td><td>" +sale.productCode + "</td><td>" + sale.productPrice + "</td><td>" + sale.quantity + "</td><td>" + varAmount + "</td><td>" + totalAmount + "</td><td>" + $("#saleDate").val() + "</td></tr>");
			}
		}
	});
});

$("#sale-register").click(() => {
	const table = $("#result tr");
	const smList = [];
	
	for (var i = 1; i < table.length; i++) {
		const obj ={};
		obj.productCode=$("#result tr").eq(i).find("td").eq(1).text();
		obj.quantity=$("#result tr").eq(i).find("td").eq(3).text();
		obj.varAmount=$("#result tr").eq(i).find("td").eq(4).text();
		obj.totalAmount=$("#result tr").eq(i).find("td").eq(5).text();
		obj.saleDate=$("#result tr").eq(i).find("td").eq(6).text();
		
		smList.push(obj);
	}
	console.log(JSON.stringify(smList));
	console.log(smList.length);
	
	Swal.fire({
		title: "등록하시겠습니까?",
		text: "총 " + smList.length + "개의 내역이 등록됩니다!",
		icon: "question",
		iconColor: "#8de664",
		showCancelButton: true,
		confirmButtonColor: "#48b85b",
		cancelButtonColor: "#d33",
		confirmButtonText: "등록",
		cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					type : "post",
					url: "/saleRegister",
					dataType : "json",
					data : JSON.stringify(smList),
					processData: false,
					contentType: 'application/json; charset=UTF-8',
					success: function(response) {
						if (response) {
							Swal.fire({
								title: "등록 완료!",
								text: "성공적으로 등록되었습니다.",
								icon: "success",
								iconColor: "#48b85b",
								confirmButtonColor: "#48b85b",
								timer: 3000,
								timerProgressBar: true,
								didClose: () => {
									location.reload();
								}
							});
						}
					},
					error: function(xhr, status, error) {
						
					}
				});
			}
		});
});