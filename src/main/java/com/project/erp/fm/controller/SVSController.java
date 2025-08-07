package com.project.erp.fm.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.dto.SaleProductDTO;
import com.project.erp.fm.model.vo.SaleManage;
import com.project.erp.fm.model.vo.Transaction;
import com.project.erp.fm.service.SaleManageService;
import com.project.erp.fm.service.TransactionService;
import com.project.erp.hrm.service.DepartmentService;
import com.project.erp.qam.model.dto.SaleReadyDTO;
import com.project.erp.qam.service.SaleService;

@Controller
public class SVSController {
	// Select and View Sales
	@Autowired
	private SaleManageService saleManageService;
	
	@Autowired
	private SaleService saleService;
	
	@Autowired
	private TransactionService transactionService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@ResponseBody
	@PostMapping("/showSaleManage")
	public List<SaleProductDTO> showSaleManage(SaleProductDTO sp) {
		return saleManageService.showSaleManage(sp);
	}
	
	@ResponseBody
	@PostMapping("/saleRegister")
	public boolean saleRegister(@RequestBody List<SaleManage> smList) {
		//System.out.println(smList);
		saleManageService.saleRegister(smList);
		
		//System.out.println(departmentService.showDept().getLast().getDeptNo());
		int salesDept = departmentService.showDept().getLast().getDeptNo(); // department의 마지막 dept_no
		
		LocalDate checkDate = smList.get(0).getSaleDate();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 M월 d일");
		String formattedDate = checkDate.format(formatter);
		
		SaleProductDTO dto = new SaleProductDTO();
		dto.setSaleDate(checkDate);
		
		List<SaleProductDTO> totalList = saleManageService.totalSales(dto);
		
		List<Transaction> transactionList = new ArrayList<>();
		
		for (SaleProductDTO saleProduct : totalList) {
			Transaction transaction = new Transaction();
			transaction.setTransType("수입");
			transaction.setTransAmount(saleProduct.getDailySales());
			transaction.setCategory("판매 수익");
			transaction.setTransDesc(formattedDate + " 매출");
			transaction.setTransDate(saleProduct.getSaleDate());
			transaction.setDeptNo(salesDept);
			transactionList.add(transaction);
		}
		transactionService.transRegister(transactionList);
		return true;
	}
	
	@ResponseBody
	@PostMapping("/dailySale")
	public List<SaleReadyDTO> dailySale(SaleReadyDTO dto) {
		return saleService.dailySale(dto);
	}
		
}
