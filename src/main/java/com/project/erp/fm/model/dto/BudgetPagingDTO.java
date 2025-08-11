package com.project.erp.fm.model.dto;

import java.util.List;

import com.project.erp.common.model.vo.Paging;

import lombok.Data;

@Data
public class BudgetPagingDTO extends Paging {

	private BudgetDeptDTO budgetDeptDTO;
	private List<BudgetDeptDTO> budgetList;
	
}
