package com.project.erp.hrm.model.dto;

import java.time.LocalDate;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
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
	private String date; // 다른 날짜 정보(월,분기,일 등 임시 저장소)
	private MultipartFile file;
	private String url;
}
