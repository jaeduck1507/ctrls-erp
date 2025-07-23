package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.vo.Budget;
import com.project.erp.fm.service.BudgetService;
import com.project.erp.hrm.model.vo.Department;
import com.project.erp.hrm.service.DepartmentService;

@Controller
public class SVBController {
	// Select and View Budget
	@Autowired
	private BudgetService budgetService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@ResponseBody
	@PostMapping("/showBudget")
	public List<Budget> showBudget(Budget budget) {
		return budgetService.showBudget(budget);
	}
	
	@ResponseBody
	@GetMapping("/showDeptName")
	public List<Department> showDept() {
		return departmentService.showDept();
	}
	
}
