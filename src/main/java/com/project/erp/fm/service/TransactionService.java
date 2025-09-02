package com.project.erp.fm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.mapper.TransactionMapper;
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
		transactionMapper.transRegister(tList);		
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
		//System.out.println("incomeList : " + incomeList);
		//System.out.println("expensesList : " + expensesList);
		
		List<TransDTO> monthTransList = incomeList;
		/*
		for (int i = 0; i < monthTransList.size(); i++) {
			if (monthTransList.get(i).getTransMonth().equals(expensesList.get(i).getTransMonth())) {
				monthTransList.get(i).setMonthExpenses(expensesList.get(i).getMonthExpenses());
			}
		}*/
		
		for (TransDTO income : monthTransList) {
		    for (TransDTO expense : expensesList) {
		        if (income.getTransMonth().equals(expense.getTransMonth())) {
		            income.setMonthExpenses(expense.getMonthExpenses());
		            break;
		        }
		    }
		}
		
		//System.out.println("monthTransList : " + monthTransList);
		return monthTransList;
	}
	
}
