package com.project.erp.fm.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class BonusPayment {
	private int bonusPaymentNo;
	private int payment;
	private LocalDate payDate;
	private int bonusNo;
	private int empNo;
}
