package com.project.erp.fm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.erp.fm.model.dto.TransDTO;
import com.project.erp.fm.model.dto.TransPagingDTO;
import com.project.erp.fm.model.vo.Transaction;

@Mapper
public interface TransactionMapper {

	List<TransDTO> showtrans(TransDTO trans);
	List<TransDTO> showtransPage(TransPagingDTO transPaging);
	int totalTransPage(TransDTO trans);
	void transRegister(List<Transaction> tList);
	List<TransDTO> monthIncomeChart();
	List<TransDTO> monthExpensesChart();
	
}
