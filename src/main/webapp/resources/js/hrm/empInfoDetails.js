const quitDate = document.querySelector("#quitDate");
	if(quitDate.textContent){
		$("#quitBtn").prop('disabled', true);
	} 
	
	var commentsList = [];
	var pageCount = 0;
	function showComments() {
		$("#showCommentsPage").html('');
		$("#showCommentsPage").append('<p>코멘트 ---</p>');
		$("#showCommentsPage").append('<p>'+ commentsList[pageCount] +'</p>');
		$("#showCommentsPage").append('<button type="button" class="btn" id="prev">이전 코멘트</button>');
		$("#showCommentsPage").append('<button type="button" class="btn" id = "next">다음 코멘트</button>');
		$("#prev").prop("disabled", true);
		if(commentsList.length == 1) $("#prev").prop("disabled", true);
	}
	
	$(document).on('change', '#year', function(e) {
		$("#showEval").html('');
		commentsList = [];
		pageCount = 0;
		$("#showCommentsPage").html('');
		if($("#year option:selected").val() != 0 ) {
			const prDto = {};
			
			prDto.empNo = $("#empNo").val();
			prDto.year = $("#year option:selected").val();
			console.log(prDto);
			
			$.ajax({
	            // 요청
	            type : "post",
	            url : "/showEval",
	            dataType : "json",
	            data : JSON.stringify(prDto),
				contentType : 'application/json',
	            // 응답
	            success : function(result) {
	            	if(result) {
						$("#showEval").html('');
						$("#showEval").append('<p> 근무태도점수 : <b>'+ result.avgAttitudeScore +'</b></p>');
						$("#showEval").append('<p> 성과점수 : <b>'+ result.avgAchieveScore +'</b></p>');
						if(result.commentsList.length != 0) {
							
							commentsList = result.commentsList;
							showComments();
							console.log(commentsList.length);
						}
	            	}
	            },
	            
				error:function(xhr,status,error) {
					$("#showEval").html('');
            		$("#showEval").append('<h1>조회된 정보가 없습니다</h1>');
				}
	        });
			
			
		}
	});
	
	$(document).on('click', '#prev', function(e) {
		pageCount--;
		showComments();
		$("#next").prop("disabled", false);
		if(pageCount == 0) $("#prev").prop("disabled", true);
		
	});
	$(document).on('click', '#next', function(e) {
		pageCount++;
		showComments();
		$("#prev").prop("disabled", false);
		if(pageCount == (commentsList.length-1)) $("#next").prop("disabled", true);
	});