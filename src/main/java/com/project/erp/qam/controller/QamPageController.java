package com.project.erp.qam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/qam")
@Controller
public class QamPageController {
	
	@GetMapping("/product")
	public String product() {
//		System.out.println("작동하나?");
		return "component/qam/product";
	}
	
	
}