// 제품 및 품목 관리(PIM)

package com.project.erp.qam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.qam.model.vo.Product;
import com.project.erp.qam.service.ProductService;

@Controller
public class PIMController {

	@Autowired
	private ProductService productService;
	
	@ResponseBody
	@GetMapping("/showProduct")
	public List<Product> showProduct() {
		return productService.showProduct();
	}
	
	
	
	
	
}
