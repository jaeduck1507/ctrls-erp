package com.project.erp.fm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/fm")
@Controller
public class FmPageController {

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
	
	@GetMapping("/transaction")
	public String transaction() {
		return "component/fm/transaction";
	}
	
	@GetMapping("/salary")
	public String salary() {
		return "component/fm/salary";
	}
	
}
