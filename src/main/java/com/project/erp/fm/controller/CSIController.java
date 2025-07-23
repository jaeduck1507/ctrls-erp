package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.dto.SalEmpDTO;
import com.project.erp.fm.service.SalaryService;

@Controller
public class CSIController {
	// Check Salary Information
	@Autowired
	private SalaryService salaryService;
	
	@ResponseBody
	@PostMapping("/showSalary")
	public List<SalEmpDTO> showSalary(SalEmpDTO se) {
		return salaryService.showSalary(se);
	}
	
}
