$("#modifySalary").click(() => { 

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
				    obj.empNo = $("#empNo").val();
				    obj.salary = $("#salary").val();
				    $.ajax({
				        // 요청
				        type : "post",
				        url : "/modifySalary",
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
});


$("#empModifyBtn").click(() => { 

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
				    obj.empNo = $("#empNo").val();
				    obj.empName = $("#empName").val();
				    obj.addr = $("#addr").val();
				    obj.phone = $("#phone").val();
				    obj.email = $("#email").val();
				    $.ajax({
				        // 요청
				        type : "post",
				        url : "/empModify",
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
});

$("#modifyJobDept").click(() => { 

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
				  	console.log($("#job").val());
				    console.log($("#dept").val());
				    console.log($("#empNo").val());
				    const obj = {};
				    obj.deptNo = $("#dept").val();
				    obj.jobNo = $("#job").val();
				    obj.empNo = $("#empNo").val();
				    $.ajax({
				        // 요청
				        type : "post",
				        url : "/modifyJobDept",
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
});


$("#modifyImg").click(() => { 

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
				    const formData = new FormData();
					formData.append("empNo",$("#empNo").val());
					formData.append("url",$("#url").val());
					formData.append("file",$("#file")[0].files[0]);
				    
				    $.ajax({
				        // 요청
				        type : "post",
				        url : "/modifyImg",
				        dataType : "json", 
				        data : formData,
						processData: false,
						enctype: "multipart/form-data",
						contentType : false,
						
				        // 응답
				        success : function(result) {
				        	let timerInterval;
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
});

$("#deleteImg").click(() => { 

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
				    const formData = new FormData();
					formData.append("empNo",$("#empNo").val());
					formData.append("url",$("#url").val());
				    
				    $.ajax({
				        // 요청
				        type : "post",
				        url : "/deleteImg",
				        dataType : "json", 
				        data : formData,
						processData: false,
						enctype: "multipart/form-data",
						contentType : false,
						
				        // 응답
				        success : function(result) {
				        	let timerInterval;
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
});