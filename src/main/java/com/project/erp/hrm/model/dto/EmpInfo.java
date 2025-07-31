package com.project.erp.hrm.model.dto;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class EmpInfo {
	private int empNo;
	private String empName;
	private String empId; // 로그인용 아이디
	private String empIn; // 주민등록번호(ex : 980708-1011111)
	private int deptNo;
	private int jobNo;
	private String jobTitle; // 직급명
	private String deptName; // 부서이름
	private LocalDate hireDate; // 입사일
	private LocalDate quitDate; // 퇴사일
	private int salary; // 기본 급여
	private String addr; // 주소
	private String phone; // 연락처
	private String email; // 이메일
}