package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.vo.Purchase;
import com.project.erp.fm.service.PurchaseService;

@Controller
public class PurchaseController {

	@Autowired
	private PurchaseService service;
	
	@ResponseBody
	@GetMapping("/showPurchase")
	public List<Purchase> showPurchase(){
		return service.showPurchase();
	}
	
}
