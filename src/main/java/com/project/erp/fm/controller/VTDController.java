package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.vo.Transaction;
import com.project.erp.fm.service.TransactionService;
import com.project.erp.hrm.model.vo.Department;
import com.project.erp.hrm.service.DepartmentService;

@Controller
public class VTDController {
	// View Transaction Details
	@Autowired
	private TransactionService transactionService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@ResponseBody
	@PostMapping("/showtrans")
	public List<Transaction> showtrans(Transaction trans){
		return transactionService.showtrans(trans);
	}
	
	@ResponseBody
	@GetMapping("/selectDept")
	public List<Department> showDept() {
		return departmentService.showDept();
	}
	
}
