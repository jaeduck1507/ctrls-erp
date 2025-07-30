package com.project.erp.fm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.TransactionMapper;
import com.project.erp.fm.model.dto.TransDTO;
import com.project.erp.fm.model.vo.Transaction;

@Service
public class TransactionService implements TransactionMapper {

	@Autowired
	private TransactionMapper mapper;

	@Override
	public List<TransDTO> showtrans(TransDTO trans) {
		return mapper.showtrans(trans);
	}

	@Override
	public void transRegister(List<Transaction> tList) {
		mapper.transRegister(tList);		
	}
}
