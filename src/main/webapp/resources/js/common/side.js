document.addEventListener("DOMContentLoaded", () => {
	// 현재 페이지의 url 경로
  const currentPath = window.location.pathname;

  // 모든 서브 메뉴 반복
  document.querySelectorAll(".submenu").forEach((submenu) => {
	// 서브메뉴 안에 있는 a태그를 찾음
    const links = submenu.querySelectorAll("a");
	
    links.forEach((link) => {
		// 현재 페이지 주소와 링크의 href가 같으면
      if (link.getAttribute("href") === currentPath) {
        submenu.classList.add("show"); // 해당 서브메뉴 펼치기
		link.classList.add("active"); // 현재 페이지 강조(배경 진하게)
      }
	  
	  // 클릭 이벤트 등록
	  link.addEventListener("click", (e) => {
		// 모든 링크에서 active 제거 -> 이전 강조 지우기
		document.querySelectorAll(".submenu a").forEach((el)=>{
			el.classList.remove("active");
		});
		// 클릭한 a 태그만 active 추가 -> 선택한 메뉴만 진하게 유지
		e.target.classList.add("active");
	  });
    });
  });
});

// 주 메뉴 클릭 시 toggle 동작 유지
document.querySelector(".side nav").addEventListener("click", (e) => {
	// 클릭한 요소가 menu-title 클래스일 경우만 실행
  if (e.target.classList.contains("menu-title")) {
    const submenu = e.target.nextElementSibling; // 해당 제목 아래의 서브메뉴 찾기
	
    if (submenu && submenu.classList.contains("submenu")) {
      submenu.classList.toggle("show"); // 메뉴 열고 닫기 토글
    }
  }
});

