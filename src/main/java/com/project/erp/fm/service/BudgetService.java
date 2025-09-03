package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.mapper.BudgetMapper;
import com.project.erp.fm.mapper.TransactionMapper;
import com.project.erp.fm.model.dto.BalanceDTO;
import com.project.erp.fm.model.dto.BudgetDeptDTO;
import com.project.erp.fm.model.dto.BudgetPagingDTO;
import com.project.erp.fm.model.vo.Budget;

@Service
public class BudgetService {

	@Autowired
	private BudgetMapper budgetMapper;
	
	@Autowired
	private TransactionMapper transactionMapper;

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
	
	public void budgetDelete(int budgetNo) {
		budgetMapper.budgetDelete(budgetNo);
	}
	
	public List<BalanceDTO> totalBudget() {
		return budgetMapper.totalBudget();
	}
	
	public List<BalanceDTO> balanceBudget() {
		List<BalanceDTO> budgetList = budgetMapper.totalBudget();
		List<BalanceDTO> expensesList = transactionMapper.transExpenses();
		
		List<BalanceDTO> balanceList = budgetList;
		
		for (BalanceDTO budget : balanceList) {
		    for (BalanceDTO expenses : expensesList) {
		        if (budget.getDeptNo() == (expenses.getDeptNo())) {
		        	budget.setExpenses(expenses.getExpenses());
		            break;
		        }
		    }
		}
		
		return balanceList;
	}
	
}
