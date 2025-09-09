$("#movePrev").click(() => {
	history.back();
});
$("#moveMain").click(() => {
	location.href = "/";
});

var makeItRain = function() {
	//clear out everything
	$('.rain').empty();

	var increment = 0;
	var drops = "";
	var backDrops = "";

	while (increment < 200) {
		var randoHundo = (Math.floor(Math.random() * (98 - 1 + 1) + 1));
		var randoFiver = (Math.floor(Math.random() * (5 - 2 + 1) + 2));
		increment += randoFiver;
		drops += '<div class="drop" style="left: ' + increment + '%; bottom: ' + (randoFiver + randoFiver - 1 + 100) + '%; animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"><div class="stem" style="animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"></div><div class="splat" style="animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"></div></div>';
		backDrops += '<div class="drop" style="right: ' + increment + '%; bottom: ' + (randoFiver + randoFiver - 1 + 100) + '%; animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"><div class="stem" style="animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"></div><div class="splat" style="animation-delay: 0.' + randoHundo + 's; animation-duration: 0.5' + randoHundo + 's;"></div></div>';
	}

	$('.rain.front-row').append(drops);
	$('.rain.back-row').append(backDrops);
}

makeItRain();

const checkbox = document.getElementById("myCheck");
const code = document.getElementById("code");
document.addEventListener("click", function() {
	checkbox.checked = !checkbox.checked; // 현재 상태 반대로
});


var count = 0;
setInterval(() => {
	count++;
	if (count == 5) checkbox.checked = true;
	if (count == 3 || count == 12 || count == 21) {
		let count2 = 0;

		const interval = setInterval(() => {
			code.classList.toggle("twinkling"); // 1초마다 넣었다 뺐다
			count2++;

			if (count2 >= 4) { // 4초 지나면 종료
				clearInterval(interval);
				code.classList.remove("twinkling"); // 마지막에 꺼진 상태로
			}
		}, 150);
	}
	if (count == 25) {
		checkbox.checked = false;
		count = 0;
	}
}, 1000);