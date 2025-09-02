package com.project.erp.fm.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.erp.fm.model.dto.BudgetDeptDTO;
import com.project.erp.fm.service.BudgetService;
import com.project.erp.fm.service.SaleManageService;
import com.project.erp.fm.service.TransactionService;
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
	
	@Autowired
	private SaleManageService saleManageService;
	
	@Autowired
	private TransactionService transactionService;
	
	@Autowired
	private BudgetService budgetService;
	
	@GetMapping("/saleManage")
	public String saleManage(Model model, Paging paging) {
		model.addAttribute("categoryList", productNameService.selectCategory());
		model.addAttribute("weekSalesChart", saleManageService.weekSalesChart());
		model.addAttribute("monthSalesChart", saleManageService.monthSalesChart());
		model.addAttribute("categoryList", productNameService.selectCategory());
		System.out.println(saleManageService.weekSalesChart());
		System.out.println(saleManageService.monthSalesChart());
		model.addAttribute("component","../component/fm/saleManage.jsp");
		return "common/layout";
	}
	
	@GetMapping("/purchase")
	public String purchase(Model model, Paging paging) {
		model.addAttribute("categoryList", productNameService.selectCategory());
		model.addAttribute("brandList", brandService.findBrand(paging));
		//System.out.println(productNameService.selectCategory());
		model.addAttribute("component","../component/fm/purchase.jsp");
		return "common/layout";
	}
	
	@GetMapping("/budget")
	public String budget(Model model, Paging paging) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("balanceList", budgetService.balanceBudget());
		System.out.println(budgetService.balanceBudget());
		model.addAttribute("component","../component/fm/budget.jsp");
		return "common/layout";
	}
	
	@GetMapping("/purchaseRegister")
	public String purchaseRegister(Model model, Paging paging) {
		model.addAttribute("productNameList", productNameService.showProductName(paging));
		model.addAttribute("brandList", brandService.findBrand(paging));
		//System.out.println(brandService.findBrand());
		model.addAttribute("component","../component/fm/purchaseRegister.jsp");
		return "common/layout";
	}	
		
	@GetMapping("/transaction")
	public String transaction(Model model, Paging paging) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("monthTransList", transactionService.monthTransChart());
		model.addAttribute("component","../component/fm/transaction.jsp");
		return "common/layout";
	}
	
	@GetMapping("/salary")
	public String salary(Model model, Paging paging) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("component","../component/fm/salary.jsp");
		return "common/layout";
	}
	
	@GetMapping("/budgetRegister")
	public String budgetRegister(Model model) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("component","../component/fm/budgetRegister.jsp");
		return "common/layout";
	}
	
	@GetMapping("/saleRegister")
	public String saleRegister(Model model) {
		model.addAttribute("component","../component/fm/saleRegister.jsp");
		return "common/layout";
	}
	
	@GetMapping("/transRegister")
	public String transRegister(Model model) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("component","../component/fm/transRegister.jsp");
		return "common/layout";
	}
	
	@GetMapping("/budgetUpdate")
	public String budgetUpdate(Model model, BudgetDeptDTO bd) {
		model.addAttribute("budgetInfo", budgetServive.searchBudget(bd));
		model.addAttribute("component","../component/fm/budgetUpdate.jsp");
		return "common/layout";
	}
	
	@GetMapping("/budgetDelete")
	public String leaveDelete(int budgetNo, Model model) {
		budgetServive.budgetDelete(budgetNo);
		model.addAttribute("component","../component/fm/budget.jsp");
		return "common/layout";
	}
	
	@GetMapping("/addBonusPayment")
	public String addBonusPayment(Model model) {
		model.addAttribute("empInfo", employeeInfoService.showEmployee());
		model.addAttribute("bonus", bonusMapper.showBonusAll());
		model.addAttribute("component","../component/fm/addBonusPayment.jsp");
		return "common/layout";
	}
	
	@GetMapping("/showBonusPayment")
	public String showBonusPayment(Model model, Paging paging) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("jobPosition", jobPositionService.showJob());
		model.addAttribute("component","../component/fm/showBonusPayment.jsp");
		return "common/layout";
	}
	
	@GetMapping("/salaryPayment")
	public String salaryPayment(Model model) {
		model.addAttribute("department", departmentService.showDept());
		model.addAttribute("jobPosition", jobPositionService.showJob());
		model.addAttribute("component","../component/fm/salaryPayment.jsp");
		return "common/layout";
	}
	
}
