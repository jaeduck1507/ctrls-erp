<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용 선언 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 정보 조회</title> <!-- 페이지 제목 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>

<body>
<h5>[품질 관리] > [제품 정보 조회]</h5>
<h3>제품 정보 조회</h3>
<div class="filter-bar">
<!-- 제품명 신규 등록 버튼 -->
<a href="/productNameForm">
제품 신규 등록
</a>

<!-- 검색창: 제품명 + 카테고리 -->
<form action="productName">
    제품명 : <input type="text" name="productName" id="productName" />
    <select name="productCategory" id="productCategory">
        <option value="">카테고리</option>
        <option value="상의">상의</option>
        <option value="하의">하의</option>
        <option value="악세사리">악세사리</option>
        <option value="신발">신발</option>
    </select>
    <button type="submit">검색</button> <!-- 검색 버튼 -->
</form>
</div>
<!-- 검색 및 전체 조회 결과 출력 테이블 -->
<table border="1" id="result" class="data-table">
	<tr>
		<th>제품 코드</th>
		<th>브랜드코드</th>
		<th>브랜드</th>
		<th>카테고리</th>
		<th>색상</th>
		<th>제품명</th>
		<th>판매가</th>
		<th>단가</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	
	<c:forEach items="${productNameList}" var="pn">
	    <tr>
	        <td>${pn.productCode}</td>
	        <td>${pn.brandCode}</td>
	        <td>${pn.brandName}</td>
	        <td>${pn.productCategory}</td>
	        <td>${pn.productColor}</td>
	        <td>${pn.productName}</td>
	        <td>${pn.productPrice}</td>
	        <td>${pn.productCost}</td>
	        <td><a href='/productNameForm?productCode=${pn.productCode}' class="btnO">수정</a></td>
	        <td>
	            <a href='/deleteProductName?productCode=${pn.productCode}' class="btnX">삭제</a>
	        </td>
	    </tr>
	</c:forEach>
	
</table>

<nav>
    <ul class="pagination">
		<li class="page-item ${paging.prev ? '' : 'disabled'}"><a class="page-link" href="/qam/productName?page=${paging.startPage - 1}&productName=${productName}&productCategory=${productCategory}">Previous</a></li>			
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
					<li class="page-item"><a class="page-link ${paging.page == page ? 'active' : ''}" href="/qam/productName?page=${page}&productName=${productName}&productCategory=${productCategory}">${page}</a></li>
				</c:forEach>
		<li class="page-item ${paging.next ? '' : 'disabled'}"><a class="page-link" href="/qam/productName?page=${paging.endPage + 1}&productName=${productName}&productCategory=${productCategory}">Next</a></li>
    </ul>
</nav>

<script>
	$(document).on('click', 'a.btnX', function(e) {
		e.preventDefault();
		
		Swal.fire({
			title: "정말 삭제하시겠습니까?",
			text: "삭제를 누르면 해당 항목이 영구적으로 삭제됩니다.",
			icon: "warning",
			iconColor: "#f1a025",
			showCancelButton: true,
			confirmButtonColor: "#48b85b",
			cancelButtonColor: "#d33",
			confirmButtonText: "삭제",
			cancelButtonText: "취소"
		}).then((result) => {
			if (result.isConfirmed) {
				Swal.fire({
					title: "삭제 완료!",
					text: "성공적으로 삭제되었습니다.",
					icon: "success",
					iconColor: "#48b85b",
					confirmButtonColor: "#48b85b",
					timer: 3000,
					timerProgressBar: true,
					didClose: () => {
						location.href = $(this).attr("href");
					}
				});
			}
		});
	});
/*
    $(document).ready(function() {

        // 검색 폼 제출 시 AJAX 요청
        $("#searchForm").submit(function (e) {
            e.preventDefault(); // form 기본 제출 막기

            $.ajax({
                type: "get",
                url: "/searchProductName", // 검색 요청 URL
                data: {
                    productName: $("#productName").val(),
                    productCategory: $("#productCategory").val()
                },
                success: function (result) {
                    // 결과 테이블 초기화 후 헤더 생성
                    $("#result").html("");
                    $("#result").append("<tr><th>제품 코드</th><th>브랜드코드</th><th>브랜드</th><th>카테고리</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>수정</th><th>삭제</th></tr>");
                    // 데이터 순회하며 행 생성
                    for (const pn of result) {
                        let row = "<tr><td>" + pn.productCode + "</td><td>" + pn.brandCode + "</td><td>" + pn.brandName + "</td><td>" + pn.productCategory + "</td><td>" + pn.productColor + "</td><td>" + pn.productName + "</td><td>" + pn.productPrice + "</td><td>" + pn.productCost + "</td>";
                        row += "<td><a href='/productNameForm?productCode=" + pn.productCode + "' class="btnO">수정</a></td>";
                        row += "<td><a href='/deleteProductName?productCode=" + pn.productCode + "' onclick='return confirm(\"정말 삭제하시겠습니까?\")' class="btnX">삭제</a></td></tr>";
                        $("#result").append(row);
                    }
					
					// 페이징 생성
					$(".pagination").html('');
					$(".pagination").append('<li class="page-item ' + (result.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.startPage - 1) + '">Previous</a></li>');
					for(var i =result.startPage; i<=result.endPage; i++) {
						$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
					}
					$(".pagination").append('<li class="page-item ' + (result.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.endPage + 1) + '">Next</a></li>');
                }
            });
        });

        // 페이지 로딩 시 전체 제품명 목록 조회
        $.ajax({
            type: "get", 
            url: "/showProductName", // 전체 조회 URL
            success: function(result) {
                // 테이블 초기화 + 헤더 생성
                $("#result").html(""); 
                $("#result").append("<tr><th>제품 코드</th><th>브랜드코드</th><th>브랜드</th><th>카테고리</th><th>색상</th><th>제품명</th><th>판매가</th><th>단가</th><th>수정</th><th>삭제</th></tr>");

                // 각 제품명 객체를 테이블에 추가
                for (const pn of result) {
                    let row = "<tr>";
                    row += "<td>" + pn.productCode + "</td>";
					row += "<td>" + pn.brandCode + "</td>";
					row += "<td>" + pn.brandName + "</td>";
					row += "<td>" + pn.productCategory + "</td>";
                    row += "<td>" + pn.productColor + "</td>";
                    row += "<td>" + pn.productName + "</td>";
                    row += "<td>" + pn.productPrice + "</td>";
                    row += "<td>" + pn.productCost + "</td>";
                    row += "<td><a href='/productNameForm?productCode=" + pn.productCode + "'>수정</a></td>";
                    row += "<td><a href='/deleteProductName?productCode=" + pn.productCode + "' onclick='return confirm(\"정말 삭제하시겠습니까?\")'>삭제</a></td>";
                    row += "</tr>";
                    $("#result").append(row);
                }
            },
            error: function(xhr, status, error) {
                // 오류 발생 시 처리 (필요 시 알림 등)
            }
        });
    });
    */
</script>

</body>
</html>
