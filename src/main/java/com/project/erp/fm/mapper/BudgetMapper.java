package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.BudgetDeptDTO;
import com.project.erp.fm.model.vo.Budget;

@Mapper
public interface BudgetMapper {

	List<BudgetDeptDTO> showBudget(BudgetDeptDTO bd);
	void budgetRegister(List<Budget> bList);
	void updatePV(Budget budget);
	BudgetDeptDTO searchBudget(BudgetDeptDTO bd);
	void budgetUpdate(Budget budget);
	
}
