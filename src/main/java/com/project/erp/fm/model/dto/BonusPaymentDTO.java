package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class BonusPaymentDTO {
	private int bonusPaymentNo;
	private int payment;
	private LocalDate payDate;
	private int bonusNo;
	private int empNo;
	private String empName;
	private String deptName;
	private String jobTitle;
	private String bonusName;
}
