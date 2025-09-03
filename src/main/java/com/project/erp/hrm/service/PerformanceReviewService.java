package com.project.erp.hrm.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

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
		PerformanceReviewDTO prDto = new PerformanceReviewDTO();
		empinfo.setYear(LocalDate.now().getYear());
		prDto.setEmpList(performanceReviewMapper.showEvalEmp(empinfo));
		prDto.getEmpList().add(empinfo);
		prDto.setDeptNo(empinfo.getDeptNo());
		return employeeInfoService.showNotEvalEmp(prDto);
	}
	
	public PerformanceReviewDTO showEval(PerformanceReviewDTO prDto) {
		PerformanceReviewDTO pr = performanceReviewMapper.showEval(prDto);
		if(pr == null) return pr;
		pr.setCommentsList(showCommnetsList(prDto));
		return pr;
	}
	
	public List<String> showCommnetsList(PerformanceReviewDTO prDto) {

		List<String> list = new ArrayList<String>();
		List<PerformanceReviewDTO> prList = performanceReviewMapper.showCommnetsList(prDto);
		if(prList.size() == 0) return list;
		
		for(PerformanceReviewDTO p : prList) {
			list.add(p.getComments());
		}
		
		return list;
	}
}
