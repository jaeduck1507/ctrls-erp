package com.project.erp.qam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/qam")
@Controller
public class QamPageController {
	
	@GetMapping("/product")
	public String product() {
		return "component/qam/product";
	}
	
	@GetMapping("/productName")
	public String productName() {
		return "component/qam/productName";
	}
	
//	@GetMapping("/qc")
//	public String qc() {
//		return "component/qam/qc";
//	} // QIPController에서 중복 다루기에 여기는 주석처리 (Model 사용 위해 옮김)
	
	@GetMapping("/saleReady")
	public String saleReady() {
		return "component/qam/saleReady";
	}
	
	@GetMapping("/saleDone")
	public String saleDone() {
		return "component/qam/saleDone";
	}
	
	@GetMapping("/defective")
	public String defective() {
		return "component/qam/defective";
	}
	
}