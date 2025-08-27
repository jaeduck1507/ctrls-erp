<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사원 정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[인적자원관리] > [사원정보조회] > [사원정보수정]</h5>
		<h3>사원정보수정</h3>



<form action="/empModify" method="post">
	<div class="box filter-bar">
	<table>
    <tr><th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;사번<th><td><input type="text" name="empNo" value="${empInfo.empNo}" readonly="readonly" id="empNo"></td><tr>
    <tr><th><i class="fi fi-rr-letter-case"></i>&nbsp;&nbsp;성명<th><td><input type="text" name="empName" value="${empInfo.empName}"></label><br>
    <tr><th><i class="fi fi-rr-hastag"></i>&nbsp;&nbsp;주민등록번호<th><td><input type="text" name="empIn" value="${empInfo.empIn}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-sitemap"></i>&nbsp;&nbsp;직급<th><td><input type="text" name="jobTitle" value="${empInfo.jobTitle}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-department"></i>&nbsp;&nbsp;부서<th><td><input type="text" name="deptName" value="${empInfo.deptName}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;입사일<th><td><input type="date" name="hireDate" value="${empInfo.hireDate}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;퇴사일<th><td><input type="date" name="quitDate" value="${empInfo.quitDate}" readonly="readonly"></td><tr>
    <tr><th><i class="fi fi-rr-home-location-alt"></i>&nbsp;&nbsp;주소<th><td><input type="text" name="addr" value="${empInfo.addr}"></td><tr>
    <tr><th><i class="fi fi-rr-phone-call"></i>&nbsp;&nbsp;연락처<th><td><input type="text" name="phone" value="${empInfo.phone}"></td><tr>
    <tr><th><i class="fi fi-rr-envelope"></i>&nbsp;&nbsp;이메일<th><td><input type="text" name="email" value="${empInfo.email}"></td><tr>
	</table>
	</div>
	<div class="filter-bar">
    <button type="submit">수정</button>
	<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#updateModal" id="quitBtn">직급/부서 변경</button>
	</div>
</form>

		<div class="modal fade filter-bar" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">퇴직 처리</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
			  
			  <div class="modal-body">
					<select id="job">
					<option value="-1" disabled selected>직무 선택</option>
					<c:forEach items="${jobPosition}" var="job">
					<option value="${job.jobNo}">${job.jobTitle}</option>
					</c:forEach>
					</select>
					<select id="dept">
					<option value="-1" disabled selected>부서 선택</option>
					<c:forEach items="${department}" var="dept">
					<option value="${dept.deptNo}">${dept.deptName}</option>
					</c:forEach>
					</select>
			  </div>
		      <div class="modal-footer">
		      	<p>퇴사 처리시 변경 불가능 합니다</p>
		        <button type="button" class="btn" data-bs-dismiss="modal">닫기</button>
		        <button type="button" class="btn" id ="modifyJobDept">등록</button>
		      </div>
			  
		    </div>
		  </div>
		</div>


<script>
$("#modifyJobDept").click(() => { // 열 추가 버튼 클릭시 열 추가 함수 addRow 함수 실행

	Swal.fire({
		title: "변경하시겠습니까?",
		confirmButtonText: '등록',
		confirmButtonColor: "green",
		icon: "question",
		iconColor: "green",
		showCancelButton: true,
		cancelButtonText: '취소',
		cancelButtonColor: "red"
		}).then((result) => {
			  if (result.isConfirmed) {
				  	console.log($("#job").val());
				    console.log($("#dept").val());
				    console.log($("#empNo").val());
				    const obj = {};
				    obj.deptNo = $("#dept").val();
				    obj.jobNo = $("#job").val();
				    obj.empNo = $("#empNo").val();
				    $.ajax({
				        // 요청
				        type : "post",
				        url : "/modifyJobDept",
				        dataType : "json", 
				        data : JSON.stringify(obj),
						processData: false,
						contentType: 'application/json; charset=UTF-8',
						
				        // 응답
				        success : function(result) {
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
									let remainSecond = parseInt(Swal.getTimerLeft() / 1000) ;
							      timer.textContent = remainSecond +1;
							    }, 100);
							  },
							  willClose: () => {
							    clearInterval(timerInterval);
							  }
							}).then((result) => {
							  /* Read more about handling dismissals below */
							  if(result.dismiss == "backdrop") {
								  location.reload();
							  }
							  if (result.dismiss === Swal.DismissReason.timer) {
								  location.reload();
							  }
							});
				        },
				        
						error:function(xhr,status,error) {
							
						}
				    });
				 
				  }
				});
    
    
    
    
});

</script>
</body>

</html>
