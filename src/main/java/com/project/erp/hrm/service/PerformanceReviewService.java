package com.project.erp.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.hrm.mapper.PerformanceReviewMapper;
import com.project.erp.hrm.model.vo.PerformanceReview;

@Service
public class PerformanceReviewService {

	@Autowired
	private PerformanceReviewMapper performanceReviewMapper;
	
	public void empEval(PerformanceReview pr) {
		performanceReviewMapper.empEval(pr);
	}
}
