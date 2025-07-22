package com.project.erp.fm.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Transaction {

	private int transNo; // 거래 번호(PK)
	private String transType; // 수입/지출
	private int transAmount; // 금액
	private String category; // 분류
	private String transDesc; // 수입/지출 내역 상세
	private LocalDate transDate; // 수입/지출 발생 일자
	
	private String deptName; // 부서 이름
	
}
