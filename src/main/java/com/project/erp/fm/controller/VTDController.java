package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.model.dto.TransDTO;
import com.project.erp.fm.model.dto.TransPagingDTO;
import com.project.erp.fm.model.vo.Transaction;
import com.project.erp.fm.service.TransactionService;

@Controller
public class VTDController {
	// View Transaction Details
	@Autowired
	private TransactionService transactionService;
	
	@ResponseBody
	@PostMapping("/showtrans")
	public TransPagingDTO showtrans(TransDTO trans, Paging paging) {
		return transactionService.showTransPaging(trans, paging);
	}
	
	@ResponseBody
	@PostMapping("/transRegister")
	public boolean transRegister(@RequestBody List<Transaction> tList) {
		transactionService.transRegister(tList);
		return true;
	}
	
}
