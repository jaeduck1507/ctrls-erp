<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원정보조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="../resources/css/empEval.css"/>
</head>
<body>
	<h5>[인적자원관리] > [인사 성과/평가]</h5>
	<h3>${year}년 인사 성과/평가</h3>
	<div id="filter-bar">
	<input type="hidden" value="${user.empNo}" id="empNo">

	<select id="emp">
		<option value="-1" id="evaluated">평가할 사원 선택</option>
		<c:forEach items="${empInfo}" var="emp">
		<option value="${emp.empNo}">${emp.empName} / ${emp.jobTitle} / ${emp.deptName}</option>
		</c:forEach>
	</select>

	 <fieldset>
	    <legend>태도 평가 점수</legend>
	    <label><input type="radio" name="attitudeScore" value="1">1점</label>
	    <label><input type="radio" name="attitudeScore" value="2">2점</label>
	    <label><input type="radio" name="attitudeScore" value="3">3점</label>
	    <label><input type="radio" name="attitudeScore" value="4">4점</label>
	    <label><input type="radio" name="attitudeScore" value="5" checked="checked">5점</label>
	  </fieldset>

	<fieldset>
	    <legend>성과 점수</legend>
	    <label><input type="radio" name="achieveScore" value="1">1점</label>
	    <label><input type="radio" name="achieveScore" value="2">2점</label>
	    <label><input type="radio" name="achieveScore" value="3">3점</label>
	    <label><input type="radio" name="achieveScore" value="4">4점</label>
	    <label><input type="radio" name="achieveScore" value="5" checked="checked">5점</label>
	  </fieldset>
	  <div>
	<input type="text" id="comments" placeholder="기타 사항"><br>
	
	<button id = "btn">제출</button>
	</div>
	</div>
	
	
	
	<script>
	$("#btn").click(() => {
		
		const pr = {};
		
		pr.empNo = $("#empNo").val();
		pr.evaluatorEmpNo = $("#emp").val();
		pr.attitudeScore = $('input[name="attitudeScore"]:checked').val();
		pr.achieveScore = $('input[name="achieveScore"]:checked').val();
		pr.comments = $("#comments").val();
		console.log(pr);
		if(pr.evaluatorEmpNo == -1) {
			Swal.fire({
				title: "평가할 사원을 선택해주세요!!",
				confirmButtonText: '확인',
				width: 600,
				confirmButtonColor: "#90C67C",
				icon: "warning",
				iconColor: "green"
				});
		} else{
			Swal.fire({
				title: "등록하시겠습니까?",
				text: $("#emp option:selected").text().split(" / ")[0] + " 사원님의 평가를 작성하였습니다." ,
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
					            // 요청
					            type : "post",
					            url : "/empEval",
					            dataType : "json",
					            data : JSON.stringify(pr),
								contentType : 'application/json',
					            // 응답
					            success : function(result) {
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
		}
		/*
		$.ajax({
            // 요청
            type : "post",
            url : "/empEval",
            dataType : "json",
            data : JSON.stringify(pr),
			processData: false,
			contentType : 'application/json; charset=UTF-8',
            // 응답
            success : function(result) {
				//$("#result").text("");
            	
            	
            	
            },
            
			error:function(xhr,status,error) {
				
			}
        });
		*/
		// location.reload();
	});
		
		
		
    </script>
</body>
</html>