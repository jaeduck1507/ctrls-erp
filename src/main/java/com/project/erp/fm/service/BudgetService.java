package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.BudgetMapper;
import com.project.erp.fm.model.dto.BudgetDeptDTO;
import com.project.erp.fm.model.vo.Budget;

@Service
public class BudgetService implements BudgetMapper {

	@Autowired
	private BudgetMapper mapper;

	@Override
	public List<BudgetDeptDTO> showBudget(BudgetDeptDTO bd) {
		return mapper.showBudget(bd);
	}

	@Override
	public void registerBudget(List<Budget> bList) {
		mapper.registerBudget(bList);
	}

	@Override
	public void updatePV(Budget budget) {
		mapper.updatePV(budget);		
	}

	@Override
	public BudgetDeptDTO searchBudget(BudgetDeptDTO bd) {
		return mapper.searchBudget(bd);
	}
	
	@Override
	public void updateBudget(Budget budget) {
		mapper.updateBudget(budget);		
	}
	
}
