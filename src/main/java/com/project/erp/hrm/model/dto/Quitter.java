package com.project.erp.hrm.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Quitter {
	private int empNo;
	private String empName; // 퇴사자 이름
	private LocalDate hireDate; // 퇴사일
	private LocalDate quitDate; // 퇴사일
	private int quitPay; // 퇴직금
	private int salary;
	private LocalDate quitPayDate; // 퇴직금 지급 날짜
	
}
