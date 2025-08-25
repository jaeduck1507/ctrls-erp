package com.project.erp.hrm.model.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data
public class EmployeeInfo {
	private int empNo; // 직원 번호(PK)
	private String empId; // 로그인용 아이디
	private String empIn; // 주민등록번호(ex : 980708-1011111)
	private String empPwd; // 비밀번호
	private String empName; // 이름
	private int jobNo; // 직급 번호(FK)
	private int deptNo; // 부서 번호(FK)
	private LocalDate hireDate; // 입사일
	private LocalDate quitDate; // 퇴사일
	private int salary; // 기본 급여
	private String addr; // 주소
	private String phone; // 연락처
	private String email; // 이메일
	private String url;
}
