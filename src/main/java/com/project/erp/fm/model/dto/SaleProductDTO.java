package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class SaleProductDTO {

	private int smNo;
	private LocalDate saleDate;
	private String quantity;
	private int varAmount;
	private int totalAmount;
	private String productName;
	private String productCategory;
	
}
