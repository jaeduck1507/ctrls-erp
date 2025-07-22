package com.project.erp.qam.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; 
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping; 
import org.springframework.web.bind.annotation.RequestParam; 
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.erp.qam.model.vo.Product;
import com.project.erp.qam.model.vo.ProductName;
import com.project.erp.qam.service.ProductNameService;
import com.project.erp.qam.service.ProductService;

@Controller
public class PIMController {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private ProductNameService productNameService;
	
	@ResponseBody
	@GetMapping("/showProduct")
	public List<Product> showProduct() {
		return productService.showProduct();
	}
	
	@ResponseBody
	@GetMapping("/showProductName")
	public List<ProductName> showProductName() {
		return productNameService.showProductName();
	}

	@GetMapping("/productNameForm")
	public String showForm(@RequestParam(required = false) Integer productCode, Model model) {
		if (productCode != null) {
			ProductName productName = productNameService.findById(productCode);
			model.addAttribute("productName", productName);
			model.addAttribute("action", "/updateProductName");
		} else {
			model.addAttribute("productName", new ProductName());
			model.addAttribute("action", "/registerProductName");
		}
		return "component/qam/productNameForm"; 
	}

	@PostMapping("/registerProductName")
	public String register(ProductName productName) {
		productNameService.insertProductName(productName);
		return "redirect:/qam/productName";
	}

	@PostMapping("/updateProductName")
	public String update(ProductName productName) {
		productNameService.updateProductName(productName);
		return "redirect:/qam/productName";
	}
	
	@GetMapping("/deleteProductName")
	public String delete(@RequestParam int productCode) {
		productNameService.deleteProductName(productCode);
		return "redirect:/qam/productName";
	}
	
	@GetMapping("/searchProductName")
	@ResponseBody
	public List<ProductName> searchProductName(
	        @RequestParam(required = false) String productName,
	        @RequestParam(required = false) String productCategory) {

	    return productNameService.searchProductName(productName, productCategory);
	}

}
