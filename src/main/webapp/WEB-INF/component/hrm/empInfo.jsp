<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원정보조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
	<h1>사원정보조회</h1>
	<div id = "search">
	이름 : <input type="text" id="empName">
		<select id = "deptName">
				<option value="-1">부서 선택</option>
				
		</select>
		
		<select id = "jobTitle">
				<option value="-1">직급 선택</option>
				
		</select>
		<button id = "btn">검색</button>
	</div>
	<div>
	
	<table border="1" id = "result" >
	</table>
	</div>
	
	<nav>
		<ul class="pagination">
		</ul>
	</nav>
	</div>
	
	
	
	<script>
		
		
		
		$(document).ready(() => { // 페이지 로드 되자마자 실행되는 함수
			$.ajax({
                // 요청
                type : "get",
                url : "/showDept",
                
                // 응답
                success : function(result) {
                    for(const i of result) {
						var text = '<option value="'+ i.deptNo +'">'+ i.deptName +'</option>';
						console.log(text);
                    	$("#deptName").append(text);
                    	
                    }
                },
                
				error:function(xhr,status,error) {
					
				}
            });
			$.ajax({
                // 요청
                type : "get",
                url : "/showJob",
                // 응답
                success : function(result) {
                	for(const i of result) {
						var text = '<option value="'+ i.jobNo +'">'+ i.jobTitle +'</option>';
						console.log(text);
                    	$("#jobTitle").append(text);
                    	
                    }
                },
                
				error:function(xhr,status,error) {
					
				}
            });
		});	
	
		const pagingDto ={};
		
        $("#btn").click(() =>{
        	const formData = new FormData();
        	formData.append("empName", $('#empName').val());
        	formData.append("jobNo",$('#jobTitle').val());
        	formData.append("deptNo", $('#deptName').val());
            $.ajax({
                // 요청
                type : "post",
                url : "/infoShow",
                data : formData,
				processData: false,
				contentType : false,
                // 응답
                success : function(result) {
					//테이블 생성
					$("#result").html("");
                	$("#result").append("<tr><th>이름</th><th>직급</th><th>부서</th><th>수정</th></tr>");
                	for(const emp of result.empInfoList) {
					var text = "<tr><td>"+ emp.empName +"</td><td>"+emp.jobTitle+"</td><td>"+emp.deptName+'</td><td><a href="/hrm/empModify?empNo=' + emp.empNo + '">수정</a></td></tr>'
					$("#result").append(text);
                	
					// 페이징 생성
                	}
                	$(".pagination").html('');
                	$(".pagination").append('<li class="page-item ' + (result.hrmPagingDTO.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.hrmPagingDTO.startPage - 1) + '">Previous</a></li>');
                	for(var i =result.hrmPagingDTO.startPage; i<=result.hrmPagingDTO.endPage; i++) {
                		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.hrmPagingDTO.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
                	}
                	$(".pagination").append('<li class="page-item ' + (result.hrmPagingDTO.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.hrmPagingDTO.endPage + 1) + '">Next</a></li>');
                },
                
				error:function(xhr,status,error) {
					
				}
            });
        });
        
        $(document).on('click', 'a.page-link', function(e) {
            e.preventDefault();        
            // a 태그 기본 동작(페이지 이동) 차단
            const formData = new FormData();
        	formData.append("empName", $('#empName').val());
        	formData.append("jobNo",$('#jobTitle').val());
        	formData.append("deptNo", $('#deptName').val());
        	formData.append("page",$(this).attr('href'));
                
        	// 링크 URL 읽기
			
        	$.ajax({
                // 요청
                type : "post",
                url : "/infoShow",
                data : formData,
				processData: false,
				contentType : false,
                // 응답
                success : function(result) {
					//테이블 생성
					$("#result").html("");
                	$("#result").append("<tr><th>이름</th><th>직급</th><th>부서</th><th>수정</th></tr>");
                	for(const emp of result.empInfoList) {
					var text = "<tr><td>"+ emp.empName +"</td><td>"+emp.jobTitle+"</td><td>"+emp.deptName+'</td><td><a href="/hrm/empModify?empNo=' + emp.empNo + '">수정</a></td></tr>'
					$("#result").append(text);
                	
					// 페이징 생성
                	}
                	$(".pagination").html('');
                	$(".pagination").append('<li class="page-item ' + (result.hrmPagingDTO.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (result.hrmPagingDTO.startPage - 1) + '">Previous</a></li>');
                	for(var i =result.hrmPagingDTO.startPage; i<=result.hrmPagingDTO.endPage; i++) {
                		$(".pagination").append('<li class="page-item"><a class="page-link ' + (result.hrmPagingDTO.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
                	}
                	$(".pagination").append('<li class="page-item ' + (result.hrmPagingDTO.next ? '' : 'disabled') + '"><a class="page-link" href="' + (result.hrmPagingDTO.endPage + 1) + '">Next</a></li>');
                },
                
				error:function(xhr,status,error) {
					
				}
            });
          });
    </script>
</body>
</html>