package com.project.erp.fm.service;

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
		//paging.setOffset(paging.getLimit() * (paging.getPage() - 1));
		return transactionMapper.showtransPage(transPaging);
	}
	
	public int totalTrans(TransDTO trans) {
		return transactionMapper.totalTrans(trans);
	}
	
	public TransPagingDTO showTransPaging(TransDTO trans, Paging paging) {
		TransPagingDTO transPagingDTO = new TransPagingDTO();
		transPagingDTO.setTransDTO(trans);
		transPagingDTO.setOffset(paging.getLimit() * (paging.getPage() - 1));
		transPagingDTO.setTransList(showtransPage(transPagingDTO));
		transPagingDTO.setPage(paging.getPage());
		transPagingDTO.setTotal(totalTrans(trans));
		return transPagingDTO;
	}
	
	public void transRegister(List<Transaction> tList) {
		transactionMapper.transRegister(tList);		
	}
	
}
