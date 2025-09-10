let idValid = false;
let idChecked = false;
let pwValid = false;
let pwMatch = false;
let empNoChecked = false;

// 모든 input 채웠는지 확인
function checkAllValid() {
	if (idValid && idChecked && pwValid && pwMatch && empNoChecked) {
		$("#submit").prop("disabled", false);
	} else {
		$("#submit").prop("disabled", true);
	}
}

// 사번 입력
const empNo = document.querySelector("#empNo");
const resultNo = document.querySelector("#noCkeckMessage");
empNo.addEventListener("input", (e) => {
	const value = e.target.value; // 앞뒤 공백 제거
	idChecked = false; // 아이디 다시 입력하면 중복확인 다시 해야 함
	if (value === "") {
		resultNo.innerHTML = "필수 입력값입니다.";
		resultNo.style.color = "red";
		empNo.style.border = "red solid 1px";

	} else {
		resultNo.innerHTML = "사번확인 버튼을 눌러주세요.";
		resultNo.style.color = "green";
		empNo.style.border = "";
	}

	checkAllValid();
});
// 아이디 생성 가능한 사번인지 확인
$("#noCheck").click(() => {
	const empNo = $("#empNo").val();

	$.ajax({
		// 요청
		type: "post",
		url: "/noCheck",
		data: "empNo=" + empNo,
		// 응답
		success: function(result) {
			if (result == 0) {
				$("#noCkeckMessage").text("아이디 생성이 가능합니다.");
				$("#noCkeckMessage").css("color", "blue");
				$("#empNo").css("border", "");
				empNoChecked = true;
			} else {
				$("#noCkeckMessage").text("아이디 생성이 불가능합니다.");
				$("#noCkeckMessage").css("color", "red");
				$("#empNo").css("border", "red solid 1px");
				empNoChecked = false;
			}
			checkAllValid();
		},

		error: function(xhr, status, error) {
			//alert("사번을 입력해주세요");
			const empNo = document.querySelector("#empNo");
			const resultNo = document.querySelector("#noCkeckMessage");
			resultNo.innerHTML = "필수 입력값입니다.";
			resultNo.style.color = "red";
			empNo.style.border = "red solid 1px";
		}
	});
});



// 아이디입력
const id = document.querySelector("#id");
const resultId = document.querySelector("#resultId");
id.addEventListener("input", (e) => {
	const idExp = /^[a-zA-Z][a-zA-Z0-9]{3,11}$/;
	idValid = idExp.test(e.target.value);
	idChecked = false; // 아이디 다시 입력하면 중복확인 다시 해야 함
	if (idValid) {
		resultId.innerHTML = "중복확인을 눌러주세요.";
		resultId.style.color = "green";
		id.style.border = "";
	} else {
		resultId.innerHTML = "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내";
		resultId.style.color = "red";
		id.style.border = "red solid 1px";
	}
	checkAllValid();
});

// 아이디 중복 확인 버튼
$("#idCheck").click(() => {
	const username = $("#id").val();
	if (!idValid) {
		resultId.innerHTML = "아이디 형식이 올바르지 않습니다.";
		resultId.style.color = "red";
		id.style.border = "red solid 1px";
		return;
	}
	$.ajax({
		type: "post",
		url: "/idCheck",
		data: { username: username },
		success: function(result) {
			if (result == 0) {
				resultId.innerHTML = "사용 가능한 아이디입니다!";
				resultId.style.color = "blue";
				id.style.border = "";

				idChecked = true;
			} else {
				resultId.innerHTML = "이미 사용 중인 아이디입니다.";
				resultId.style.color = "red";
				id.style.border = "red solid 1px";
				idChecked = false;
			}
			checkAllValid();
		},
	});
});

// 비밀번호 입력
const pw = document.querySelector("#pw");
const resultPw = document.querySelector("#resultPw");
pw.addEventListener("input", (e) => {
	const pwExp =
		/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,15}$/;
	pwValid = pwExp.test(e.target.value);
	if (pwValid) {
		resultPw.innerHTML = "사용가능한 비밀번호입니다.";
		resultPw.style.color = "blue";
		pw.style.border = "";
	} else {
		resultPw.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
		resultPw.style.color = "red";
		pw.style.border = "red solid 1px";
	}
	checkPwMatch();
	checkAllValid();
});
//console.log(pw.addEventListener);

// 비밀번호 확인
const pw2 = document.querySelector("#pw2");
const resultPw2 = document.querySelector("#resultPw2");
pw2.addEventListener("input", () => {
	checkPwMatch();

	checkAllValid();
});
function checkPwMatch() {
	pwMatch = pw.value === pw2.value && pw.value.length > 0;
	if (pwMatch) {
		resultPw2.innerHTML = "비밀번호가 일치합니다.";
		resultPw2.style.color = "blue";
		pw2.style.border = "";
	} else {
		resultPw2.innerHTML = "위 비밀번호와 동일하게 입력";
		resultPw2.style.color = "red";
		pw2.style.border = "red solid 1px";
	}
}

// reset 버튼 클릭 시 border, 메시지 초기화
$("#register").on("reset", function() {
	// 사번
	$("#empNo").css("border", "");
	$("#noCkeckMessage").text("사번 입력 후 사번확인을 눌러주세요.").css("color", "");

	// 아이디
	$("#id").css("border", "");
	$("#resultId").text("영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내").css("color", "");

	// 비밀번호
	$("#pw").css("border", "");
	$("#resultPw").text("영문자, 숫자, 특수문자 조합으로 8~15자 이내").css("color", "");

	// 비밀번호 확인
	$("#pw2").css("border", "");
	$("#resultPw2").text("위 비밀번호와 동일하게 입력").css("color", "");

	// 상태값 전부 false로 초기화
	idValid = false;
	idChecked = false;
	pwValid = false;
	pwMatch = false;
	empNoChecked = false;
	$("#submit").prop("disabled", true);
});

$("#submit").prop("disabled", true);

// 로그인 페이지로 이동
$("#login").click((e) => {
	e.preventDefault(); // 기본 submit 막기
	window.location.href = "/login"; // 로그인 페이지 경로에 맞게 수정
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