package com.project.erp.hrm.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class EmpInfo {
	private String empName;
	private String jobTitle; // 직급명
	private String deptName; // 부서이름
}
