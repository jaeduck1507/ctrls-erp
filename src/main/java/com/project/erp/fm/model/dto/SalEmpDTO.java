package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class SalEmpDTO {

	private int salaryNo;
	private LocalDate salaryDate;
	private int baseSalary;
	private int bonus;
	private int deduction;
	private int tax;
	private int empNo;
	private String empName;
	private int deptNo;
	private String deptName;
	private String yearMonth;
	private int totalSal;
	
}
