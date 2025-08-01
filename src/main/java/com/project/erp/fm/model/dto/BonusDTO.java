package com.project.erp.fm.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class BonusDTO {
	private int bonusNo;
	private String bonusName;
	private String bonusDesc;
	private int bonusPaymentNo;
	private int payment;
	private LocalDate payDate;
	private int empNo;
}
