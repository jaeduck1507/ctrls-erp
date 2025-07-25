package com.project.erp.fm.model.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Budget {

	private int budgetNo; // 예산 번호(PK)
	private String periodType; // (연/분기/월: Y/Q/M)
	private String periodValue; // 적용 기간 값 (예 : 2025, 2025-Q1 등)
	private int annualBudget; // 예산 금액
	private String plan; // 계획 상세
	private LocalDateTime createdAt; // 생성일시
	private int deptNo; // 부서 번호(FK)
	
}
