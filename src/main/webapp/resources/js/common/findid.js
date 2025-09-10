$("#btn").click(() => {
  const formData = new FormData();
  formData.append("empNo", $("#empNo").val());
  $("#result").empty();
  $.ajax({
    type: "post",
    url: "/findId",
    data: formData,
    processData: false,
    contentType: false,
    success: function (result) {
      if (result == "") {
        $("#result").append("아이디가 존재하지 않습니다.");
      } else {
        $("#result").append("아이디는 " + result + "입니다.");
		
      }
    },
    error: function (xhr, status, error) {	
		Swal.fire({
			title: "사번을 입력해주세요!",
			confirmButtonText: '확인',
			width: 600,
			confirmButtonColor: "#90C67C",
			icon: "warning",
			iconColor: "green"
			});
		},
  });
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