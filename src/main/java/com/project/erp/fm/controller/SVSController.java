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

import com.project.erp.common.model.vo.Paging;
import com.project.erp.fm.model.dto.SaleManagePagingDTO;
import com.project.erp.fm.model.dto.SaleProductDTO;
import com.project.erp.fm.model.vo.SaleManage;
import com.project.erp.fm.model.vo.Transaction;
import com.project.erp.fm.service.SaleManageService;
import com.project.erp.fm.service.TransactionService;
import com.project.erp.hrm.model.vo.Department;
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
	public SaleManagePagingDTO showSaleManage(SaleProductDTO sp, Paging paging) {
		return saleManageService.showSalesPaging(sp, paging);
	}
	
	@ResponseBody
	@PostMapping("/saleRegister")
	public boolean saleRegister(@RequestBody List<SaleManage> smList) {
		saleManageService.saleRegister(smList);
		
		// sale_registered 컬럼 값 'Y'로 업데이트
		LocalDate saleDate = smList.get(0).getSaleDate();
		saleService.updateSaleRegistered(saleDate);
		
		List<Department> deptList = departmentService.showDept();
		int salesDept = 0;
		for (Department dept : deptList) {
			// 부서 이름에 '지점'이 들어가는 부서 번호 조회
			if (dept.getDeptName().contains("지점")) {
				salesDept = dept.getDeptNo();
			}
		}
		
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
			transaction.setTransDesc(formattedDate + " 매출액");
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
	
	@ResponseBody
	@PostMapping("/monthQuantityChart")
	public List<SaleProductDTO> monthQuantityChart(SaleProductDTO sp) {
		return saleManageService.monthQuantityChart(sp);
	}
	
}
