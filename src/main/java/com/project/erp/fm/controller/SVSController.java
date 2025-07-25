package com.project.erp.fm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.fm.model.dto.SaleProductDTO;
import com.project.erp.fm.service.SaleManageService;

@Controller
public class SVSController {
	// Select and View Sales
	@Autowired
	private SaleManageService saleManageService;
	
	@ResponseBody
	@PostMapping("/showSaleManage")
	public List<SaleProductDTO> showSaleManage(SaleProductDTO sp) {
		return saleManageService.showSaleManage(sp);
	}
	
}
