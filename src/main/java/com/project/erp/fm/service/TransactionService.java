package com.project.erp.fm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.mapper.TransactionMapper;
import com.project.erp.fm.model.dto.BalanceDTO;
import com.project.erp.fm.model.dto.TransDTO;
import com.project.erp.fm.model.dto.TransPagingDTO;
import com.project.erp.fm.model.vo.Transaction;

@Service
public class TransactionService {

	@Autowired
	private TransactionMapper transactionMapper;

	public List<TransDTO> showtrans(TransDTO trans) {
		return transactionMapper.showtrans(trans);
	}

	public List<TransDTO> showtransPage(TransPagingDTO transPaging) {
		return transactionMapper.showtransPage(transPaging);
	}
	
	public int totalTransPage(TransDTO trans) {
		return transactionMapper.totalTransPage(trans);
	}
	
	public TransPagingDTO showTransPaging(TransDTO trans, Paging paging) {
		TransPagingDTO transPagingDTO = new TransPagingDTO();
		transPagingDTO.setTransDTO(trans);
		transPagingDTO.setOffset(paging.getLimit() * (paging.getPage() - 1));
		transPagingDTO.setTransList(showtransPage(transPagingDTO));
		transPagingDTO.setPage(paging.getPage());
		transPagingDTO.setTotal(totalTransPage(trans));
		return transPagingDTO;
	}
	
	public void transRegister(List<Transaction> tList) {
		List<Transaction> insertList = new ArrayList<>();
		
		for (Transaction trans : tList) {
			if ("기타 비용".equals(trans.getCategory())) {
				insertList.add(trans);
			} else {
				int count = transactionMapper.existTrans(trans);
				if (count > 0) {
					transactionMapper.updateTrans(trans);
				} else {
					insertList.add(trans);
				}
			}
		}
		
		if (!insertList.isEmpty()) {
			transactionMapper.transRegister(insertList);
		}
		
	}
	
	public List<TransDTO> monthIncomeChart() {
		return transactionMapper.monthIncomeChart();
	}
	
	public List<TransDTO> monthExpensesChart() {
		return transactionMapper.monthExpensesChart();
	}
	
	public List<TransDTO> monthTransChart() {
		List<TransDTO> incomeList = monthIncomeChart();
		List<TransDTO> expensesList = monthExpensesChart();
				
		List<TransDTO> monthTransList = incomeList;
				
		for (TransDTO income : monthTransList) {
		    for (TransDTO expense : expensesList) {
		        if (income.getTransMonth().equals(expense.getTransMonth())) {
		            income.setMonthExpenses(expense.getMonthExpenses());
		            break;
		        }
		    }
		}
		
		return monthTransList;
	}
	
	public List<BalanceDTO> transExpenses() {
		return transactionMapper.transExpenses();
	}
	
}
