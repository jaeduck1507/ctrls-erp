package com.project.erp.qam.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class ProductDetailDTO {

    // 제품 테이블 (product) 관련 필드

    private int productNo;          // 제품 고유 번호 (PK - product.product_no)
    private Date productionDate;    // 생산일자 (product.production_date)
    private int productCode;        // 제품명 코드 (product.product_code → product_name.product_code FK)

    // 제품명 테이블 (product_name) 관련 필드
    
    private String productColor;    // 제품 색상
    private String productName;     // 제품 이름
    private int productPrice;       // 판매가
    private int productCost;        // 단가
    private String productCategory; // 카테고리 (상의/하의/악세사리/신발)
    private int brandCode;
    private String brandName;
}
