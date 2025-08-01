package com.project.erp.qam.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor
@Data
public class SaleReadyDTO {
	
	private int productNo; // 판매된 제품 번호 (FK, product.product_no)
	private int productCode;
	private int productPrice;
	
    private int saleNo; // 판매 고유 번호 (PK, AUTO_INCREMENT)
    private LocalDate saleDate; // 판매일 (초기에는 NULL, 판매 시점에 업데이트)
    
	
}


