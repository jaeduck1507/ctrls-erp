package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.dto.SaleProductDTO;
import com.project.erp.fm.model.vo.SaleManage;
import com.project.erp.fm.service.SaleManageService;
import com.project.erp.qam.model.dto.SaleReadyDTO;
import com.project.erp.qam.service.SaleService;

@Controller
public class SVSController {
	// Select and View Sales
	@Autowired
	private SaleManageService saleManageService;
	
	@Autowired
	private SaleService saleService;
	
	@ResponseBody
	@PostMapping("/showSaleManage")
	public List<SaleProductDTO> showSaleManage(SaleProductDTO sp) {
		return saleManageService.showSaleManage(sp);
	}
	
	@ResponseBody
	@PostMapping("/saleRegister")
	public void saleRegister(@RequestBody List<SaleManage> smList) {
		saleManageService.saleRegister(smList);
	}
	
	@ResponseBody
	@PostMapping("/dailySale")
	public List<SaleReadyDTO> dailySale(SaleReadyDTO dto) {
		return saleService.dailySale(dto);
	}
		
}
