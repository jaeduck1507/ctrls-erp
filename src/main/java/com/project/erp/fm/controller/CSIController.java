package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.dto.SalEmpDTO;
import com.project.erp.fm.model.vo.BonusPayment;
import com.project.erp.fm.service.BonusPaymentService;
import com.project.erp.fm.service.SalaryService;

@Controller
public class CSIController {
	// Check Salary Information
	@Autowired
	private SalaryService salaryService;
	
	@Autowired
	private BonusPaymentService bonusPaymentService; 
	
	@ResponseBody
	@PostMapping("/showSalary")
	public List<SalEmpDTO> showSalary(SalEmpDTO se) {
		return salaryService.showSalary(se);
	}
	
	@ResponseBody
	@PostMapping("/addBonusPayment")
	public void addBonusPayment(@RequestBody List<BonusPayment> bList) {
		System.out.println(bList);
		bonusPaymentService.addBonusPayment(bList);
	}
	
}
