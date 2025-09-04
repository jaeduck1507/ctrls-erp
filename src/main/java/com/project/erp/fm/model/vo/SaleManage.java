package com.project.erp.fm.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class SaleManage {

	private int smNo; // 매출 번호(PK)
	private LocalDate saleDate; // 매출 발생일자
	private int quantity; // 수량
	private int varAmount; // 부가세
	private int totalAmount; // 총액
	private int productCode; // 품목 번호(FK)
	
}
