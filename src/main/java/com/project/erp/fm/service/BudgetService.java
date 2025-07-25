package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.BudgetMapper;
import com.project.erp.fm.model.dto.BudgetDeptDTO;

@Service
public class BudgetService implements BudgetMapper {

	@Autowired
	private BudgetMapper mapper;

	@Override
	public List<BudgetDeptDTO> showBudget(BudgetDeptDTO bd) {
		return mapper.showBudget(bd);
	}
}
