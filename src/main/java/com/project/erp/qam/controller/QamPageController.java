package com.project.erp.qam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.qam.service.ProductService;

@RequestMapping("/qam")
@Controller
public class QamPageController {
	
	
	@GetMapping("/product")
	public String product() {
		
		return "component/qam/product";
	}
	
	
}