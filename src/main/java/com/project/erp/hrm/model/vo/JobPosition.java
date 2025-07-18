package com.project.erp.hrm.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor @NoArgsConstructor @Data
public class JobPosition {
	private int jobNo; // 직급 번호 PK
	private String jobTitle; // 직급명
	private int jobLevel; // 직급 레벨 (낮을수록 상위)
	private int leaveCount; // 직급별 휴가 개수
	private String description; // 직책 설명
}
