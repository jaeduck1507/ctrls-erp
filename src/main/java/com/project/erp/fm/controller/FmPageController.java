package com.project.erp.fm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.erp.hrm.service.DepartmentService;
import com.project.erp.qam.service.ProductNameService;

@RequestMapping("/fm")
@Controller
public class FmPageController {

	@Autowired
	private ProductNameService productNameService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@GetMapping("/saleManage")
	public String saleManage() {
		return "component/fm/saleManage";
	}
	
	@GetMapping("/purchase")
	public String purchase() {
		return "component/fm/purchase";
	}
	
	@GetMapping("/budget")
	public String budget(Model model) {
		model.addAttribute("department", departmentService.showDept());
		return "component/fm/budget";
	}
	
	@GetMapping("/purchaseRegister")
	public String purchaseRegister(Model model) {
		model.addAttribute("productNameList", productNameService.showProductName());
		return "component/fm/purchaseRegister";
	}	
		
	@GetMapping("/transaction")
	public String transaction(Model model) {
		model.addAttribute("department", departmentService.showDept());
		return "component/fm/transaction";
	}
	
	@GetMapping("/salary")
	public String salary(Model model) {
		model.addAttribute("department", departmentService.showDept());
		return "component/fm/salary";
	}
	
	@GetMapping("/budgetRegister")
	public String budgetRegister(Model model) {
		model.addAttribute("department", departmentService.showDept());
		return "component/fm/budgetRegister";
	}
	
}
