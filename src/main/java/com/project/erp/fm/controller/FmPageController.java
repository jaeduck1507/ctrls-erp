package com.project.erp.fm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.erp.qam.service.ProductNameService;

@RequestMapping("/fm")
@Controller
public class FmPageController {

	@Autowired
	private ProductNameService productNameService;
	
	@GetMapping("/saleManage")
	public String saleManage() {
		return "component/fm/saleManage";
	}
	
	@GetMapping("/purchase")
	public String purchase() {
		return "component/fm/purchase";
	}
	
	@GetMapping("/budget")
	public String budget() {
		return "component/fm/budget";
	}
	
	@GetMapping("/purchaseRegister")
	public String purchaseRegister(Model model) {
		model.addAttribute("productNameList", productNameService.showProductName());
		return "component/fm/purchaseRegister";
	@GetMapping("/transaction")
	public String transaction() {
		return "component/fm/transaction";
	}
	
	@GetMapping("/salary")
	public String salary() {
		return "component/fm/salary";
	}
	
}
