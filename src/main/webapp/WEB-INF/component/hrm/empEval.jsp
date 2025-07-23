<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원정보조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>인사 평가</h1>
	<div>
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
	
	기타 사항 : <input type="text" id="comments"><br>
	<button id = "btn">제출</button>
	</div>
	
	
	
	<script>
	$("#btn").click(() => {
		
		const pr = {};
		
		pr.empNo = 1;
		pr.evaluatorEmpNo = $("#emp").val();
		pr.attitudeScore = $('input[name="attitudeScore"]:checked').val();
		pr.achieveScore = $('input[name="achieveScore"]:checked').val();
		pr.comments = $("#comments").val();
		console.log(pr);
		
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
	});
		
		
		
    </script>
</body>
</html>