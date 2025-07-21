package com.project.erp.fm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.erp.fm.mapper.TransactionMapper;

@Service
public class TransactionService implements TransactionMapper {

	@Autowired
	private TransactionMapper mapper;
}
