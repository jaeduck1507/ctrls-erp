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
	private String empName;
	private String deptName;
	private int payment;
	
}
