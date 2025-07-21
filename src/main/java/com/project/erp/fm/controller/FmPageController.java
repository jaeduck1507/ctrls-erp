package com.project.erp.fm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/fm")
@Controller
public class FmPageController {

	@GetMapping("/saleManage")
	public String saleManage() {
		return "component/fm/saleManage";
	}
	
}
