package com.project.erp.hrm.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class LeaveRequest {

	private int empNo; // emp_no 직원 번호(fk)
	 private LocalDate requestDate; // request_date 신청 날짜
	 private String leaveType; // leave_type(연차, 병가, 경조사, 기타)
	 private LocalDate startDate; // start_date 휴가 시작일
	 private LocalDate endDate; // end_date 휴가 종료일
	 private String reason; // 사유
}
