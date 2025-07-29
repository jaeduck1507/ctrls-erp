package com.project.erp.hrm.model.vo;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class AttendanceLog {
	private int attId;
	private int empNo;
	private LocalDate workDate;
	private LocalTime checkIn;
	private LocalTime checkOut;
	private String status;
}
