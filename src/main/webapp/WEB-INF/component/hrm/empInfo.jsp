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
	<h1>사원정보조회</h1>
	<div id = "search">
	이름 : <input type="text" id="empName">
		<select id = "deptName">
				<option value="a">부서 선택</option>
				
		</select>
		
		<select id = "jobTitle">
				<option value="a">부서 선택</option>
				
		</select>
		<button id = "btn">검색</button>
	</div>
	<div>
	
	<table border="1" id = "result" >
	</table>
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
						var text = '<option value="'+ i.deptName +'">'+ i.deptName +'</option>';
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
						var text = '<option value="'+ i.jobTitle +'">'+ i.jobTitle +'</option>';
						console.log(text);
                    	$("#jobTitle").append(text);
                    	
                    }
                },
                
				error:function(xhr,status,error) {
					
				}
            });
		});	
	
        $("#btn").click(() =>{

        	const formData = new FormData();
        	formData.append("empName", $('#empName').val());
        	formData.append("jobTitle",$('#jobTitle').val());
        	formData.append("deptName", $('#deptName').val());
            $.ajax({
                // 요청
                type : "post",
                url : "/infoShow",
                data : formData,
				processData: false,
				contentType : false,
                // 응답
                success : function(result) {
					//$("#result").text("");
                	$("#result").append("<tr><th>이름</th><th>직급</th><th>부서</th></tr>");
                	for(const emp of result) {
					var text = "<tr><td>"+ emp.empName +"</td><td>"+emp.jobTitle+"</td><td>"+emp.deptName+"</td></tr>"
					$("#result").append(text);
                	
                	}
                },
                
				error:function(xhr,status,error) {
					
				}
            });
        });
    </script>
</body>
</html>