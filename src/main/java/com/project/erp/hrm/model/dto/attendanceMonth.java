package com.project.erp.hrm.model.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class attendanceMonth {
	private int empNo;
	private String yearMonth;
	private LocalDate startDate;
	private LocalDate endDate;
}
