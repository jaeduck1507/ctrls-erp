<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 신청</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h1>휴가 신청</h1>
	<div id = "test">
	        <button id = "btn2">열 추가</button>
	        <!-- <button id = "btn3">removeRowTest</button> -->
	        <table border="1" id = "result">
	            <tr>
	                <th>사번</th>
	                <th>신청날짜</th>
	                <th>휴가 시작일</th>
	                <th>휴가 종료일</th>
	                <th>휴가 유형</th>
	                <th>사유</th>
					<th>삭제</th>
	            </tr>
			</table>
			<button id="btn">휴가 등록</button>
	 </div>
	 <!--<div id = "test">
		
	       0 사번 : <input type="text" id="empNo"/></br>
	       1 신청날짜 : <input type="date" id="requestDate"/></br>
	        
	       2 휴가 시작일 : <input type="date" id="startDate"/>
	       3 휴가 종료일 : <input type="date" id="endDate"/></br>
	       4 휴가 유형 : 
			<select id="leaveType"> 
				<option diabled selected>선택하세요.<option>
				<option value="연차">연차<option>
				<option value="병가">병가<option>
				<option value="경조사">경조사<option>
				<option value="기타">기타<option>
				</select></br>
			5 사유 </br><textarea style="resize:none"></textarea></br>
			6 삭제
			<button id="btn">휴가 등록</button>
	</div>-->
	
	<script>
		function addRow() { // 열 추가 함수
		           $("#result").append('<tr></tr>'); // 기본 열 추가
		           for(var i = 0; i < 6; i++) { // 열에 데이터 추가  0 : 사번, 4: 휴가 유형, 5 : 사유 나머지 : 날짜 데이터 
		               if(i == 0) $("#result tr").eq(-1).append('<td><input type="text"></td>');
		               else if(i == 4) $("#result tr").eq(-1).append('<td><select><option diabled selected>유형선택</option><option value="연차">연차</option><option value="병가">병가</option><option value="경조사">경조사</option><option value="기타">기타</option></select></td>');
		               else if(i == 5) $("#result tr").eq(-1).append('<td><textarea style="resize:none"></textarea></td>');
		               else $("#result tr").eq(-1).append('<td><input type="date"></td>');
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
			                   for(var j = 0; j <6; j++) { // 객체에 데이터 삽입
			                   	if(j === 0)  obj.empNo=$("#result tr").eq(i).find("td").eq(j).find("input").val(); // result의 i번째 tr의 j번째 td 데이터(사원이름,직무이름 등)을 객체에 저장 
			                   	if(j === 1)  obj.requestDate=$("#result tr").eq(i).find("td").eq(j).find("input").val();
			                   	if(j === 2)  obj.startDate=$("#result tr").eq(i).find("td").eq(j).find("input").val();
			                   	if(j === 3)  obj.endDate=$("#result tr").eq(i).find("td").eq(j).find("input").val();
			                   	if(j === 4)  obj.leaveType=$("#result tr").eq(i).find("td").eq(j).find("select").val();
			                   	if(j === 5)  obj.reason=$("#result tr").eq(i).find("td").eq(j).find("textarea").val();
			                   	if(j === 6)  obj.delete=$("#result tr").eq(i).find("td").eq(j).find("button").val();

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