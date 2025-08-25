package com.project.erp.hrm.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class LeaveInfo {
 
 private int empNo; // emp_no 직원 번호(fk)
 private int leaveId; // leave_id 휴가 신청 번호(pk)
 private LocalDate requestDate; // request_date 신청 날짜
 private String leaveType; // leave_type(연차, 병가, 경조사, 기타)
 private LocalDate startDate; // start_date 휴가 시작일
 private LocalDate endDate; // end_date 휴가 종료일
 private String reason; // 이유
 private String status; // 휴가 상태(대기, 승인, 반려)
 private String empName; // emp_name 직원이름
 private String deptName;//dept_Name 부서
 private String jobTitle;// job_title 직급
 private Integer totalDays; // SUM(DATEDIFF(end_date, start_date) + 1) AS ‘total_days’
 private Integer remainDays; // 12 - SUM(DATEDIFF(end_date, start_date) + 1) AS 'remain_days' 
}
