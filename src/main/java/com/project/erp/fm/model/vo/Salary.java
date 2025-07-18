package com.project.erp.fm.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Salary {

	private int salaryNo; // 급여 번호(PK)
	private LocalDate salaryDate; // 지급일
	private int baseSalary; // 기본급
	private int bonus; // 보너스
	private int deduction; //  공제 금액
	private int tax; // 세금
	private int empNo; // 사원 번호(FK)
	private int bonusPaymentNo; // 보너스 수당 번호(FK)
	
}
