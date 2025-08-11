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
    <h1>테이블 열 추가/삭제 (사원 등록) 관리자</h1>
    <div id = "test" class="data-table">
        <button id = "btn2">열 추가</button>
        <!-- <button id = "btn3">removeRowTest</button> -->
        <table border="1" id = "result" >
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
        <button id = "btn">사원 등록</button>
        
    </div>

	
	
    <script>
    
        function addRow() { // 열 추가 함수
            $("#result").append('<tr></tr>'); // 기본 열 추가
            for(var i = 0; i < 11; i++) { // 열에 데이터 추가  4 : 직무, 5: 부서, 6 : 고용일 나머지 : 텍스트 데이터 
                if(i == 4) $("#result tr").eq(-1).append('<td><select><option value="-1">직무 선택</option><c:forEach items="${jobPosition}" var="job"><option value="${job.jobNo}">${job.jobTitle}</option></c:forEach></select></td>');
                else if(i == 5) $("#result tr").eq(-1).append('<td><select><option value="-1">부서 선택</option><c:forEach items="${department}" var="dept"><option value="${dept.deptNo}">${dept.deptName}</option></c:forEach></select></td>');
                else if(i == 6) $("#result tr").eq(-1).append('<td><input type="date"></td>');
                else $("#result tr").eq(-1).append('<td><input type="text"></td>');
            }
            $("#result tr").eq(-1).append('<td><button class="btn4">열 삭제</button></td>'); // 열 삭제 버튼 추가 (클래스 btn4)
        }

        $(document).on("click", ".btn4", function() { // 나중에 생성된 태그 경우 인식이 안되므로 $(document).on을 이용해 인식시켜야함, 클래스로 지정시 클릭한 버튼의 클래스의 이벤트를 따름
            if($("#result tr").length > 2) $(this).parent().parent().remove(); // this : 현재 태크(button) 부모의 부모는 button -> td -> tr 즉 tr을 삭제(조건은 하나의 열은 남겨둬야되서 걸어둠)
        });

        addRow(); // 처음 열은 자동으로 추가

        $("#btn2").click(() => { // 열 추가 버튼 클릭시 열 추가 함수 addRow 함수 실행
            
            addRow();
        });

       

        $("#btn").click(() => { // 제출 버튼
            const table = $("#result tr"); // 테이블 정보 획득
            const eiList = []; // 객체를 담을 배열
            const formData = new FormData();
        	
            for(var i = 1; i < table.length; i++){ // i가 1부터 시작하는 이유는 첫번째 열은 th(열의 설명)부분이라 데이터가 아님
                const obj ={}; // 직원 하나당 하나의 객체로 생성
                for(var j = 0; j <11; j++) { // 객체에 데이터 삽입
                	if(j === 0)  obj.empId=$("#result tr").eq(i).find("td").eq(j).find("input").val(); // result의 i번째 tr의 j번째 td 데이터(사원이름,직무이름 등)을 객체에 저장 
                	if(j === 1)  obj.empIn=$("#result tr").eq(i).find("td").eq(j).find("input").val();
                	if(j === 2)  obj.empPwd=$("#result tr").eq(i).find("td").eq(j).find("input").val();
                	if(j === 3)  obj.empName=$("#result tr").eq(i).find("td").eq(j).find("input").val();
                	if(j === 4)  obj.jobNo=$("#result tr").eq(i).find("td").eq(j).find("select").val();
                	if(j === 5)  obj.deptNo=$("#result tr").eq(i).find("td").eq(j).find("select").val();
                	if(j === 6)  obj.hireDate=$("#result tr").eq(i).find("td").eq(j).find("input").val();
                	if(j === 7)  obj.salary=$("#result tr").eq(i).find("td").eq(j).find("input").val();
                	if(j === 8)  obj.addr=$("#result tr").eq(i).find("td").eq(j).find("input").val();
                	if(j === 9)  obj.phone=$("#result tr").eq(i).find("td").eq(j).find("input").val();
                	if(j === 10)  obj.email=$("#result tr").eq(i).find("td").eq(j).find("input").val();
                }
                eiList.push(obj); // 정보 저장한 객체를 배열에 삽입
            }
            console.log(JSON.stringify(eiList));
            $.ajax({
                // 요청
                type : "post",
                url : "/empAdd",
                dataType : "json", // dataType 지정해줘야 자바에서 인식하는 듯?
                data : JSON.stringify(eiList), // json문자열로 변환해서 전송
				processData: false,
				contentType: 'application/json; charset=UTF-8', // formData에서는 false였으나 여기서는 contentType을 지정해줘야함
                // 응답
                success : function(result) {
					
                },
                
				error:function(xhr,status,error) {
					
				}
            });
        });


    </script>
</body>
</html>