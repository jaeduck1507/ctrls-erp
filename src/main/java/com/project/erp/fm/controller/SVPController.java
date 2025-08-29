package com.project.erp.fm.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.model.dto.PurDeptDTO;
import com.project.erp.fm.model.dto.PurchasePagingDTO;
import com.project.erp.fm.model.vo.Purchase;
import com.project.erp.fm.model.vo.Transaction;
import com.project.erp.fm.service.PurchaseService;
import com.project.erp.fm.service.TransactionService;
import com.project.erp.hrm.model.vo.Department;
import com.project.erp.hrm.service.DepartmentService;
import com.project.erp.qam.service.ProductService;

@Controller
public class SVPController {
	// Select View and Purchase
	@Autowired
	private PurchaseService purchaseService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private TransactionService transactionService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@ResponseBody
	@PostMapping("/showPurchase")
	public PurchasePagingDTO showPurchase(PurDeptDTO pd, Paging paging) {
		return purchaseService.showPurchasePaging(pd, paging);
	}
	
	@ResponseBody
	@PostMapping("/purchaseRegister")
	public boolean purchaseRegister(@RequestBody List<Purchase> prList) {
		productService.productBatchSetter(prList);
		purchaseService.purchaseRegister(prList);
		System.out.println(prList);
		
		List<Department> deptList = departmentService.showDept();
		int purchaseDept = 0;
		for (Department dept : deptList) {
			if (dept.getDeptName().contains("본부")) {
				purchaseDept = dept.getDeptNo();
			}
		}
		
		int brand = prList.get(0).getBrandCode();
		LocalDate checkDate = prList.get(0).getPurchaseDate();
		
		PurDeptDTO dto = new PurDeptDTO();
		dto.setBrandCode(brand);
		dto.setPurchaseDate(checkDate);
		
		List<PurDeptDTO> totalList = purchaseService.totalPurchase(dto);
		
		List<Transaction> transactionList = new ArrayList<>();
		
		for (PurDeptDTO purDept : totalList) {
			Transaction transaction = new Transaction();
			transaction.setTransType("지출");
			transaction.setTransAmount(purDept.getTotalPurchase());
			transaction.setCategory("매입 비용");
			transaction.setTransDesc(purDept.getBrandName() + " 제품 매입");
			transaction.setTransDate(purDept.getPurchaseDate());
			transaction.setDeptNo(purchaseDept);
			transactionList.add(transaction);
		}
		transactionService.transRegister(transactionList);
		return true;
	}
	
	@PostMapping("/totalPurchase")
	public List<PurDeptDTO> totalPurchase(PurDeptDTO pd) {
		return purchaseService.totalPurchase(pd);
	}
	
	
}
