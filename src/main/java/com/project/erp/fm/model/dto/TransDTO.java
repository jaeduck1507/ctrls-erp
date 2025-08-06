package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class TransDTO {

	private int transNo;
	private String transType;
	private int transAmount;
	private String category;
	private String transDesc;
	private LocalDate transDate;
	private int deptNo;
	private String deptName;
	private LocalDate startDate;
	private LocalDate endDate;
	
}
