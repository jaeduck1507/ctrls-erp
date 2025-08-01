package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.dto.BudgetDeptDTO;
import com.project.erp.fm.model.vo.Budget;
import com.project.erp.fm.service.BudgetService;

@Controller
public class SVBController {
	// Select and View Budget
	@Autowired
	private BudgetService budgetService;
	
	@ResponseBody
	@PostMapping("/showBudget")
	public List<BudgetDeptDTO> showBudget(BudgetDeptDTO bd, Budget budget) {
		budgetService.updatePV(budget);
		//System.out.println(budgetService.showBudget(bd));
		return budgetService.showBudget(bd);
	}
	
	@ResponseBody
	@PostMapping("/registerBudget")
	public void registerBudget(@RequestBody List<Budget> bList) {
		budgetService.registerBudget(bList);
	}
	
	@PostMapping("/updateBudget")
	public String updateBudget(Budget budget) {
		budgetService.updateBudget(budget);
		return "redirect:/fm/budget";
	}
	
}
