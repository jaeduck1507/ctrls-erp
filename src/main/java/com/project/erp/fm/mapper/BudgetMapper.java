package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.vo.Budget;

@Mapper
public interface BudgetMapper {

	List<Budget> showBudget();
	
}
