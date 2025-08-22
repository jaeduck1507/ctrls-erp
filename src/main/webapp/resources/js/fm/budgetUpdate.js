const budgetCheck = /^[1-9]\d*$/;
const annualBudget = document.querySelector("#annualBudget");
annualBudget.addEventListener("input", (e) => {
	console.log(e.target.value);
	console.log(budgetCheck.test(e.target.value));
	
	if (budgetCheck.test(e.target.value)) {
		$("#budget-update").prop("disabled", false);
		resultBudget.innerHTML = "OK!";
		resultBudget.style.color = "green";
		annualBudget.style.border = "1px #ccc";
	} else {
		$("#budget-update").prop("disabled", true);
		resultBudget.innerHTML = "숫자만 입력";
		resultBudget.style.color = "red";
		annualBudget.style.border = "2px solid red"
	}
});

const dateCheck = /.+/;
const executionDate = document.querySelector("#executionDate");
executionDate.addEventListener("input", (e) => {
	console.log(e.target.value);
	console.log(dateCheck.test(e.target.value));
	
	if (dateCheck.test(e.target.value)) {
		$("#budget-update").prop("disabled", false);
		resultDate.innerHTML = "OK!";
		resultDate.style.color = "green";
		executionDate.style.border = "1px #ccc";
	} else {
		$("#budget-update").prop("disabled", true);
		resultDate.innerHTML = "날짜 입력 필수";
		resultDate.style.color = "red";
		executionDate.style.border = "2px solid red"
	}
});

$("#budget-update").click(() => {
	alert("수정되었습니다!");
});