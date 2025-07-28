package com.project.erp.hrm.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class LeaveDays {

	private int empNo; //emp_no(PK)
	private String empName; // emp_name
	private String deptName; // dept_name
	private String jobTitle; // job_title
	private LocalDate totalDays; // SUM(DATEDIFF(end_date, start_date) + 1) AS ‘사용 휴가일 수’
	private LocalDate remainDays; //  lr.lr_count AS '남은 휴가일 수'
}
