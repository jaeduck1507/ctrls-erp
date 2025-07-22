package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.vo.Transaction;
import com.project.erp.fm.service.TransactionService;

@Controller
public class VTDController {
	// View Transaction Details
	@Autowired
	private TransactionService service;
	
	@ResponseBody
	@PostMapping("/showtrans")
	public List<Transaction> showtrans(){
		return service.showtrans();
	}
	
}
