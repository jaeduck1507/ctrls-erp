package com.project.erp.hrm.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor @NoArgsConstructor @Data
public class PerformanceReview {
	private int reviewId;
	private int empNo;
	private int evaluatorEmpNo;
	private LocalDate reviewDate;
	private int attitudeScore;
	private int achieveScore;
	private String comments;
	
}
