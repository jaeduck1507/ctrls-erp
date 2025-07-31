package com.project.erp.hrm.model.dto;

import lombok.Data;

@Data
public class AttendanceStatsDTO {
	private int month;
	private int totalCount;
	private int workCount;
	private int lateCount;
	private int leaveEarlyCount;
	private int absenceCount;
	private int leaveCount;
}
