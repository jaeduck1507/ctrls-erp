package com.project.erp.fm.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Purchase {

	private int purchaseNo; // 매입 번호(PK)
	private int unitPrice; // 단가
	private int quantity; // 수량
	private int varAmount; // 부가세 총액
	private int totalAmount; // 총액 unit_price * quantity 
	private LocalDate purchaseDate; // 매입일
	private int productNo; // 상품 번호(FK)
	
}
