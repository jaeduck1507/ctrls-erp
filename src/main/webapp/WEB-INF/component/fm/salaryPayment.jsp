<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salaryRegister</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<style>
	td {
		position: relative;
		box-sizing: border-box;
	}

	.red {
		border-color: red;
		border-width: 2px;
	}

	table {
	  border-collapse: separate;  
	}
</style>
</head>
<body>
	<h5>[재무 관리] > [급여 등록]</h5>
	<h3>급여 등록</h3>
	<div id="search" class="filter-bar">
		<input type="month" id = "yearMonth">
		<button id="btn">조회</button>
	</div>
		
	<div>	
		<div class="filter-bar">
			<table border="1" id="result" class="data-table">
					
			</table>
			
		</div>
		
		<nav>
			<ul class="pagination">
			</ul>
		</nav>
		
	</div>
	
	<script>
		const deductionCheck = /^[1-9]\d*$/;
		$(document).on("input", ".deduction", (e) => {
			console.log(e.target.value);
			console.log(deductionCheck.test(e.target.value));
			
			if (!deductionCheck.test(e.target.value)) {
				e.target.parentElement.classList.add("red");
				$("#submit").prop("disabled", true);
			} else {
				e.target.parentElement.classList.remove("red");
				$("#submit").prop("disabled", false);
			}
		});
	
		var salayPagingDTO = {};
		function inint_Paing() {
		salayPagingDTO = { 
				offset: 0,
		        limit: 10,
		        page: 1,
		        pageSize: 10,
		        endPage: this.pageSize,
		        startPage: this.endPage - this.pageSize + 1,
		        prev : false,
		        next : false,
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
		
		$("#btn").click(() => {
			const yearMonth = $("#yearMonth").val();
			if(yearMonth) {
				$.ajax({
					type: "post",
					url: "/salaryPayment",
					data: {yearMonth : yearMonth},
					
					success: function(result) {
						inint_Paing();
						salayPagingDTO.result = result;
						salayPagingDTO.setTotal(result.length);
						
						if (result.length !== 0) {
							$("#submit").prop("disabled", false);
						}
						
						$("#result").html("");
						$("#result").append("<tr><th>직원 번호</th><th>직원 이름</th><th>부서명</th><th>직급명</th><th>지급일</th><th>기본급</th><th>보너스</th><th>공제금</th><th>급여 총액</th></tr>");
						for (var i = salayPagingDTO.offset;   i < ((salayPagingDTO.offset + salayPagingDTO.limit) > salayPagingDTO.result.length ? salayPagingDTO.result.length: (salayPagingDTO.offset + salayPagingDTO.limit) ); i++) {
							var deduction =0;
							if(salayPagingDTO.result[i].deduction == 0) {
								deduction = (Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus))*0.1;
								salayPagingDTO.result[i].deduction = deduction;
							} else {
								deduction = salayPagingDTO.result[i].deduction;
							}
							
							var text = '<tr id="index_'+ i +'"><td>' + salayPagingDTO.result[i].empNo + "</td><td>" + salayPagingDTO.result[i].empName + "</td><td>" + salayPagingDTO.result[i].deptName + "</td><td>" 
								+ salayPagingDTO.result[i].jobTitle + "</td><td>" + (yearMonth +'-15') + "</td><td>" + salayPagingDTO.result[i].baseSalary + "</td><td>" + salayPagingDTO.result[i].bonus + "</td><td>" 
								+ '<input type="number" min="0" class= "deduction" value="'+ deduction +'">' +"</td><td>" + ((Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus)-deduction)) + "</td></tr>";
							$("#result").append(text);
						}
						$("#result").append('<div class="filter-bar"><button id="submit">등록하기</button></div>');
						
						$(".pagination").html('');
	                	$(".pagination").append('<li class="page-item ' + (salayPagingDTO.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (salayPagingDTO.startPage - 1) + '">Previous</a></li>');
	                	for(var i =salayPagingDTO.startPage; i<=salayPagingDTO.endPage; i++) {
	                		$(".pagination").append('<li class="page-item"><a class="page-link ' + (salayPagingDTO.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
	                	}
	                	$(".pagination").append('<li class="page-item ' + (salayPagingDTO.next ? '' : 'disabled') + '"><a class="page-link" href="' + (salayPagingDTO.endPage + 1) + '">Next</a></li>');
					},
					error: function(xhr, status, error) {
								
					}
				});
				
			} else {
				alert("월을 입력해주세요");
				location.reload();
			}
		});	
		$(document).on('input', '.deduction', (e) => {
				const indexNum = $(e.target).parent().parent().attr("id").split("_")[1];
				console.log(indexNum);
				const deduction = $(e.target).val();
				const salaryDate = $(e.target).parent().parent().find("td").eq(4).text();
				const baseSalary = $(e.target).parent().parent().find("td").eq(5).text();
				const bonus = $(e.target).parent().parent().find("td").eq(6).text();
				const total = Number(baseSalary) + Number(bonus) - deduction;
				salayPagingDTO.result[Number(indexNum)].deduction = deduction;
				salayPagingDTO.result[Number(indexNum)].baseSalary = baseSalary;
				salayPagingDTO.result[Number(indexNum)].bonus = bonus;
				salayPagingDTO.result[Number(indexNum)].salaryDate = salaryDate;
				console.log(salayPagingDTO.result[Number(indexNum)].bonus);
				$(e.target).parent().parent().find("td").eq(8).html("");
				$(e.target).parent().parent().find("td").eq(8).text(total);
			});
		
		$(document).on('click', 'a.page-link', function(e) {
            e.preventDefault();        
           
            // a 태그 기본 동작(페이지 이동) 차단
            
            const yearMonth = $("#yearMonth").val();
        	const page = $(this).attr('href');
        	salayPagingDTO.offset = (page - 1) * salayPagingDTO.limit;
        	salayPagingDTO.page = page;
        	salayPagingDTO.setTotal(salayPagingDTO.result.length);
                
        	// 링크 URL 읽기
			
        	
        		$("#result").html("");
				$("#result").append("<tr><th>직원 번호</th><th>직원 이름</th><th>부서명</th><th>직급명</th><th>지급일</th><th>기본급</th><th>보너스</th><th>공제금</th><th>급여 총액</th></tr>");
				for (var i = salayPagingDTO.offset;   i < ((salayPagingDTO.offset + salayPagingDTO.limit) > salayPagingDTO.result.length ? salayPagingDTO.result.length: (salayPagingDTO.offset + salayPagingDTO.limit) ); i++) {
					var deduction =0;
					if(salayPagingDTO.result[i].deduction ==0) {
						deduction = (Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus))*0.1;
						salayPagingDTO.result[i].deduction = deduction;
					} else {
						deduction = salayPagingDTO.result[i].deduction;
					}
					
					var text = '<tr id="index_'+ i +'"><td>' + salayPagingDTO.result[i].empNo + "</td><td>" + salayPagingDTO.result[i].empName + "</td><td>" + salayPagingDTO.result[i].deptName + "</td><td>" 
						+ salayPagingDTO.result[i].jobTitle + "</td><td>" + (yearMonth +'-15') + "</td><td>" + salayPagingDTO.result[i].baseSalary + "</td><td>" + salayPagingDTO.result[i].bonus + "</td><td>" 
						+ '<input type="number" min="0" class= "deduction" value="'+ deduction +'">' +"</td><td>" + ((Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus)-deduction)) + "</td></tr>";
					$("#result").append(text);
					console.log(i + " : " + ((Number(salayPagingDTO.result[i].baseSalary)+Number(salayPagingDTO.result[i].bonus))*0.1));
				}
				$("#result").append('<div class="filter-bar"><button id="submit">등록하기</button></div>');
				
				$(".pagination").html('');
            	$(".pagination").append('<li class="page-item ' + (salayPagingDTO.prev ? '' : 'disabled') + '"><a class="page-link" href="' + (salayPagingDTO.startPage - 1) + '">Previous</a></li>');
            	for(var i =salayPagingDTO.startPage; i<=salayPagingDTO.endPage; i++) {
            		$(".pagination").append('<li class="page-item"><a class="page-link ' + (salayPagingDTO.page == i ? 'active' : '') + '" href="' + i +'">' + i + '</a></li>');
            	}
            	$(".pagination").append('<li class="page-item ' + (salayPagingDTO.next ? '' : 'disabled') + '"><a class="page-link" href="' + (salayPagingDTO.endPage + 1) + '">Next</a></li>');
                
                
           
          });
		
		$("#submit").click(() => { // 제출 버튼
			const yearMonth = $("#yearMonth").val();
	        const table = $("#result tr"); // 테이블 정보 획득
	        const spList = []; // 객체를 담을 배열
	    	
	        for(var r of salayPagingDTO.result){ // i가 1부터 시작하는 이유는 첫번째 열은 th(열의 설명)부분이라 데이터가 아님
	            const obj ={}; // 직원 하나당 하나의 객체로 생성
	            /*
	            obj.empNo=$("#result tr").eq(i).find("td").eq(0).text(); 
	            obj.salaryDate=$("#result tr").eq(i).find("td").eq(4).text(); 
	            obj.baseSalary=$("#result tr").eq(i).find("td").eq(5).text(); 
	            obj.bonus=$("#result tr").eq(i).find("td").eq(6).text(); 
	            obj.deduction=$("#result tr").eq(i).find("td").eq(7).find("input").val(); 
	            */
	            
	            obj.empNo= r.empNo;
	            obj.salaryDate= yearMonth +'-15';
	            obj.baseSalary= r.baseSalary;
	            obj.bonus=r.bonus;
	            
	            var deduction =0;
				if(r.deduction == 0) {
					deduction = (Number(r.baseSalary)+Number(r.bonus))*0.1;
					r.deduction = deduction;
				} else {
					deduction = r.deduction;
				}
	            
	            obj.deduction=r.deduction
	            
	            
	            spList.push(obj); // 정보 저장한 객체를 배열에 삽입
	        }
	        console.log(spList);
	        
	        $.ajax({
	            // 요청
	            type : "post",
	            url : "/addSalaryPayment",
	            dataType : "json", // dataType 지정해줘야 자바에서 인식하는 듯?
	            data : JSON.stringify(spList), // json문자열로 변환해서 전송
				processData: false,
				contentType: 'application/json; charset=UTF-8', // formData에서는 false였으나 여기서는 contentType을 지정해줘야함
	            // 응답
	            success : function(result) {
					if(result) {
						alert("정상적으로 처리되었습니다!");
						location.reload();
					}
	            },
	            
				error:function(xhr,status,error) {
					
				} 
	        });
	        
	        
	        
	        
	    });
	</script>
</body>
</html>