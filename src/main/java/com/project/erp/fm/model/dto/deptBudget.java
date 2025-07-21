package com.project.erp.fm.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class deptBudget {
	// 예산 테이블, 부서 테이블 조인
	private int budgetNo;
	private String periodType;
	private String periodValue;
	private int annualBudget;
	private String plan;
	private String deptName;
}
