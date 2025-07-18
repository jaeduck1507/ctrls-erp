package com.project.erp.qam.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Qc {

    private int qcCode; // 품질검사 고유 번호 (PK, AUTO_INCREMENT)
    private String checkMaterial; // 부자재 검사 결과 ('합격' or '불합격')
    private String checkColor; // 색상 검사 결과 ('합격' or '불합격')
    private String checkDamage; // 손상 검사 결과 ('합격' or '불합격')
    private String qcDesc; // 품질검사 특이사항 (자유기술)
    private LocalDate qcDate; // 품질검사 일자 (NULL 가능, 예: 2025-07-10)
    private Integer empNo; // 검사자 사원 번호 (FK, employee_info.emp_no / NULL 가능)
    private int productNo; // 검사 대상 제품 번호 (FK, product.product_no)

}
