package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.mapper.BudgetMapper;
import com.project.erp.fm.model.dto.BudgetDeptDTO;
import com.project.erp.fm.model.dto.BudgetPagingDTO;
import com.project.erp.fm.model.vo.Budget;

@Service
public class BudgetService {

	@Autowired
	private BudgetMapper budgetMapper;

	public List<BudgetDeptDTO> showBudget(BudgetDeptDTO bd) {
		return budgetMapper.showBudget(bd);
	}
	
	public List<BudgetDeptDTO> showBudgetPage(BudgetPagingDTO budgetPaging) {
		return budgetMapper.showBudgetPage(budgetPaging);
	}
	
	public int totalBudgetPage(BudgetDeptDTO bd) {
		return budgetMapper.totalBudgetPage(bd);
	}
	
	public BudgetPagingDTO showBudgetPaging(BudgetDeptDTO bd, Paging paging) {
		BudgetPagingDTO budgetPagingDTO = new BudgetPagingDTO();
		budgetPagingDTO.setBudgetDeptDTO(bd);
		budgetPagingDTO.setOffset(paging.getLimit() * (paging.getPage() - 1));
		budgetPagingDTO.setBudgetList(showBudgetPage(budgetPagingDTO));
		budgetPagingDTO.setPage(paging.getPage());
		budgetPagingDTO.setTotal(totalBudgetPage(bd));
		return budgetPagingDTO;
	}
	
	public void budgetRegister(List<Budget> bList) {
		budgetMapper.budgetRegister(bList);
	}
	
	public void updatePV(Budget budget) {
		budgetMapper.updatePV(budget);		
	}
	
	public BudgetDeptDTO searchBudget(BudgetDeptDTO bd) {
		return budgetMapper.searchBudget(bd);
	}
	
	public void budgetUpdate(Budget budget) {
		budgetMapper.budgetUpdate(budget);		
	}
	
}
