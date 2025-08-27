<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
  
.arrow_box {
	position: absolute;
	background: #b73434;
	border-radius: .4em;
	bottom: 0;
	width: 180px;
	height: 30px;
	top: 131%;
	color: white;
	z-index: 9999;
}

.arrow_box:after {
	content: '';
	position: absolute;
	top: 0;
	left: 50%;
	width: 0;
	height: 0;
	border: 20px solid transparent;
	border-bottom-color: #b73434;
	border-top: 0;
	border-left: 0;
	margin-left: -10px;
	margin-top: -20px;
	bottom: 0;
	z-index: 9999;
}
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
	<h5>[인적 자원 관리] > [사원 정보 추가]</h5>
	<h3>사원 정보 추가</h3>
    <div id = "test" class="filter-bar">
        <button id = "btn2">열 추가</button>
        <!-- <button id = "btn3">removeRowTest</button> -->
        <table border="1" id = "result" class="data-table">
            <tr>
                <th>사원명</th>
                <th>주민등록번호</th>
                <th>직급</th>
                <th>부서</th>
                <th>입사일</th>
                <th>급여</th>
                <th>주소</th>
                <th>연락처</th>
                <th>이메일</th>
                <th>사진</th>
                <th>삭제</th>

            </tr>
           
            
        </table>
        <button id = "btn">사원 등록</button>
        
    </div>
	
    <script>
    	
    	var timeoutId =setTimeout(() => { // 3초 후 실행, timeoutId로 식별
			$(".arrow_box").remove();
			
		}, 3000);
    	
    	//console.log(timeoutId);
	    
    	//제약조건 걸어두기
    	const nameCheckValue = {
    			reg: /^[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣\s]+$/,
    			message: "이름 잘못 입력!"
    	};
    	const inCheckValue = {
    			reg: /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12][0-9]|3[01]))-[1-4][0-9]{6}$/,
    			message: "주민번호 잘못 입력!"
    	};
    	const jobCheckValue = {
    			reg: /^\d+$/,
    			message: "선택해라!"
    	};
    	const deptCheckValue = {
    			reg: /^\d+$/,
    			message: "선택해라!"
    	};
    	const hireDateCheckValue = {
    			reg: /.+/,
    			message: "선택해라!"
    	};
    	const salaryCheckValue = {
    			reg: /^\d+$/,
    			message: "급여 잘못 입력!"
    	};
    	const phoneCheckValue = {
    			reg: /^01[0-9]-\d{3,4}-\d{4}$/,
    			message: "연락처 잘못 입력!"
    	};
    	const emailCheckValue = {
    			reg: /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/,
    			message: "이메일 잘못 입력!"
    	};
    	
    	// 제약조건 확인하는 함수
    	function checkReg(target, checkValue) {
    		console.log(checkValue.reg.test(target.value));
    		console.log(target.value);
    		
    		var checking = checkValue.reg.test(target.value);
    		
    		if(target.value) {
    			if(checking) {
    				target.parentElement.classList.remove("red");
    	    		if(target.parentElement.querySelector("p") != null) target.parentElement.removeChild(target.parentElement.querySelector("p"));
    	    		}
    	    		else {
    	    			if(target.parentElement.querySelector("p") != null) target.parentElement.removeChild(target.parentElement.querySelector("p"));
    	    			const message = document.createElement("p");
    	    			message.classList.add("arrow_box");
    	    			message.innerHTML = checkValue.message;
    	    			target.parentElement.classList.add("red");
    	    			target.parentElement.appendChild(message);
    	    			
    	    		} 
    		} else {
				/*
    			name.parentElement.classList.remove("red");
    			if(name.parentElement.querySelector("p") != null) name.parentElement.removeChild(name.parentElement.querySelector("p"));
    			*/
    			
    			if(target.parentElement.querySelector("p") != null) target.parentElement.removeChild(target.parentElement.querySelector("p"));
    			const message = document.createElement("p");
    			message.classList.add("arrow_box");
    			message.innerHTML = checkValue.message;
    			target.parentElement.classList.add("red");
    			target.parentElement.appendChild(message);
    			
    			checking =false;
    		}
    		
    		clearTimeout(timeoutId); //setTimeout 중지 후 다시 실행
    		timeoutId =setTimeout(() => { // 
    			$(".arrow_box").remove();
    			
    		}, 3000);
    		//console.log(timeoutId);
    		return checking;
    	}
    	
    	// 포커스(선택시) 빨간색과 말풍선 사라지게하기
    	$(document).on("click input focus", ".name", function(e) { 
    		if(e.target.parentElement.querySelector("p") != null) e.target.parentElement.removeChild(e.target.parentElement.querySelector("p"));
    		e.target.parentElement.classList.remove("red");
        });
    	$(document).on("click input focus", ".in", function(e) { 
    		if(e.target.parentElement.querySelector("p") != null) e.target.parentElement.removeChild(e.target.parentElement.querySelector("p"));
    		e.target.parentElement.classList.remove("red");
        });
    	$(document).on("click input focus", ".job", function(e) { 
    		if(e.target.parentElement.querySelector("p") != null) e.target.parentElement.removeChild(e.target.parentElement.querySelector("p"));
    		e.target.parentElement.classList.remove("red");
        });
    	$(document).on("click input focus", ".dept", function(e) { 
    		if(e.target.parentElement.querySelector("p") != null) e.target.parentElement.removeChild(e.target.parentElement.querySelector("p"));
    		e.target.parentElement.classList.remove("red");
        });
    	$(document).on("click input focus", ".hireDate", function(e) { 
    		if(e.target.parentElement.querySelector("p") != null) e.target.parentElement.removeChild(e.target.parentElement.querySelector("p"));
    		e.target.parentElement.classList.remove("red");
        });
    	$(document).on("click input focus", ".salary", function(e) { 
    		if(e.target.parentElement.querySelector("p") != null) e.target.parentElement.removeChild(e.target.parentElement.querySelector("p"));
    		e.target.parentElement.classList.remove("red");
        });
    	$(document).on("click input focus", ".phone", function(e) { 
    		if(e.target.parentElement.querySelector("p") != null) e.target.parentElement.removeChild(e.target.parentElement.querySelector("p"));
    		e.target.parentElement.classList.remove("red");
        });
    	$(document).on("click input focus", ".email", function(e) { 
    		if(e.target.parentElement.querySelector("p") != null) e.target.parentElement.removeChild(e.target.parentElement.querySelector("p"));
    		e.target.parentElement.classList.remove("red");
        });
    	
    	
    	// 선택 해제시 제약조건 다시 확인하기
    	$(document).on("blur", ".name", function(e) { 
    		if(e.target.value) checkReg(e.target,nameCheckValue);
        });
    	$(document).on("blur", ".in", function(e) { 
    		if(e.target.value) checkReg(e.target,inCheckValue);
        });
    	$(document).on("blur", ".job", function(e) { 
    		if(e.target.value) checkReg(e.target,jobCheckValue);
        });
    	$(document).on("blur", ".dept", function(e) { 
    		if(e.target.value) checkReg(e.target,deptCheckValue);
        });
    	$(document).on("blur", ".hireDate", function(e) { 
    		if(!e.target.value) checkReg(e.target,hireDateCheckValue);
        });
    	$(document).on("blur", ".salary", function(e) { 
    		if(e.target.value) checkReg(e.target,salaryCheckValue);
        });
    	$(document).on("blur", ".phone", function(e) { // 휴대폰 제약조건 체크
    		if(e.target.value) checkReg(e.target,phoneCheckValue);
        });
    	$(document).on("blur", ".email", function(e) { // 이메일 제약조건 체크
    		if(e.target.value) checkReg(e.target,emailCheckValue);
        });
    	
    	
    	
    	// 해당 말풍선 클릭시 사라지기
    	$(document).on("click", ".arrow_box", function(e) { 
            e.target.remove(); 
        });
    	
    	
    	
        function addRow() { // 열 추가 함수
            $("#result").append('<tr></tr>'); // 기본 열 추가
            /*
            for(var i = 0; i < 9; i++) { // 열에 데이터 추가  4 : 직무, 5: 부서, 6 : 고용일 나머지 : 텍스트 데이터 
                if(i == 2) $("#result tr").eq(-1).append('<td class="aa"><select><option value="-1">직무 선택</option><c:forEach items="${jobPosition}" var="job"><option value="${job.jobNo}">${job.jobTitle}</option></c:forEach></select><p class="arrow_box">gd</p></td>');
                else if(i == 3) $("#result tr").eq(-1).append('<td><select><option value="-1">부서 선택</option><c:forEach items="${department}" var="dept"><option value="${dept.deptNo}">${dept.deptName}</option></c:forEach></select></td>');
                else if(i == 4) $("#result tr").eq(-1).append('<td><input type="date"></td>');
                else $("#result tr").eq(-1).append('<td><input type="text" class="name"></td>');
            } */
            $("#result tr").eq(-1).append(
            		'<td><input type="text" class="name" placeholder="사원명 입력"></td>' +
            		'<td><input type="text" class="in"></td>' + 
            		'<td class="aa"><select class="job"><option value="-1" disabled selected>직무 선택</option><c:forEach items="${jobPosition}" var="job"><option value="${job.jobNo}">${job.jobTitle}</option></c:forEach></select></td>' +
            		'<td><select class="dept"><option value="-1" disabled selected>부서 선택</option><c:forEach items="${department}" var="dept"><option value="${dept.deptNo}">${dept.deptName}</option></c:forEach></select></td>' +
            		'<td><input type="date" class="hireDate"></td>' +
            		'<td><input type="text" class="salary"></td>' + 
            		'<td><input type="text" class="addr"></td>' + 
            		'<td><input type="text" class="phone"></td>' + 
            		'<td><input type="text" class="email"></td>' + 
            		'<td><input type="file" class="file"></td>' + 
            		'<td><button class="btn4">삭제</button></td>'		
            );
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
            
            // 마지막 제출시 제약조건에 위배되는게 있는지 확인하기
            var finalCheck = true;
            for(var i = 1; i < table.length; i++){ 
                for(var j = 0; j <9; j++) { 
                	if(j === 0)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),nameCheckValue) && finalCheck;
                	if(j === 1)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),inCheckValue) && finalCheck;
                	if(j === 2)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("select"),jobCheckValue) && finalCheck;
                	if(j === 3)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("select"),deptCheckValue) && finalCheck;
                	if(j === 4)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),hireDateCheckValue) && finalCheck;
                	if(j === 5)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),salaryCheckValue) && finalCheck;
                	if(j === 7)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),phoneCheckValue) && finalCheck;
                	if(j === 8)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),emailCheckValue) && finalCheck;
                }
            }
            console.log("마지막" + finalCheck);
            
            // finalCheck가 true일때 제약조건 위배되는 데이터 없으므로 전송할 객체배열 생성
            if(finalCheck) {
				const formData = new FormData();
	            for(var i = 1; i < table.length; i++){ // i가 1부터 시작하는 이유는 첫번째 열은 th(열의 설명)부분이라 데이터가 아님
	                //const obj ={}; // 직원 하나당 하나의 객체로 생성
	                for(var j = 0; j <10; j++) { // 객체에 데이터 삽입
	                	if(j === 0)  formData.append('eiList[' + (i-1) +'].empName',$("#result tr").eq(i).find("td").eq(j).find("input").val());
	                	if(j === 1)  formData.append('eiList[' + (i-1) +'].empIn',$("#result tr").eq(i).find("td").eq(j).find("input").val());
	                	if(j === 2)  formData.append('eiList[' + (i-1) +'].jobNo',$("#result tr").eq(i).find("td").eq(j).find("select").val());
	                	if(j === 3)  formData.append('eiList[' + (i-1) +'].deptNo',$("#result tr").eq(i).find("td").eq(j).find("select").val());
	                	if(j === 4)  formData.append('eiList[' + (i-1) +'].hireDate', $("#result tr").eq(i).find("td").eq(j).find("input").val());
	                	if(j === 5)  formData.append('eiList[' + (i-1) +'].salary',$("#result tr").eq(i).find("td").eq(j).find("input").val());
	                	if(j === 6)  formData.append('eiList[' + (i-1) +'].addr',$("#result tr").eq(i).find("td").eq(j).find("input").val());
	                	if(j === 7)  formData.append('eiList[' + (i-1) +'].phone',$("#result tr").eq(i).find("td").eq(j).find("input").val());
	                	if(j === 8)  formData.append('eiList[' + (i-1) +'].email',$("#result tr").eq(i).find("td").eq(j).find("input").val());
	                	if(j === 9)  {
							if($("#result tr").eq(i).find("td").eq(j).find("input")[0].files[0]) formData.append('eiList[' + (i-1) +'].file',$("#result tr").eq(i).find("td").eq(j).find("input")[0].files[0]);
	                	}
	                }
	                //eiList.push(obj); // 정보 저장한 객체를 배열에 삽입
	            }
	            //console.log(JSON.stringify(eiList));
	            $.ajax({
	                // 요청
	                type : "post",
	                url : "/empAdd",
	                data : formData,
					processData: false,
					enctype: "multipart/form-data",
					contentType : false, // json문자열로 변환해서 전송
	                // 응답
	                success : function(result) {
	                	Swal.fire({
							icon: "success",
							iconColor: "green",
						  title: "성공적으로 등록했습니다!",
						  html: '<span id="aa"></span>초 후 자동으로 닫힙니다.',
						  timer: 3000,
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
        
        /*
        $("#test1").click(() => { // 제출 버튼
        	const table = $("#result tr"); // 테이블 정보 획득
        	var finalCheck = true;
            for(var i = 1; i < table.length; i++){ // i가 1부터 시작하는 이유는 첫번째 열은 th(열의 설명)부분이라 데이터가 아님
                for(var j = 0; j <9; j++) { // 객체에 데이터 삽입
                	if(j === 0)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),nameCheckValue) && finalCheck;
                	if(j === 1)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),inCheckValue) && finalCheck;
                	if(j === 2)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("select"),jobCheckValue) && finalCheck;
                	if(j === 3)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("select"),deptCheckValue) && finalCheck;
                	if(j === 4)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),hireDateCheckValue) && finalCheck;
                	if(j === 5)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),salaryCheckValue) && finalCheck;
                	
                	//if(j === 6)  obj.addr=$("#result tr").eq(i).find("td").eq(j).find("input").val();
                	if(j === 7)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),phoneCheckValue) && finalCheck;
                	if(j === 8)  finalCheck = checkReg(document.querySelectorAll("#result tr")[i].querySelectorAll("td")[j].querySelector("input"),emailCheckValue) && finalCheck;
                }
            }
            
            
            console.log("마지막" + finalCheck);
        });
        */


    </script>
</body>
</html>