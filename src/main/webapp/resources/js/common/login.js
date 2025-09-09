document.addEventListener('DOMContentLoaded', () => {
    const p = new URLSearchParams(location.search);
    const msg = p.get('error');
    console.log(msg);
    if (p.get('error')) {
      Swal.fire({
        icon: 'error',
        title: '로그인 실패',
        confirmButtonText: '확인',
		width: 600,
		confirmButtonColor: "#90C67C",
        text: msg || '로그인에 실패했습니다.',
      }).then((result) => {
		  if (result.isConfirmed) {
			  location.href='/login';	
			  }
		  if(result.dismiss == "backdrop") {
			  location.href='/login';	
		  }
			});
    }
  });
  