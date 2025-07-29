package com.project.erp.qam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.erp.qam.model.dto.QcResultDTO;
import com.project.erp.qam.service.QcService;


@RequestMapping("/qam")
@Controller
public class QamPageController {
	
	@Autowired
    private QcService qcService;
	
	@GetMapping("/product")
	public String product() {
		return "component/qam/product";
	}
	
	@GetMapping("/productName")
	public String productName() {
		return "component/qam/productName";
	}
	
	@GetMapping("/qc")
	public String qc() {
		return "component/qam/qc";
	}
	
//	@GetMapping("/qcList")
//	public String qcList(Model model) {
//		List<QcResultDTO> list = qcService.showAllQcResults(); // 모든 제품 + QC 결과 포함
//        model.addAttribute("qcList", list);
//        return "component/qam/qcList";
//	}
}