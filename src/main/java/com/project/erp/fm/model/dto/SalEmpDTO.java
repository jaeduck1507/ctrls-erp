package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class SalEmpDTO {

	private int salaryNo;
	private LocalDate salaryDate;
	private int baseSalary;
	private int bonus;
	private int deduction;
	private int tax;
	private String empName;
	private int payment;
	
}
