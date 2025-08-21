package com.project.erp.qam.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class SaleReadyForListDTO {
	private int productNo; // 판매된 제품 번호 (FK, product.product_no)
	private int productCode;
	private int productPrice;
	
    private int saleNo; // 판매 고유 번호 (PK, AUTO_INCREMENT)
    private LocalDate saleDate; // 판매일 (초기에는 NULL, 판매 시점에 업데이트)
    private LocalDate startDate;
    private LocalDate endDate;
    
    private String productCategory;
    private String productName;
    private int quantity;
	
    // brand
    private int brandCode;
    private String brandName;
}
