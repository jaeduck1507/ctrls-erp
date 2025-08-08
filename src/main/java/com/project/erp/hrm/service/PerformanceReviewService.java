package com.project.erp.hrm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.PerformanceReviewMapper;
import com.project.erp.hrm.model.dto.EmpInfo;
import com.project.erp.hrm.model.dto.PerformanceReviewDTO;
import com.project.erp.hrm.model.vo.PerformanceReview;

@Service
public class PerformanceReviewService {

	@Autowired
	private PerformanceReviewMapper performanceReviewMapper;
	
	@Autowired
	private EmployeeInfoService employeeInfoService;
	
	public void empEval(PerformanceReview pr) {
		performanceReviewMapper.empEval(pr);
		
	}
	
	public List<EmpInfo> showEvalEmp(EmpInfo empinfo) {
//		System.out.println(performanceReviewMapper.showEvalEmp(empinfo));
		PerformanceReviewDTO prDto = new PerformanceReviewDTO();
		prDto.setEmpList(performanceReviewMapper.showEvalEmp(empinfo));
		prDto.setDeptNo(empinfo.getDeptNo());
//		System.out.println(employeeInfoService.showNotEvalEmp(prDto));
		return employeeInfoService.showNotEvalEmp(prDto);
	}
}
