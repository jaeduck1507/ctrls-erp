package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.vo.Budget;
import com.project.erp.fm.service.BudgetService;

@Controller
public class BudgetController {

	@Autowired
	private BudgetService service;
	
	@ResponseBody
	@GetMapping("/showBudget")
	public List<Budget> showBudget() {
		return service.showBudget();
	}
	
}
