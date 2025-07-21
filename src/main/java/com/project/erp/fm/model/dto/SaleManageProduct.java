package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class SaleManageProduct {
	// 매출 테이블, 제품명 테이블 조인
	private int smNo;
	private LocalDate saleDate;
	private String quantity;
	private int varAmount;
	private int totalAmount;
	private String productName;
	private String productCategory;
}
