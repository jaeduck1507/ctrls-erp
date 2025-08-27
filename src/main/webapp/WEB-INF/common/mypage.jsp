<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>마이 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/3.0.0/uicons-bold-rounded/css/uicons-bold-rounded.css'>
<link rel="stylesheet" href="../resources/css/mypage.css" />
</head>
<body>
	
	<!-- get, /mypage: 인증된 사람만 즉! 로그인된 사람만 -->
	<h1>마이페이지</h1>
	<div class="mypage">
		
		<div class="box1">
			<h4><i class="fi fi-br-smiley-comment-alt"  style="color:#67ae6e;"></i>&nbsp;&nbsp;${user.empName}님, 반갑습니다!</h4>
			<div id="date-timer" class="filter-bar">
				<p class="date" id="ymd"></p>
			    <p id="timer"></p>

				출퇴근 등록 시간<input type="time" id = "checkTime">
				<button id="start_work">출근</button>
				<button id="finish_work">퇴근</button>

				<p id="status"><span id = "checkIn">00:00:00</span> ~ <span id="checkOut">00:00:00</span></p>

			</div>
			
		</div>	
		<div class="box">
		<div class="box2">
			<h4>사원 정보</h4>
			<table>
				<tr>
		    <th><i class="fi fi-rr-id-badge"></i>&nbsp;&nbsp;&nbsp;&nbsp;사번</th><td><b> ${user.empNo}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-letter-case"></i>&nbsp;&nbsp;&nbsp;&nbsp;성명</th><td><b>${user.empName}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-sitemap"></i>&nbsp;&nbsp;&nbsp;&nbsp;직급</th><td><b>${user.jobTitle}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-department"></i>&nbsp;&nbsp;&nbsp;&nbsp;부서</th><td><b>${user.deptName}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-calendar"></i>&nbsp;&nbsp;&nbsp;&nbsp;입사일</th><td><b>${user.hireDate}</b></td>
			</tr>
			</table>
		</div>
		
		<div class="box2">
			<h4>개인 정보</h4>
		<table>
			<tr>
			<th><i class="fi fi-rr-hastag"></i>&nbsp;&nbsp;&nbsp;&nbsp;주민등록번호</th><td><b>${user.empIn}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-home-location-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;주소</th><td><b>${user.addr}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-phone-call"></i>&nbsp;&nbsp;&nbsp;&nbsp;연락처</th><td><b>${user.phone}</b></td>
			</tr>
			<tr>
		    <th><i class="fi fi-rr-envelope"></i>&nbsp;&nbsp;&nbsp;&nbsp;이메일</th><td><b>${user.email}</b></td>
			</tr>
		</table>
		</div>
		
	</div>
	<div class="filter-bar">
	<button onclick="location.href='/modifyMyInfo'">개인정보 수정(완)</button>
	<button onclick="location.href='/myLeavePage'">휴가신청(완)</button>
	<button onclick="location.href='/myAttendance'">출근 현황 보기(완)</button>
	<button onclick="location.href='/resetMyPwd'">비밀번호재설정(미완)</button>
	</div>
	
	<div class="logout">
	<a href="/logout" class="btn-logout">로그아웃</a>
	</div>
	</div>
	<script>
	
	function checkAtt() { // 출퇴근 현황 ajax로 보기
		$.ajax({ 
	        url: '/showAttendanceOneAtToday',
	        method: 'post',
	        success: function(response) {
	            console.log(response.checkIn);
	            console.log(response.checkOut);
	            // console.log('데이터 성공적으로 받아옴:', response);
	            if(!response) {
					// 출근 X 퇴근 X
					console.log("출근 X 퇴근 X");
					$("#start_work").prop('disabled', false);
					$("#finish_work").prop('disabled', true);
	            } else {
					if(response.status == "휴가") {
						$("#status").text("휴가");
						$("#start_work").prop('disabled', true);
						$("#finish_work").prop('disabled', true);
						
					}
					else if(response.checkOut != null) {
		            	console.log("출근 O 퇴근 O");
						$("#start_work").prop('disabled', true);
						$("#finish_work").prop('disabled', true);
						$("#checkIn").text(response.checkIn);
						$("#checkOut").text(response.checkOut);
		            }
		            else if(response.checkIn != null) {
		            	console.log("출근 O 퇴근 X");
						$("#start_work").prop('disabled', true);
						$("#finish_work").prop('disabled', false);
						$("#checkIn").text(response.checkIn);
		            } 
	            }
	        },
	        error: function(error) {
	        }
	    });
	}
	
	
	$("#start_work").click(() =>{
		const checkIn = $("#checkTime").val();
		const obj = {};
		obj.checkIn = checkIn;
		$.ajax({
            type : "post",
            url : "/startWorking",
            dataType : "json", 
            data : JSON.stringify(obj),
			processData: false,
			contentType: 'application/json; charset=UTF-8',
			
            success : function(result) {
            	Swal.fire({
        			title: "출근 완료 (출근시간 : "+ checkIn +")",
        			confirmButtonText: '확인',
        			width: 600,
        			confirmButtonColor: "#90C67C",
        			icon: "warning",
        			iconColor: "green"
        			});
            	
            	checkAtt(); // 출퇴근 현황 비동기 처리로 업데이트
            	
            	
            },
            
			error:function(xhr,status,error) {
				
			}
        });
    });
	
	$("#finish_work").click(() =>{
		const checkOut = $("#checkTime").val();
		const obj = {};
		obj.checkOut = checkOut;
		$.ajax({
            type : "post",
            url : "/finishWorking",
            dataType : "json", 
            data : JSON.stringify(obj),
			processData: false,
			contentType: 'application/json; charset=UTF-8',
			
            success : function(result) {

            	Swal.fire({
        			title: "퇴근 완료 (퇴근시간 : "+ checkOut +")",
        			confirmButtonText: '확인',
        			width: 600,
        			confirmButtonColor: "#90C67C",
        			icon: "warning",
        			iconColor: "green"
        			});
            	checkAtt(); // 출퇴근 현황 비동기 처리로 업데이트
            	
            },
            
			error:function(xhr,status,error) {
				
			}
        });
    });
	
	function isOver10(num) { // 시 분 초에 0 패딩
		  return num < 10 ? '0' + num : num;
		}
	
	const nowtime = () => { // 실시간 시간 받아오기
		  const day = ["일", "월", "화", "수", "목", "금", "토"]; // now.getDay()로 인덱스 지정
		  const now = new Date(); // 현재 시각
		  

		  
		  
		  
		  
		  // 초기 화면 표시
		  // 초기 화면 : 현재 시간 및 남은 시간
		  ymd.textContent = now.getFullYear() + "년 " + (now.getMonth() + 1) + "월 " + now.getDate() + "일 (" + day[now.getDay()] + ")";
		  timer.textContent = isOver10(now.getHours()) + ":" + isOver10(now.getMinutes()) + ":" + isOver10(now.getSeconds());

		 
		};
		
	setInterval(() => { // 1초에 한번씩 업데이트
	nowtime(); 
	}
	, 1000);
	
	
	nowtime(); // 처음에 바로 실시간 시간 받아오기
	checkAtt(); // 처음에 바로 출퇴근 현황 보여주기
	
	</script>
</body>
</html>