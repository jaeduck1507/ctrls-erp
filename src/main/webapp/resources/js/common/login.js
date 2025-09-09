document.addEventListener("DOMContentLoaded", () => {
  const p = new URLSearchParams(location.search);
  const msg = p.get("error");
  console.log(msg);
  if (p.get("error")) {
    Swal.fire({
      icon: "error",
      title: "로그인 실패",
      confirmButtonText: "확인",
      width: 600,
      confirmButtonColor: "#90C67C",
      text: msg || "로그인에 실패했습니다.",
    }).then((result) => {
      if (result.isConfirmed) {
        location.href = "/login";
      }
      if (result.dismiss == "backdrop") {
        location.href = "/login";
      }
    });
  }
});
/* a Pen by Diaco m.lotfollahi  : https://diacodesign.com */
var falling = true;

TweenLite.set("#container", { perspective: 600 });
TweenLite.set("img", { xPercent: "-50%", yPercent: "-50%" });

var total = 30;
var container = document.getElementById("container"),
  w = window.innerWidth,
  h = window.innerHeight;

for (i = 0; i < total; i++) {
  var Div = document.createElement("div");
  TweenLite.set(Div, {
    attr: { class: "dot" },
    x: R(0, w),
    y: R(-200, -150),
    z: R(-200, 200),
  });
  container.appendChild(Div);
  animm(Div);
}

function animm(elm) {
  TweenMax.to(elm, R(6, 15), {
    y: h + 100,
    ease: Linear.easeNone,
    repeat: -1,
    delay: -15,
  });
  TweenMax.to(elm, R(4, 8), {
    x: "+=100",
    rotationZ: R(0, 180),
    repeat: -1,
    yoyo: true,
    ease: Sine.easeInOut,
  });
  TweenMax.to(elm, R(2, 8), {
    rotationX: R(0, 360),
    rotationY: R(0, 360),
    repeat: -1,
    yoyo: true,
    ease: Sine.easeInOut,
    delay: -5,
  });
}

function R(min, max) {
  return min + Math.random() * (max - min);
}

/* a Pen by Diaco m.lotfollahi  : https://diacodesign.com */
