<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
    <h1>테이블 열 추가/삭제 및 데이터 객체 리스트 생성 text</h1>
    <div id = "test">
        <button id = "btn2">addRowTest</button>
        <!-- <button id = "btn3">removeRowTest</button> -->
        <table border="1" id = "result">
            <tr>
                <th>아이디</th>
                <th>주민등록번호</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>직급</th>
                <th>부서</th>
                <th>입사일</th>
                <th>급여</th>
                <th>주소</th>
                <th>연락처</th>
                <th>이메일</th>
                <th>삭제</th>

            </tr>
           
            
        </table>
        <button id = "btn">rowToObjTest</button>
        
    </div>

    <script>
        var count = 0;
        function addRow() {
            $("#result").append('<tr></tr>');
            for(var i = 0; i < 11; i++) {
                if(i != 6) $("#result tr").eq(-1).append('<td><input type="text"></td>');
                else $("#result tr").eq(-1).append('<td><input type="date"></td>');
            }
            $("#result tr").eq(-1).append('<td><button class="btn4">rowToObjTest</button></td>');
        }

        $(document).on("click", ".btn4", function() {
            if($("#result tr").length > 2) $(this).parent().parent().remove();
        });

        addRow();

        $("#btn2").click(() => {
            
            addRow();
        });

        // $("#btn3").click(() => {
            // if($("#result tr").length > 2) $("#result tr").eq(-1).remove();
            // $("#result").append('<tr><th>a</th><th>b</th><th>c</th></tr>');
        // });

        $("#btn").click(() => {
            // const list2 = $("#result tr").eq(1).find("td").eq(0).find("input").val();
            const table = $("#result tr");
            const eiList = [];
            const formData = new FormData();
        	
            for(var i = 1; i < table.length; i++){
                const obj ={};
                for(var j = 0; j <11; j++) {
                	if(j === 0) formData.append("eiList["+ (i-1) +"].empId", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 1) formData.append("eiList["+ (i-1) +"].empIn", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 2) formData.append("eiList["+ (i-1) +"].empPwd", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 3) formData.append("eiList["+ (i-1) +"].empName", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 4) formData.append("eiList["+ (i-1) +"].jobNo", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 5) formData.append("eiList["+ (i-1) +"].deptNo", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 6) formData.append("eiList["+ (i-1) +"].hireDate", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 7) formData.append("eiList["+ (i-1) +"].salary", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 8) formData.append("eiList["+ (i-1) +"].addr", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 9) formData.append("eiList["+ (i-1) +"].phone", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                	if(j === 10) formData.append("eiList["+ (i-1) +"].email", $("#result tr").eq(i).find("td").eq(j).find("input").val());
                }
            }
            /*
            $.ajax({
                // 요청
                type : "post",
                url : "/empAdd",
                data : formData,
				processData: false,
				contentType : false,
                // 응답
                success : function(result) {
					//$("#result").text("");
                	// $("#result").append("<tr><th>이름</th><th>직급</th><th>부서</th></tr>");
                	// for(const emp of result) {
					// var text = "<tr><td>"+ emp.empName +"</td><td>"+emp.jobTitle+"</td><td>"+emp.deptName+"</td></tr>"
					// $("#result").append(text);
                	
                	//}
                },
                
				error:function(xhr,status,error) {
					
				}
            });
        });*/


    </script>
</body>
</html>