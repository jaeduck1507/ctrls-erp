package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class PurDeptDTO {

	private int purchaseNo;
	private int unitPrice;
	private int quantity;
	private int varAmount;
	private int totalAmount;
	private LocalDate purchaseDate;
	private String productName;
	private String productCategory;
	private int brandCode;
	private String brandName;
	private LocalDate startDate;
	private LocalDate endDate;
	private int totalPurchase;
	
}
