package com.project.erp.hrm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.hrm.model.vo.PerformanceReview;
import com.project.erp.hrm.service.PerformanceReviewService;

@Controller
public class PEMController {
	
	@Autowired
	private PerformanceReviewService performanceReviewService;
	
	@ResponseBody
	@PostMapping("/empEval")
	public void empEval(@RequestBody PerformanceReview pr) {
		System.out.println(pr);
		performanceReviewService.empEval(pr);
	}
}
