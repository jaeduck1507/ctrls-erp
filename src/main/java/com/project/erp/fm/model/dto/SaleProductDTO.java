package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class SaleProductDTO {

	private int smNo;
	private LocalDate saleDate;
	private int quantity;
	private int varAmount;
	private int totalAmount;
	private String productName;
	private int productPrice;
	private String productCategory;
	private LocalDate startDate;
	private LocalDate endDate;
	private int dailySales;
	private int saleAmount;
	private String saleMonth;
	private int monthAmount;
	private int monthQuantity;
	private String yearMonth;
	private String saleCategory;
	
}
