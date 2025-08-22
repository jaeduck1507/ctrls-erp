package com.project.erp.qam.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class DefectiveForListDTO {
	private int defectiveNo; // 불량품 고유 번호 (PK, AUTO_INCREMENT)
	 private int productNo; // 불량품 제품 번호 (FK, product.product_no)
	 private int productCode;
	 private String productCategory;
	 private String checkMaterial;
	 private String checkColor;
	 private String checkDamage;
	 private String productName;
	 private int productPrice;
	 private String reason; // 불량 사유
	 private LocalDate qcDate;
	 
	 private LocalDate startDate;
	 private LocalDate endDate;
	 
	 // defectiveFilter 위해
	 private boolean filterMaterial;
	 private boolean filterColor;
	 private boolean filterDamage;
	 
	 private int brandCode;
	 private String brandName;
}
