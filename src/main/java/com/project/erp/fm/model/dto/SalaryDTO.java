package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class SalaryDTO {
	private int salaryNo; // 급여 번호(PK)
	private LocalDate salaryDate; // 지급일
	private int baseSalary; // 기본급
	private int bonus; // 보너스
	private int deduction; //  공제 금액
	private int tax; // 세금
	private int empNo; // 사원 번호(FK)
	private int bonusPaymentNo; // 보너스 수당 번호(FK)
	private String empName;
	private String jobTitle; // 직급명
	private String deptName;
	
}
