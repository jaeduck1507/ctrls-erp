package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.dto.PurDeptDTO;
import com.project.erp.fm.service.PurchaseService;
import com.project.erp.qam.service.ProductService;

@Controller
public class SVPController {
	// Select View and Purchase
	@Autowired
	private PurchaseService purchaseService;
	
	@Autowired
	private ProductService productService;
	
	@ResponseBody
	@PostMapping("/showPurchase")
	public List<PurDeptDTO> showPurchase(PurDeptDTO pd) {
		return purchaseService.showPurchase(pd);
	}
	
	@ResponseBody
	@PostMapping("/purchaseRegister")
	public void purchaseRegister(@RequestBody List<Purchase> prList) {
		productService.productBatchSetter(prList);
		purchaseService.purchaseRegister(prList);
	}
	
}
