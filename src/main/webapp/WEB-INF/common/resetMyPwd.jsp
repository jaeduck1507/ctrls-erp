<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<h5>[마이페이지] > [비밀번호 재설정]</h5>
			<h3>비밀번호 재설정</h3>

	      <div class="filter-bar">
	        
	        <input type="password" name="password" id="password" placeholder="비밀번호" />
	        <input type="password" name="passwordCheck" id="passwordCheck" placeholder="비밀번호 확인" />
	        <button class="btn" id="btn">재설정</button>
			
	      </div>
<script>
$("#btn").click(() => {
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
					  	
					    const obj = {};
					    obj.password = $("#password").val();
					    $.ajax({
					        // 요청
					        type : "post",
					        url : "/resetMyPwd",
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
								  title: "성공적으로 변경했습니다!",
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
									  location.href='/mypage';
								  }
								  if (result.dismiss === Swal.DismissReason.timer) {
									  location.href='/mypage';
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