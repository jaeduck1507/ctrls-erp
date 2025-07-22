package com.project.erp.qam.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductName {

    private int productCode;         // 제품 코드 (PK, AUTO_INCREMENT)
    private String productColor;     // 제품 색상
    private String productName;      // 제품 이름
    private int productPrice;        // 판매가
    private int productCost;         // 단가
    private String productCategory;  // 카테고리
}
