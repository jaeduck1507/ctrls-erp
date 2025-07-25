package com.project.erp.fm.model.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class BudgetDeptDTO {

	private int budgetNo;
	private String periodType;
	private String periodValue;
	private int annualBudget;
	private String plan;
	private LocalDateTime createdAt;
	private String deptName;
	
}
