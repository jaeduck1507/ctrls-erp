document.addEventListener("DOMContentLoaded", () => {
  const currentPath = window.location.pathname;

  // 모든 서브 메뉴 순회
  document.querySelectorAll(".submenu").forEach((submenu) => {
    const links = submenu.querySelectorAll("a");
    links.forEach((link) => {
      if (link.getAttribute("href") === currentPath) {
        submenu.classList.add("show"); // 현재 링크가 포함된 submenu만 열기
      }
    });
  });
});

// 메뉴 제목 클릭 시 toggle 동작 유지
document.querySelector(".side nav").addEventListener("click", (e) => {
  if (e.target.classList.contains("menu-title")) {
    const submenu = e.target.nextElementSibling;
    if (submenu && submenu.classList.contains("submenu")) {
      submenu.classList.toggle("show");
    }
  }
});
