package com.project.erp.hrm.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class Department {
	private int deptNo; // 부서번호 PK
	private String deptName; // 부서이름
	private String location; // 위치
}
