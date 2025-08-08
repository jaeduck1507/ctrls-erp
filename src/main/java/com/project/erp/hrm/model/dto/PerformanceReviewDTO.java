package com.project.erp.hrm.model.dto;

import java.time.LocalDate;
import java.util.List;

import lombok.Data;

@Data
public class PerformanceReviewDTO {
	private int reviewId;
	private int empNo;
	private int evaluatorEmpNo;
	private LocalDate reviewDate;
	private int attitudeScore;
	private int achieveScore;
	private String comments;
	private int deptNo;
	private List<EmpInfo> empList;
}
