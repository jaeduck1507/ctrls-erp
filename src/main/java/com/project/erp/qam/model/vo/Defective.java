package com.project.erp.qam.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Defective { //불량품 테이블: 품질검사에서 불합격 처리된 제품을 기록

 private int defectiveNo; // 불량품 고유 번호 (PK, AUTO_INCREMENT)
 private int productNo; // 불량품 제품 번호 (FK, product.product_no)

}