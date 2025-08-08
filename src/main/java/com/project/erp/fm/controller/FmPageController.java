package com.project.erp.fm.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.erp.fm.model.dto.BudgetDeptDTO;
import com.project.erp.fm.service.BudgetService;
import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.mapper.BonusMapper;
import com.project.erp.hrm.service.DepartmentService;
import com.project.erp.hrm.service.EmployeeInfoService;
import com.project.erp.hrm.service.JobPositionService;
import com.project.erp.qam.service.BrandService;
import com.project.erp.qam.service.ProductNameService;

@RequestMapping("/fm")
@Controller
public class FmPageController {

	@Autowired
	private ProductNameService productNameService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private BudgetService budgetServive;

	@Autowired
	private EmployeeInfoService employeeInfoService;
	
	@Autowired
	private BonusMapper bonusMapper;
	
	@Autowired
	private JobPositionService jobPositionService;
	
	@Autowired
	private BrandService brandService;
	
	@GetMapping("/saleManage")
	public String saleManage(Model model) {
		model.addAttribute("categoryList", productNameService.selectCategory());
		return "component/fm/saleManage";
	}
	
	@GetMapping("/purchase")
	public String purchase(Model model) {
		model.addAttribute("categoryList", productNameService.selectCategory());
		//System.out.println(productNameService.selectCategory());
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
		model.addAttribute("brandList", brandService.findBrand());
		//System.out.println(brandService.findBrand());
		model.addAttribute("today", LocalDate.now().toString());
		//System.out.println(LocalDate.now().toString());
		return "component/fm/purchaseRegister";
	}	
		
	@GetMapping("/transaction")
	public String transaction(Model model, Paging paging) {
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
	
	@GetMapping("/saleRegister")
	public String saleRegister() {
		return "component/fm/saleRegister";
	}
	
	@GetMapping("/transRegister")
	public String transRegister(Model model) {
		model.addAttribute("department", departmentService.showDept());
		return "component/fm/transRegister";
	}
	
	@GetMapping("/budgetUpdate")
	public String budgetUpdate(Model model, BudgetDeptDTO bd) {
		model.addAttribute("budgetInfo", budgetServive.searchBudget(bd));
		return "component/fm/budgetUpdate";
	}
	
	@GetMapping("/addBonusPayment")
	public String addBonusPayment(Model model) {
		model.addAttribute("empInfo", employeeInfoService.showEmployee());
		model.addAttribute("bonus", bonusMapper.showBonusAll());
		return "component/fm/addBonusPayment";
	}
	
	@GetMapping("/showBonusPayment")
	public String showBonusPayment(Model model) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("jobPosition", jobPositionService.showJob());
		return "component/fm/showBonusPayment";
	}
	
	@GetMapping("/salaryPayment")
	public String salaryPayment(Model model) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("jobPosition", jobPositionService.showJob());
		return "component/fm/salaryPayment";
	}
	
}
