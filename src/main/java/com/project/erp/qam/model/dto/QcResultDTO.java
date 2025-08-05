package com.project.erp.qam.model.dto;

import java.sql.Date;
import java.time.LocalDate;

import lombok.Data;

@Data
public class QcResultDTO {
    // product
    private int productNo;
    private Date productionDate;

    // product_name
    private int productCode;
    private String productName;
    private String productColor;
    private int productPrice;
    private int productCost;
    private String productCategory;

    // qc (nullable)
    private int qcCode;
    private String checkMaterial;
    private String checkColor;
    private String checkDamage;
    private String qcDesc;
    private Date qcDate;
    private int empNo;
    
	private LocalDate startDate;
	private LocalDate endDate;
    
    // defective
   private int defectiveNo;
   private String reason;
    
    // sale
    private int saleNo;
    private LocalDate saleDate;
  
}
