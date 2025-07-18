package com.project.erp.qam.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Product { //제품 테이블: 실제 생산된 개별 제품의 정보를 관리하는 테이블
	
 private int productNo; // 제품 고유 번호 (PK, AUTO_INCREMENT)
 private LocalDate productionDate; // 제품 생산일 (예: 2025-07-01)
 private int productCode; // 제품 코드 (FK, product_name.product_code 참조)

}

