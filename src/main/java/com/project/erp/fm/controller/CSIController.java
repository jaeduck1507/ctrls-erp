package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.dto.BonusPaymentDTO;
import com.project.erp.fm.model.dto.SalEmpDTO;
import com.project.erp.fm.model.dto.SalaryAlreadyAddDTO;
import com.project.erp.fm.model.dto.SalaryDTO;
import com.project.erp.fm.model.vo.BonusPayment;
import com.project.erp.fm.model.vo.Salary;
import com.project.erp.fm.service.BonusPaymentService;
import com.project.erp.fm.service.SalaryService;
import com.project.erp.hrm.model.dto.EmpInfo;

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
	
	@ResponseBody
	@PostMapping("/showBonusPayment")
	public List<BonusPaymentDTO> showBonusPayment(@RequestBody EmpInfo empInfo) {
		return bonusPaymentService.showBonusPayment(empInfo);
	}
	
	@ResponseBody
	@PostMapping("/salaryPayment")
	public List<SalaryDTO> salaryPayment(SalaryAlreadyAddDTO saaDto) {
		
		return salaryService.salaryPayment(saaDto);
	}
	
	@ResponseBody
	@PostMapping("/addSalaryPayment")
	public boolean addSalaryPayment(@RequestBody List<Salary> spList) {
		salaryService.addSalaryPayment(spList);
		return true;
	}
	
}
