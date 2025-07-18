package com.project.erp.qam.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class ProductName { //제품명 테이블: 제품의 색상, 이름, 가격, 카테고리 등 메타데이터를 담는 테이블
 
 private int productCode; // 제품 코드 (PK, AUTO_INCREMENT)
 private String productColor; // 제품 색상 (예: "화이트", "블랙" 등)
 private String productName; // 제품 이름 (예: "기본 반팔티", "청바지")
 private int productPrice; // 제품 가격 (단위: 원)
 private String productCategory; // 제품 카테고리 ('상의' or '하의' or '악세사리' or '신발')

}

